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


function varargout = ap_edit_stimulus_assignment(varargin)
% AP_EDIT_STIMULUS_ASSIGNMENT M-file for ap_edit_stimulus_assignment.fig
%      AP_EDIT_STIMULUS_ASSIGNMENT, by itself, creates a new AP_EDIT_STIMULUS_ASSIGNMENT or raises the existing
%      singleton*.
%
%      H = AP_EDIT_STIMULUS_ASSIGNMENT returns the handle to a new AP_EDIT_STIMULUS_ASSIGNMENT or the handle to
%      the existing singleton*.
%
%      AP_EDIT_STIMULUS_ASSIGNMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AP_EDIT_STIMULUS_ASSIGNMENT.M with the given input arguments.
%
%      AP_EDIT_STIMULUS_ASSIGNMENT('Property','Value',...) creates a new AP_EDIT_STIMULUS_ASSIGNMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ap_edit_stimulus_assignment_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ap_edit_stimulus_assignment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ap_edit_stimulus_assignment

% Last Modified by GUIDE v2.5 24-Feb-2015 14:18:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ap_edit_stimulus_assignment_OpeningFcn, ...
                   'gui_OutputFcn',  @ap_edit_stimulus_assignment_OutputFcn, ...
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


% --- Executes just before ap_edit_stimulus_assignment is made visible.
function ap_edit_stimulus_assignment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ap_edit_stimulus_assignment (see VARARGIN)

% Choose default command line output for ap_edit_stimulus_assignment
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ap_edit_stimulus_assignment wait for user response (see UIRESUME)
% uiwait(handles.fig_edit_stimulus_assignment);

movegui(hObject,'center')
global TSP PP
load ([PP.path filesep 'TSP.mat']);
set(hObject,'Name',['AP - stimulus assignment (' TSP.sections{PP.edit_section_line,2} ')'])
fill_list_gsp(handles) %funktionsaufruf: globalen stimulus pool füllen
fill_list_target(handles)%funktionsaufruf: element pool füllen
fill_list_ref(handles)


function fill_list_ref(handles)

global TSP PP
set(handles.ed_ID,'String', ['S' num2str(TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(1,3))])
line_in_global=0;
    for j=1:length(TSP.stimuli(:,1))
        if TSP.stimuli{j,1}==TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(1,3)
            line_in_global=j;
        end
    end
if line_in_global~=0
    set(handles.ed_name,'String', TSP.stimuli{line_in_global,2});
    set(handles.ed_value,'String', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(2,3));
end


function fill_list_gsp(handles)
% Inhalt der Liste wird generiert.
% Mit Hilfe der Funktion str_to_len.m werden die Inhalte in die richtige
% Länge gebracht für die tabellarisch korrekte Darstellung, jeder
% Schleifendurchlauf generiert dabei eine Zeile der Liste.
global TSP

for i=1:length(TSP.stimuli(:,1))
   stimuli_list{i,1}=['S' str_to_len(num2str(TSP.stimuli{i,1}), 5) ...%Spalte: ID 
                      str_to_len(TSP.stimuli{i,2}, 25)];      %Spalte: name
end
set(handles.lb_global_stimulus_pool,'String', stimuli_list);

    
function fill_list_target(handles)
% Inhalt der Liste wird generiert.
% Mit Hilfe der Funktion str_to_len.m werden die Inhalte in die richtige
% Länge gebracht für die tabellarisch korrekte Darstellung, jeder
% Schleifendurchlauf generiert dabei eine Zeile der Liste.
global TSP PP

laenge=length(TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(:,2));
range=TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(1,1);
%Länge der Liste wird an range angepasst, falls noch nicht lang genug
%neue Felder werden mit 0 gefüllt
if laenge<range
     TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(range,2)=0;
