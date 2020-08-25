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


function varargout = rgt_edit_triad_seq(varargin)
% RGT_EDIT_TRIAD_SEQ M-file for rgt_edit_triad_seq.fig
%      RGT_EDIT_TRIAD_SEQ, by itself, creates a new RGT_EDIT_TRIAD_SEQ or raises the existing
%      singleton*.
%
%      H = RGT_EDIT_TRIAD_SEQ returns the handle to a new RGT_EDIT_TRIAD_SEQ or the handle to
%      the existing singleton*.
%
%      RGT_EDIT_TRIAD_SEQ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RGT_EDIT_TRIAD_SEQ.M with the given input arguments.
%
%      RGT_EDIT_TRIAD_SEQ('Property','Value',...) creates a new RGT_EDIT_TRIAD_SEQ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rgt_edit_triad_seq_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rgt_edit_triad_seq_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rgt_edit_triad_seq

% Last Modified by GUIDE v2.5 04-Sep-2008 00:04:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rgt_edit_triad_seq_OpeningFcn, ...
                   'gui_OutputFcn',  @rgt_edit_triad_seq_OutputFcn, ...
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


% --- Executes just before rgt_edit_triad_seq is made visible.
function rgt_edit_triad_seq_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rgt_edit_triad_seq (see VARARGIN)

% Choose default command line output for rgt_edit_triad_seq
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rgt_edit_triad_seq wait for user response (see UIRESUME)
% uiwait(handles.fig_edit_triad_seq);
global TSP PP

movegui(hObject,'center')
set(hObject,'Name',['RGT - triad sequence setup (' TSP.sections{PP.edit_section_line,2} ')']);
fill_list(handles)

if TSP.sections{PP.edit_section_line,5}{1,2}{1,3}==2 %Voreinstellung ist Auswahl 1
    set(handles.rad_random_order,'Value', 1);
end


function fill_list(handles)
% Inhalt der Liste wird generiert.
% Mit Hilfe der Funktion str_to_len.m werden die Inhalte in die richtige
% Länge gebracht für die tabellarisch korrekte Darstellung, jeder
% Schleifendurchlauf generiert dabei eine Zeile der Liste.
global TSP PP

for i=1:TSP.number_of_sessions
    %length(TSP.sections{PP.edit_section_line,5}{1,2}(:,2))
   if i > length(TSP.sections{PP.edit_section_line,5}{1,2}(:,2))
       TSP.sections{PP.edit_section_line,5}{1,2}{i,2}=[];
   end
       session_list{i,1}=[str_to_len(num2str(i),3) '| '...%Spalte: Session 
       num2str(TSP.sections{PP.edit_section_line,5}{1,2}{i,2})];%Spalte: Triadenfolge
end
set(handles.lb_sessions,'String', session_list);


% --- Outputs from this function are returned to the command line.
function varargout = rgt_edit_triad_seq_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function ed_triads_Callback(hObject, eventdata, handles)
% hObject    handle to ed_triads (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_triads as text
%        str2double(get(hObject,'String')) returns contents of ed_triads as a double


% --- Executes during object creation, after setting all properties.
function ed_triads_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_triads (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_view_triads.
function pb_view_triads_Callback(hObject, eventdata, handles)
% hObject    handle to pb_view_triads (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rgt_show_triads


% --- Executes on selection change in lb_sessions.
function lb_sessions_Callback(hObject, eventdata, handles)
% hObject    handle to lb_sessions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lb_sessions contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_sessions

global PP TSP

editline=get(handles.lb_sessions, 'Value');
set(handles.ed_triads, 'String', num2str(TSP.sections{PP.edit_section_line,5}{1,2}{editline,2}))


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


% --- Executes on button press in pb_assign_triads.
function pb_assign_triads_Callback(hObject, eventdata, handles)
% hObject    handle to pb_assign_triads (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP

triad_string=get(handles.ed_triads, 'String');
%Leerzeichen am Ende löschen, da sonst ein zusätzlicher 0-Eintrag entsteht
ready=0;
while ready==0 && length(triad_string)>1
    original_length=length(triad_string);
    if triad_string(original_length)==' '
        triad_string(original_length)=[];
    else
        ready=1;
    end
end
%zu bearbeitende/angewählte Zeile in der Liste
editline=get(handles.lb_sessions, 'Value');
TSP.sections{PP.edit_section_line,5}{1,2}{editline,2}=strread(triad_string);
fill_list(handles)
set(handles.pb_cancel,'Enable', 'on');


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


%radiobutons
rb_tr_1=get(handles.rad_as_defined,'Value');
rb_tr_2=get(handles.rad_random_order,'Value');
TSP.sections{PP.edit_section_line,5}{1,2}{1,3}=rb_tr_1 + 2*rb_tr_2;
%ergibt 1 bei Auswahl des ersten Buttons und 2 bei Auswahl des zweiten

save ([PP.path filesep 'TSP.mat'],'TSP');
close


% --- Executes when user attempts to close fig_edit_triad_seq.
function fig_edit_triad_seq_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_edit_triad_seq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);

rgt_edit_main


% --- Executes on button press in rad_random_order.
function rad_random_order_Callback(hObject, eventdata, handles)
% hObject    handle to rad_random_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_random_order

set(handles.rad_random_order,'Value', 1);
set(handles.pb_cancel,'Enable', 'on');

% --- Executes on button press in rad_as_defined.
function rad_as_defined_Callback(hObject, eventdata, handles)
% hObject    handle to rad_as_defined (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_as_defined

set(handles.rad_as_defined,'Value', 1);
set(handles.pb_cancel,'Enable', 'on');

