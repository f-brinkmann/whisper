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


function varargout = setup_sessions(varargin)
% SETUP_SESSIONS M-file for setup_sessions.fig
%      SETUP_SESSIONS, by itself, creates a new SETUP_SESSIONS or raises the existing
%      singleton*.
%
%      H = SETUP_SESSIONS returns the handle to a new SETUP_SESSIONS or the handle to
%      the existing singleton*.
%
%      SETUP_SESSIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETUP_SESSIONS.M with the given input arguments.
%
%      SETUP_SESSIONS('Property','Value',...) creates a new SETUP_SESSIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before setup_sessions_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to setup_sessions_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help setup_sessions

% Last Modified by GUIDE v2.5 15-Aug-2008 00:08:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @setup_sessions_OpeningFcn, ...
                   'gui_OutputFcn',  @setup_sessions_OutputFcn, ...
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


% --- Executes just before setup_sessions is made visible.
function setup_sessions_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to setup_sessions (see VARARGIN)

% Choose default command line output for setup_sessions
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Center GUI

movegui(hObject,'center')

% UIWAIT makes setup_sessions wait for user response (see UIRESUME)
% uiwait(handles.fig_setup_sessions);
global TSP
set(handles.ed_number_of_sessions, 'String',TSP.number_of_sessions);

% --- Outputs from this function are returned to the command line.
function varargout = setup_sessions_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function ed_number_of_sessions_Callback(hObject, eventdata, handles)
% hObject    handle to ed_number_of_sessions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_number_of_sessions as text
%        str2double(get(hObject,'String')) returns contents of ed_number_of_sessions as a double


% --- Executes during object creation, after setting all properties.
function ed_number_of_sessions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_number_of_sessions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_save.
function pb_save_Callback(hObject, eventdata, handles)
% hObject    handle to pb_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP
TSP.number_of_sessions=str2num(get(handles.ed_number_of_sessions, 'String'));
save ([PP.path filesep 'TSP.mat'],'TSP');
close


% --- Executes on button press in pb_cancel.
function pb_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close


% --- Executes when user attempts to close fig_setup_sessions.
function fig_setup_sessions_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_setup_sessions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mainmenu

% Hint: delete(hObject) closes the figure
delete(hObject);

