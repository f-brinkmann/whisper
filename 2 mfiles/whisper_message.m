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


function varargout = whisper_message(varargin)
% whisper_message M-file for whisper_message.fig
%      whisper_message, by itself, creates a new whisper_message or raises the existing
%      singleton*.
%
%      H = whisper_message returns the handle to a new whisper_message or the handle to
%      the existing singleton*.
%
%      whisper_message('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in whisper_message.M with the given input arguments.
%
%      whisper_message('Property','Value',...) creates a new whisper_message or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before whisper_message_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to whisper_message_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help whisper_message

% Last Modified by GUIDE v2.5 01-Oct-2013 17:25:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @whisper_message_OpeningFcn, ...
                   'gui_OutputFcn',  @whisper_message_OutputFcn, ...
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


% --- Executes just before whisper_message is made visible.
function whisper_message_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to whisper_message (see VARARGIN)

% Choose default command line output for whisper_message
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes whisper_message wait for user response (see UIRESUME)
% uiwait(handles.fig_whisper_message);

movegui(hObject,'center')
global PP
set(handles.txt_whisper_message,'String', PP.whisper_message);


% --- Outputs from this function are returned to the command line.
function varargout = whisper_message_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_OK.
function pb_OK_Callback(hObject, eventdata, handles)
% hObject    handle to pb_OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close


% --- Executes during object creation, after setting all properties.
function txt_whisper_message_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_whisper_message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function txt_whisper_message_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to txt_whisper_message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over txt_whisper_message.
function txt_whisper_message_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to txt_whisper_message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function fig_message_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fig_message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

