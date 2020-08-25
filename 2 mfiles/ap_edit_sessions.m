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


function varargout = ap_edit_sessions(varargin)
% AP_EDIT_SESSIONS M-file for ap_edit_sessions.fig
%      AP_EDIT_SESSIONS, by itself, creates a new AP_EDIT_SESSIONS or raises the existing
%      singleton*.
%
%      H = AP_EDIT_SESSIONS returns the handle to a new AP_EDIT_SESSIONS or the handle to
%      the existing singleton*.
%
%      AP_EDIT_SESSIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AP_EDIT_SESSIONS.M with the given input arguments.
%
%      AP_EDIT_SESSIONS('Property','Value',...) creates a new AP_EDIT_SESSIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ap_edit_sessions_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ap_edit_sessions_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ap_edit_sessions

% Last Modified by GUIDE v2.5 09-Oct-2008 23:18:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ap_edit_sessions_OpeningFcn, ...
                   'gui_OutputFcn',  @ap_edit_sessions_OutputFcn, ...
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


% --- Executes just before ap_edit_sessions is made visible.
function ap_edit_sessions_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ap_edit_sessions (see VARARGIN)

% Choose default command line output for ap_edit_sessions
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ap_edit_sessions wait for user response (see UIRESUME)
% uiwait(handles.fig_ap_edit_sessions);

movegui(hObject,'center')
global TSP PP
set(hObject,'Name',['AP - organize sessions (' TSP.sections{PP.edit_section_line,2} ')']);
fill_list(handles)

function fill_list(handles)
% Inhalt der Liste wird generiert.
% Mit Hilfe der Funktion str_to_len.m werden die Inhalte in die richtige
% Länge gebracht für die tabellarisch korrekte Darstellung, jeder
% Schleifendurchlauf generiert dabei eine Zeile der Liste.
global TSP PP

for i=1:TSP.number_of_sessions
   if i > length(TSP.sections{PP.edit_section_line,4}{1,4}(:,2))
       TSP.sections{PP.edit_section_line,4}{1,4}{i,2}=[];
   end
    session_list{i,1}=[str_to_len(num2str(i),3) '| '...%Spalte: Session 
       num2str(TSP.sections{PP.edit_section_line,4}{1,4}{i,2})];%Spalte: Object-folge                             
 
       
end
set(handles.lb_sessions,'String', session_list);


% --- Outputs from this function are returned to the command line.
function varargout = ap_edit_sessions_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in lb_sessions.
function lb_sessions_Callback(hObject, eventdata, handles)
% hObject    handle to lb_sessions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lb_sessions contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_sessions

global PP TSP

editline=get(handles.lb_sessions, 'Value');
set(handles.ed_tracks, 'String', num2str(TSP.sections{PP.edit_section_line,4}{1,4}{editline,2}))


% --- Executes during object creation, after setting all properties.
function lb_sessions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_sessions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_tracks_Callback(hObject, eventdata, handles)
% hObject    handle to ed_tracks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_tracks as text
%        str2double(get(hObject,'String')) returns contents of ed_tracks as a double


% --- Executes during object creation, after setting all properties.
function ed_tracks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_tracks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_assign_track_numbers.
function pb_assign_track_numbers_Callback(hObject, eventdata, handles)
% hObject    handle to pb_assign_track_numbers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP

track_string=get(handles.ed_tracks, 'String');

%Leerzeichen am Ende löschen, da sonst ein zusätzlicher 0-Eintrag entsteht
ready=0;
while ready==0 && length(track_string)>1
    original_length=length(track_string);
    if track_string(original_length)==' '
        track_string(original_length)=[];
    else
        ready=1;
    end
end

%zu bearbeitende/angewählte Zeile in der Liste
editline=get(handles.lb_sessions, 'Value');
TSP.sections{PP.edit_section_line,4}{1,4}{editline,2}=strread(track_string);
fill_list(handles)
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in pb_view_tracks.
function pb_view_tracks_Callback(hObject, eventdata, handles)
% hObject    handle to pb_view_tracks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ap_show_tracks


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

global TSP PP

save ([PP.path filesep 'TSP.mat'],'TSP');
close


% --- Executes when user attempts to close fig_ap_edit_sessions.
function fig_ap_edit_sessions_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_ap_edit_sessions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);

ap_edit_main

