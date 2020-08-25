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
%
% =========================================================================


function varargout = setup_plotting(varargin)
% SETUP_PLOTTING M-file for setup_plotting.fig
%      SETUP_PLOTTING, by itself, creates a new SETUP_PLOTTING or raises the existing
%      singleton*.
%
%      H = SETUP_PLOTTING returns the handle to a new SETUP_PLOTTING or the handle to
%      the existing singleton*.
%
%      SETUP_PLOTTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETUP_PLOTTING.M with the given input arguments.
%
%      SETUP_PLOTTING('Property','Value',...) creates a new SETUP_PLOTTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before setup_plotting_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to setup_plotting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help setup_plotting

% Last Modified by GUIDE v2.5 09-Nov-2008 01:01:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @setup_plotting_OpeningFcn, ...
                   'gui_OutputFcn',  @setup_plotting_OutputFcn, ...
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


% --- Executes just before setup_plotting is made visible.
function setup_plotting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to setup_plotting (see VARARGIN)

% Choose default command line output for setup_plotting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes setup_plotting wait for user response (see UIRESUME)
% uiwait(handles.fig_setup_plotting);
movegui(hObject,'center')
global PS
set(handles.cb_fig,'Value',PS.plotting{1,1}(1,1))
set(handles.cb_eps,'Value',PS.plotting{1,1}(1,2))
set(handles.cb_png,'Value',PS.plotting{1,1}(1,3))
set(handles.cb_pdf,'Value',PS.plotting{1,1}(1,4))


% --- Outputs from this function are returned to the command line.
function varargout = setup_plotting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in cb_fig.
function cb_fig_Callback(hObject, eventdata, handles)
% hObject    handle to cb_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_fig
global PS
PS.plotting{1,1}(1,1)=get(handles.cb_fig,'Value');


% --- Executes on button press in cb_eps.
function cb_eps_Callback(hObject, eventdata, handles)
% hObject    handle to cb_eps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_eps
global PS
PS.plotting{1,1}(1,2)=get(handles.cb_eps,'Value');


% --- Executes on button press in cb_png.
function cb_png_Callback(hObject, eventdata, handles)
% hObject    handle to cb_png (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_png
global PS
PS.plotting{1,1}(1,3)=get(handles.cb_png,'Value');


% --- Executes on button press in cb_pdf.
function cb_pdf_Callback(hObject, eventdata, handles)
% hObject    handle to cb_pdf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_pdf
global PS
PS.plotting{1,1}(1,4)=get(handles.cb_pdf,'Value');


% --- Executes on button press in pb_save.
function pb_save_Callback(hObject, eventdata, handles)
% hObject    handle to pb_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PS
save ('PS.mat','PS');
close
mainmenu


% --- Executes on button press in pb_cancel.
function pb_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close


% --- Executes when user attempts to close fig_setup_plotting.
function fig_setup_plotting_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_setup_plotting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
mainmenu

