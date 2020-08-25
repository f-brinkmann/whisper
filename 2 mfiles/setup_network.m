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


function varargout = setup_network(varargin)
% SETUP_NETWORK M-file for setup_network.fig
%      SETUP_NETWORK, by itself, creates a new SETUP_NETWORK or raises the existing
%      singleton*.
%
%      H = SETUP_NETWORK returns the handle to a new SETUP_NETWORK or the handle to
%      the existing singleton*.
%
%      SETUP_NETWORK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETUP_NETWORK.M with the given input arguments.
%
%      SETUP_NETWORK('Property','Value',...) creates a new SETUP_NETWORK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before setup_network_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to setup_network_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help setup_network

% Last Modified by GUIDE v2.5 24-Feb-2015 14:46:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @setup_network_OpeningFcn, ...
                   'gui_OutputFcn',  @setup_network_OutputFcn, ...
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


% --- Executes just before setup_network is made visible.
function setup_network_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to setup_network (see VARARGIN)

% Choose default command line output for setup_network
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes setup_network wait for user response (see UIRESUME)
% uiwait(handles.fig_setup_network);

movegui(hObject,'center')
global PS

set(handles.ed_host_1,'String',PS.network{1,1}{1,1});
set(handles.ed_port_1,'String',PS.network{1,1}{1,2});

set(handles.ed_host_2,'String',PS.network{1,1}{2,1});
set(handles.ed_port_2,'String',PS.network{1,1}{2,2});

set(handles.ed_host_3,'String',PS.network{1,1}{3,1});
set(handles.ed_port_3,'String',PS.network{1,1}{3,2});

set(handles.ed_host_4,'String',PS.network{1,1}{4,1});
set(handles.ed_port_4,'String',PS.network{1,1}{4,2});

set(handles.ed_host_5,'String',PS.network{1,1}{5,1});
set(handles.ed_port_5,'String',PS.network{1,1}{5,2});

set(handles.ed_host_6,'String',PS.network{1,1}{6,1});
set(handles.ed_port_6,'String',PS.network{1,1}{6,2});


% --- Outputs from this function are returned to the command line.
function varargout = setup_network_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function ed_host_1_Callback(hObject, eventdata, handles)
% hObject    handle to ed_host_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_host_1 as text
%        str2double(get(hObject,'String')) returns contents of ed_host_1 as a double


% --- Executes during object creation, after setting all properties.
function ed_host_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_host_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_port_1_Callback(hObject, eventdata, handles)
% hObject    handle to ed_port_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_port_1 as text
%        str2double(get(hObject,'String')) returns contents of ed_port_1 as a double


% --- Executes during object creation, after setting all properties.
function ed_port_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_port_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_host_3_Callback(hObject, eventdata, handles)
% hObject    handle to ed_host_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_host_3 as text
%        str2double(get(hObject,'String')) returns contents of ed_host_3 as a double


% --- Executes during object creation, after setting all properties.
function ed_host_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_host_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_port_3_Callback(hObject, eventdata, handles)
% hObject    handle to ed_port_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_port_3 as text
%        str2double(get(hObject,'String')) returns contents of ed_port_3 as a double


% --- Executes during object creation, after setting all properties.
function ed_port_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_port_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_host_4_Callback(hObject, eventdata, handles)
% hObject    handle to ed_host_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_host_4 as text
%        str2double(get(hObject,'String')) returns contents of ed_host_4 as a double


% --- Executes during object creation, after setting all properties.
function ed_host_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_host_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_port_4_Callback(hObject, eventdata, handles)
% hObject    handle to ed_port_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_port_4 as text
%        str2double(get(hObject,'String')) returns contents of ed_port_4 as a double


% --- Executes during object creation, after setting all properties.
function ed_port_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_port_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_host_5_Callback(hObject, eventdata, handles)
% hObject    handle to ed_host_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_host_5 as text
%        str2double(get(hObject,'String')) returns contents of ed_host_5 as a double


% --- Executes during object creation, after setting all properties.
function ed_host_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_host_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_port_5_Callback(hObject, eventdata, handles)
% hObject    handle to ed_port_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_port_5 as text
%        str2double(get(hObject,'String')) returns contents of ed_port_5 as a double


% --- Executes during object creation, after setting all properties.
function ed_port_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_port_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_host_6_Callback(hObject, eventdata, handles)
% hObject    handle to ed_host_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_host_6 as text
%        str2double(get(hObject,'String')) returns contents of ed_host_6 as a double


% --- Executes during object creation, after setting all properties.
function ed_host_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_host_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_port_6_Callback(hObject, eventdata, handles)
% hObject    handle to ed_port_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_port_6 as text
%        str2double(get(hObject,'String')) returns contents of ed_port_6 as a double


% --- Executes during object creation, after setting all properties.
function ed_port_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_port_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_host_2_Callback(hObject, eventdata, handles)
% hObject    handle to ed_host_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_host_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_host_2 as a double


% --- Executes during object creation, after setting all properties.
function ed_host_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_host_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_port_2_Callback(hObject, eventdata, handles)
% hObject    handle to ed_port_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_port_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_port_2 as a double


% --- Executes during object creation, after setting all properties.
function ed_port_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_port_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_cancel.
function pb_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close


% --- Executes on button press in pb_save.
function pb_save_Callback(hObject, eventdata, handles)
% hObject    handle to pb_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PS
PS.network{1,1}{1,1}=get(handles.ed_host_1,'String');
PS.network{1,1}{1,2}=get(handles.ed_port_1,'String');

PS.network{1,1}{2,1}=get(handles.ed_host_2,'String');
PS.network{1,1}{2,2}=get(handles.ed_port_2,'String');

PS.network{1,1}{3,1}=get(handles.ed_host_3,'String');
PS.network{1,1}{3,2}=get(handles.ed_port_3,'String');

PS.network{1,1}{4,1}=get(handles.ed_host_4,'String');
PS.network{1,1}{4,2}=get(handles.ed_port_4,'String');

PS.network{1,1}{5,1}=get(handles.ed_host_5,'String');
PS.network{1,1}{5,2}=get(handles.ed_port_5,'String');

PS.network{1,1}{6,1}=get(handles.ed_host_6,'String');
PS.network{1,1}{6,2}=get(handles.ed_port_6,'String');

save ('PS.mat','PS');
close
mainmenu


% --- Executes when user attempts to close fig_setup_network.
function fig_setup_network_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_setup_network (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject)
mainmenu


% --- Executes on key press with focus on ed_host_1 and no controls selected.
function ed_host_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_host_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_port_1 and no controls selected.
function ed_port_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_port_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_host_2 and no controls selected.
function ed_host_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_host_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_port_2 and no controls selected.
function ed_port_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_port_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_host_3 and no controls selected.
function ed_host_3_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_host_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_port_3 and no controls selected.
function ed_port_3_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_port_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_host_4 and no controls selected.
function ed_host_4_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_host_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_port_4 and no controls selected.
function ed_port_4_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_port_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_host_5 and no controls selected.
function ed_host_5_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_host_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_port_5 and no controls selected.
function ed_port_5_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_port_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_host_6 and no controls selected.
function ed_host_6_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_host_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_port_6 and no controls selected.
function ed_port_6_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_port_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function fig_setup_network_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fig_setup_network (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