end

 for i=1:range
     %length(TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(:,2))
    %in elementliste vorhandene stimuli sind dort nur mit ihrem Index
    %abgelegt. Die Daten werden aus dem globalen Pool geholt. Hier wird die
    %Stelle gesucht, an der sie im globalen Pool zu finden sind:
    line_in_global=0;
    for j=1:length(TSP.stimuli(:,1))
        if TSP.stimuli{j,1}==TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(i,2)
            line_in_global=j;
        end
    end
    %hier werden die gefundenen Stimuli mit den Daten in die Liste
    %übernommen
    if line_in_global==0 % d.h. Sid ist nicht (mehr) im globalen Pool drin
        stimuli_list{i,1}=[str_to_len(num2str(i), 4) ...
                      'S' str_to_len('0', 5) ...%Spalte: ID 
                      str_to_len('- empty -', 17)];      %Spalte: name
        TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(i,2)=0; % nicht mehr im Pool vorhandene Sid wird auch aus den Targets rausgenommen
    else
        stimuli_list{i,1}=[str_to_len(num2str(i), 4) ...
                      'S' str_to_len(num2str(TSP.stimuli{line_in_global,1}), 5) ...%Spalte: ID 
                      str_to_len(TSP.stimuli{line_in_global,2}, 17)];      %Spalte: name
    end
 end
 set(handles.lb_target_stimulus_level,'String', stimuli_list);
 

% --- Outputs from this function are returned to the command line.
function varargout = ap_edit_stimulus_assignment_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in lb_target_stimulus_level.
function lb_target_stimulus_level_Callback(hObject, eventdata, handles)
% hObject    handle to lb_target_stimulus_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lb_target_stimulus_level contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_target_stimulus_level


% --- Executes during object creation, after setting all properties.
function lb_target_stimulus_level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_target_stimulus_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_name_Callback(hObject, eventdata, handles)
% hObject    handle to ed_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_name as text
%        str2double(get(hObject,'String')) returns contents of ed_name as a double


% --- Executes during object creation, after setting all properties.
function ed_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lb_global_stimulus_pool.
function lb_global_stimulus_pool_Callback(hObject, eventdata, handles)
% hObject    handle to lb_global_stimulus_pool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lb_global_stimulus_pool contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_global_stimulus_pool


% --- Executes during object creation, after setting all properties.
function lb_global_stimulus_pool_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_global_stimulus_pool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_assign_target.
function pb_assign_target_Callback(hObject, eventdata, handles)
% hObject    handle to pb_assign_target (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP

selection_list=get(handles.lb_global_stimulus_pool, 'Value');
for i=1:numel(selection_list)
 add_from_global_pool_line=selection_list(i);
 %neuen Zeilenindex für die Stelle im Target pool ermitteln
 new_startline=get(handles.lb_target_stimulus_level, 'Value');
 TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(new_startline+i-1,2)=TSP.stimuli{add_from_global_pool_line,1};
 fill_list_target(handles)%funktionsaufruf: element pool füllen
 %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
 set(handles.pb_cancel,'Enable', 'on');
end


% --- Executes on button press in pb_assign_reference.
function pb_assign_reference_Callback(hObject, eventdata, handles)
% hObject    handle to pb_assign_reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP

selection_list=get(handles.lb_global_stimulus_pool, 'Value');
i=1; %nimm immer nur das erste ausgewählte element aus gsp
 add_from_global_pool_line=selection_list(i);
 TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(1,3)=TSP.stimuli{add_from_global_pool_line,1};
 fill_list_ref(handles)%funktionsaufruf: element pool füllen
 %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
 set(handles.pb_cancel,'Enable', 'on');


function ed_value_Callback(hObject, eventdata, handles)
% hObject    handle to ed_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_value as text
%        str2double(get(hObject,'String')) returns contents of ed_value as a double


% --- Executes during object creation, after setting all properties.
function ed_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_ID_Callback(hObject, eventdata, handles)
% hObject    handle to ed_ID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_ID as text
%        str2double(get(hObject,'String')) returns contents of ed_ID as a double


% --- Executes during object creation, after setting all properties.
function ed_ID_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_ID (see GCBO)
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

global PP TSP
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(2,3)=str2num(get(handles.ed_value,'String'));

save ([PP.path filesep 'TSP.mat'],'TSP');
close


% --- Executes on key press with focus on ed_value and no controls selected.
function ed_value_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
 set(handles.pb_cancel,'Enable', 'on');


% --- Executes when user attempts to close fig_edit_stimulus_assignment.
function fig_edit_stimulus_assignment_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_edit_stimulus_assignment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
if PP.dontopenparent~=1
    ap_edit_track_settings
end
PP.dontopenparent=0;

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on selection change in listbox5.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5


% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function fig_edit_stimulus_assignment_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fig_edit_stimulus_assignment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
