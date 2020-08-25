% =========================================================================
% Copyright (c) 2008-2014 Audio Communication Group, TU Berlin
% 
% This file is part of WhisPER, a package of interacting MATLAB scripts for 
% designing and controlling experiments in the field of auditory perceptive 
% measurement and evaluation.
% 
% WhisPER is free software: you can redistribute it and/or modify it under 
% the terms of the GNU General Public License as published by the Free 
% Software Foundation, either version 3 of the License, or (at your option) 
% any later version. 
% 
% WhisPER is distributed in the hope that it will be useful, but WITHOUT ANY 
% WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS 
% FOR A PARTICULAR PURPOSE.
% See the GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along 
% with this program. If not, see <http://www.gnu.org/licenses/>. 
% 
% http://www.ak.tu-berlin.de/whisper/ 
% =========================================================================
% 
% This file:
%
% Author :   Martina Vrhovnik and Fabian Brinkmann,
%            Audio Communication Group, TU Berlin
% Email  :   fabian.brinkmann at tu-berlin dot de
% Date   :   Oct. 2013
% Updated: 
%             
% =========================================================================

function varargout = saqi_vp_3(varargin)
% SAQI_VP_3 MATLAB code for saqi_vp_3.fig
%      SAQI_VP_3, by itself, creates a new SAQI_VP_3 or raises the existing
%      singleton*.
%
%      H = SAQI_VP_3 returns the handle to a new SAQI_VP_3 or the handle to
%      the existing singleton*.
%
%      SAQI_VP_3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAQI_VP_3.M with the given input arguments.
%
%      SAQI_VP_3('Property','Value',...) creates a new SAQI_VP_3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before saqi_vp_3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to saqi_vp_3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help saqi_vp_3

% Last Modified by GUIDE v2.5 21-Jul-2014 14:58:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @saqi_vp_3_OpeningFcn, ...
                   'gui_OutputFcn',  @saqi_vp_3_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before saqi_vp_3 is made visible.
function saqi_vp_3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to saqi_vp_3 (see VARARGIN)

% Choose default command line output for saqi_vp_3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes saqi_vp_3 wait for user response (see UIRESUME)
% uiwait(handles.saqi_vp_3);

movegui(hObject,'center');

global TSP PP tmp_current_id tmp_current_item

% increase counter that saves the current item
% (in this file tmp variables are used because the real variables are set
% in the rating screen because that is the only screen that always shows up
% independed from the user settings)
% (1 = overall difference, 2,3,... items)
tmp_current_id   = PP.current_id +1;
tmp_current_item = TSP.sections{PP.run_section_line,4}{1,4}{tmp_current_id};

% Figure display name
set(hObject,'Name',['Quality ' num2str(tmp_current_id) '/' num2str(PP.number_of_items) ' (' TSP.sections{PP.run_section_line,2} ')']);

%set item
set(handles.txt_item, 'String', TSP.sections{PP.run_section_line,4}{1,6}{tmp_current_item,2});
% set definition
set(handles.txt_umschreibung, 'String', TSP.sections{PP.run_section_line,4}{1,14}{tmp_current_item,2});



% --- Outputs from this function are returned to the command line.
function varargout = saqi_vp_3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_ok.
function pb_ok_Callback(hObject, eventdata, handles)
% hObject    handle to pb_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP

% close current window
PP.allowed_to_close = 1;
close
PP.allowed_to_close = 0;

saqi_vp_1; % multiple stimulus SAQI


% --- Executes when user attempts to close saqi_vp_3.
function saqi_vp_3_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to saqi_vp_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
global PP
if PP.allowed_to_close==1
    delete(hObject);
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over txt_item.
function txt_item_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to txt_item (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tmp_current_item
if tmp_current_item == 29
    subplot('position', [.835 .795 .2 .2])
    data = imread('Frank_Knackig.JPG');
    h = image(data);
    axis equal
    axis tight
    set(gca, 'xTick', [], 'yTick', [])
    box on
end
