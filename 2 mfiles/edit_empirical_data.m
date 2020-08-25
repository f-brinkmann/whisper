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


function varargout = edit_empirical_data(varargin)
% EDIT_EMPIRICAL_DATA M-file for edit_empirical_data.fig
%      EDIT_EMPIRICAL_DATA, by itself, creates a new EDIT_EMPIRICAL_DATA or raises the existing
%      singleton*.
%
%      H = EDIT_EMPIRICAL_DATA returns the handle to a new EDIT_EMPIRICAL_DATA or the handle to
%      the existing singleton*.
%
%      EDIT_EMPIRICAL_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDIT_EMPIRICAL_DATA.M with the given input arguments.
%
%      EDIT_EMPIRICAL_DATA('Property','Value',...) creates a new EDIT_EMPIRICAL_DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before edit_empirical_data_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to edit_empirical_data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help edit_empirical_data

% Last Modified by GUIDE v2.5 12-Oct-2008 00:49:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @edit_empirical_data_OpeningFcn, ...
                   'gui_OutputFcn',  @edit_empirical_data_OutputFcn, ...
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


% --- Executes just before edit_empirical_data is made visible.
function edit_empirical_data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to edit_empirical_data (see VARARGIN)

% Choose default command line output for edit_empirical_data
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes edit_empirical_data wait for user response (see UIRESUME)
% uiwait(handles.fig_edit_empirical_data);

movegui(hObject,'center')
set(handles.pb_delete,'Enable','Off');
set(handles.cb_confirm,'Value',0);

global TSD PP
PP.deleterun=size(TSD,1)-1;
set(handles.ed_run,'String',PP.deleterun)
if PP.deleterun==0
    TSD=[];
    close
end


% --- Outputs from this function are returned to the command line.
function varargout = edit_empirical_data_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;


% --- Executes on button press in pb_delete.
function pb_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pb_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP TSD
TSD(PP.deleterun+1,:)=[];
edit_empirical_data


function ed_run_Callback(hObject, eventdata, handles)
% hObject    handle to ed_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_run as text
%        str2double(get(hObject,'String')) returns contents of ed_run as a double


% --- Executes during object creation, after setting all properties.
function ed_run_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cb_confirm.
function cb_confirm_Callback(hObject, eventdata, handles)
% hObject    handle to cb_confirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_confirm
if get(hObject,'Value')==1
    set(handles.pb_delete,'Enable','On');
else
    set(handles.pb_delete,'Enable','Off');
end


% --- Executes when user attempts to close fig_edit_empirical_data.
function fig_edit_empirical_data_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_edit_empirical_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
global PP TSD
delete(hObject);
save ([PP.path filesep 'TSD'],'TSD');
mainmenu

