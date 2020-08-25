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
% Author :   André Wlodarski, student at FG Audiokommunikation, TU Berlin
% Email  :   awlodarski AT gmx DOT de
% Date   :   15-Nov-2008
% Updated:   16-Nov-2008, A.Wlodarski, added logging
% 
% =========================================================================


function varargout = rgt_vp_rating_init(varargin)
% RGT_VP_RATING_INIT M-file for rgt_vp_rating_init.fig
%      RGT_VP_RATING_INIT, by itself, creates a new RGT_VP_RATING_INIT or raises the existing
%      singleton*.
%
%      H = RGT_VP_RATING_INIT returns the handle to a new RGT_VP_RATING_INIT or the handle to
%      the existing singleton*.
%
%      RGT_VP_RATING_INIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RGT_VP_RATING_INIT.M with the given input arguments.
%
%      RGT_VP_RATING_INIT('Property','Value',...) creates a new RGT_VP_RATING_INIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rgt_vp_rating_init_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rgt_vp_rating_init_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rgt_vp_rating_init

% Last Modified by GUIDE v2.5 24-Oct-2008 02:38:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rgt_vp_rating_init_OpeningFcn, ...
                   'gui_OutputFcn',  @rgt_vp_rating_init_OutputFcn, ...
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


% --- Executes just before rgt_vp_rating_init is made visible.
function rgt_vp_rating_init_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rgt_vp_rating_init (see VARARGIN)

% Choose default command line output for rgt_vp_rating_init
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rgt_vp_rating_init wait for user response (see UIRESUME)
% uiwait(handles.fig_rgt_vp_rating_init);

movegui(hObject,'center') 
global TSP PP
set(hObject,'Name',TSP.sections{PP.run_section_line,3});
set(handles.ed_instruction,'String',TSP.sections{PP.run_section_line,4}{1,8});


% --- Outputs from this function are returned to the command line.
function varargout = rgt_vp_rating_init_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function ed_instruction_Callback(hObject, eventdata, handles)
% hObject    handle to ed_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_instruction as text
%        str2double(get(hObject,'String')) returns contents of ed_instruction as a double


% --- Executes during object creation, after setting all properties.
function ed_instruction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_versuchsleiter.
function pb_versuchsleiter_Callback(hObject, eventdata, handles)
% hObject    handle to pb_versuchsleiter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
PP.allowed_to_close=1;
close
PP.allowed_to_close=0;
write_to_log('-');
write_to_log(datestr(clock, 'local'));
%log playlist
write_to_log('element playlist:');
write_to_log(num2str(PP.playlist));
sd_vp


% --- Executes when user attempts to close fig_rgt_vp_triad_exit.
function fig_rgt_vp_triad_exit_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_rgt_vp_triad_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
if PP.allowed_to_close==1
    delete(hObject);
end

