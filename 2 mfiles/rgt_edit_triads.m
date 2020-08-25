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
% Author :   Andr? Wlodarski, student at FG Audiokommunikation, TU Berlin
% Email  :   awlodarski AT gmx DOT de
% Date   :   15-Nov-2008
% Updated:   20-Nov-2008 changed max num of elements for complete variation 
% =========================================================================


function varargout = rgt_edit_triads(varargin)
% RGT_EDIT_TRIADS M-file for rgt_edit_triads.fig
%      RGT_EDIT_TRIADS, by itself, creates a new RGT_EDIT_TRIADS or raises the existing
%      singleton*.
%
%      H = RGT_EDIT_TRIADS returns the handle to a new RGT_EDIT_TRIADS or the handle to
%      the existing singleton*.
%
%      RGT_EDIT_TRIADS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RGT_EDIT_TRIADS.M with the given input arguments.
%
%      RGT_EDIT_TRIADS('Property','Value',...) creates a new RGT_EDIT_TRIADS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rgt_edit_triads_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rgt_edit_triads_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rgt_edit_triads

% Last Modified by GUIDE v2.5 21-Aug-2008 12:54:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rgt_edit_triads_OpeningFcn, ...
                   'gui_OutputFcn',  @rgt_edit_triads_OutputFcn, ...
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


% --- Executes just before rgt_edit_triads is made visible.
function rgt_edit_triads_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rgt_edit_triads (see VARARGIN)

% Choose default command line output for rgt_edit_triads
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rgt_edit_triads wait for user response (see UIRESUME)
% uiwait(handles.fig_rgt_edit_triads);

movegui(hObject,'center')
global TSP PP
load ([PP.path filesep 'TSP.mat']);
set(hObject,'Name',['RGT - edit triads (' TSP.sections{PP.edit_section_line,2} ')'])
fill_list_elements(handles)%funktionsaufruf: element pool f?llen
fill_list_triads(handles)


function fill_list_elements(handles) %baugleich mit der gleichnamigen Funktion aus rgt_element_pool.m
% Inhalt der Liste wird generiert.
% Mit Hilfe der Funktion str_to_len.m werden die Inhalte in die richtige
% L?nge gebracht f?r die tabellarisch korrekte Darstellung, jeder
% Schleifendurchlauf generiert dabei eine Zeile der Liste.
global TSP PP

if isempty(TSP.sections{PP.edit_section_line,4}{1,1})==0
 for i=1:length(TSP.sections{PP.edit_section_line,4}{1,1}(:,1))
    %in elementliste vorhandene stimuli sind dort nur mit ihrem Index
    %abgelegt. Die Daten werden aus dem globalen Pool geholt. Hier wird die
    %Stelle gesucht, an der sie im globalen Pool zu finden sind:
    line_in_global=0;
    for j=1:length(TSP.stimuli(:,1))
        if TSP.stimuli{j,1}==TSP.sections{PP.edit_section_line,4}{1,1}(i,1)
            line_in_global=j;
        end
    end
    %hier werden die gefundenen Stimuli mit den Daten in die Liste
    %?bernommen
    %falls keine ensprechungen in der globalen Stimulus-Liste gefunden werden,
    %bleibt Line_in_global_x == 0. (m?glich, wenn ein Stimulus nachtr?glich aus
    %dem Pool gel?scht wurde) In dem Fall wird als Name not available
    %angezeigt
    if line_in_global==0
        stimuli_list{i,1}=[str_to_len(num2str(i), 5) ...
                      'S' str_to_len('000', 5) ...%Spalte: ID 
                      str_to_len('! --- not available', 25)];      %Spalte: name
    else
        stimuli_list{i,1}=[str_to_len(num2str(i), 5) ...
                      'S' str_to_len(num2str(TSP.stimuli{line_in_global,1}), 5) ...%Spalte: ID 
                      str_to_len(TSP.stimuli{line_in_global,2}, 25)];      %Spalte: name
    end
 end
 set(handles.lb_element_pool,'String', stimuli_list);
else
 set(handles.lb_element_pool,'String', '');
end


function fill_list_triads(handles)
% Inhalt der Liste wird generiert.
% Mit Hilfe der Funktion str_to_len.m werden die Inhalte in die richtige
% L?nge gebracht f?r die tabellarisch korrekte Darstellung, jeder
% Schleifendurchlauf generiert dabei eine Zeile der Liste.
global TSP PP

if isempty(TSP.sections{PP.edit_section_line,5}{1,1})==0
 for i=1:length(TSP.sections{PP.edit_section_line,5}{1,1}(:,1))
    %in triadenliste vorhandene stimuli sind dort nur mit ihrem Index
    %abgelegt. Die Daten werden aus dem globalen Pool geholt. Hier wird die
    %Stelle gesucht, an der sie im globalen Pool zu finden sind:
    line_in_global_1=0;
    line_in_global_2=0;
    line_in_global_3=0;
    for j=1:length(TSP.stimuli(:,1))
        if TSP.stimuli{j,1}==TSP.sections{PP.edit_section_line,5}{1,1}(i,1)
            line_in_global_1=j;
        end
        if TSP.stimuli{j,1}==TSP.sections{PP.edit_section_line,5}{1,1}(i,2)
            line_in_global_2=j;
        end
        if TSP.stimuli{j,1}==TSP.sections{PP.edit_section_line,5}{1,1}(i,3)
            line_in_global_3=j;
        end
    end
%falls keine ensprechungen in der globalen Stimulus-Liste gefunden werden,
%bleibt Line_in_global_x == 0. (m?glich, wenn ein Stimulus nachtr?glich aus
%dem Pool gel?scht wurde) In dem Fall wird er als Name not available angezeigt
%Ansonsten werden die Daten aus der gefundenen Zeile ?bernommen
    if line_in_global_1==0
        stim_1_nr=0;
        stim_1_name='! -- not available';
    else
        stim_1_nr=stimnum_to_elemnum(i,1); %stimulus-Nr f?r die Anzeige in Element-Nr. umwandeln, die aufgerufene Funktion siehe unten
        stim_1_name=TSP.stimuli{line_in_global_1,2};
        if stim_1_nr==0
            stim_1_name='! -- not available';
        end
    end

    if line_in_global_2==0
        stim_2_nr=0;
        stim_2_name='! -- not available';
    else
        stim_2_nr=stimnum_to_elemnum(i,2); %stimulus-Nr f?r die Anzeige in Element-Nr. umwandeln, die aufgerufene Funktion siehe unten
        stim_2_name=TSP.stimuli{line_in_global_2,2};
        if stim_2_nr==0
            stim_2_name='! -- not available';
        end
    end
    
    if line_in_global_3==0
        stim_3_nr=0;
        stim_3_name='! -- not available';
    else
        stim_3_nr=stimnum_to_elemnum(i,3); %stimulus-Nr f?r die Anzeige in Element-Nr. umwandeln, die aufgerufene Funktion siehe unten
        stim_3_name=TSP.stimuli{line_in_global_3,2};
        if stim_3_nr==0
            stim_3_name='! -- not available';
        end
    end
    %hier werden die gefundenen Stimuli mit den Daten in die Liste
    %?bernommen
    triad_list{i,1}=[str_to_len(num2str(i), 5) ...
                      '(' str_to_len(num2str(stim_1_nr), 5) ...%Spalte: Stimulus 1, Element-Nummer FALSCH, Stim-ID
                      str_to_len(stim_1_name, 18) ')  '...   %Spalte: Stimulus 1, Name
                      '(' str_to_len(num2str(stim_2_nr), 5) ...%Spalte: Stimulus 2, Element-Nummer 
                      str_to_len(stim_2_name, 18) ')  '...   %Spalte: Stimulus 2, Name
                      '(' str_to_len(num2str(stim_3_nr), 5) ...%Spalte: Stimulus 2, Element-Nummer 
                      str_to_len(stim_3_name, 18) ')  '];    %Spalte: Stimulus 2, Name
 end
 set(handles.lb_triad_list,'String', triad_list);
else
 set(handles.lb_triad_list,'String', '');
end


function [element_number] = stimnum_to_elemnum(i,spalte)
%stimulus-Nr wird f?r die Anzeige im Triaden-Pool in eine Element-Nr.
%umgewandelt
%i ist zeilenindex und spalte spaltenindex der Triaden-Matrix

global TSP PP
if isempty(TSP.sections{PP.edit_section_line,4}{1,1})==0
    for j=1:length(TSP.sections{PP.edit_section_line,4}{1,1})
        if TSP.sections{PP.edit_section_line,5}{1,1}(i,spalte)==TSP.sections{PP.edit_section_line,4}{1,1}(j,1)
            element_number=j;
        end
    end
else
    element_number=0;
end


% --- Outputs from this function are returned to the command line.
function varargout = rgt_edit_triads_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in as_stimulus_1.
function as_stimulus_1_Callback(hObject, eventdata, handles)
% hObject    handle to as_stimulus_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
elementline=get(handles.lb_element_pool, 'Value');
triadline=get(handles.lb_triad_list, 'Value');
TSP.sections{PP.edit_section_line,5}{1,1}(triadline,1)=TSP.sections{PP.edit_section_line,4}{1,1}(elementline,1);
fill_list_triads(handles)
%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der User m?glicherweise R?ckg?ngig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in as_stimulus_2.
function as_stimulus_2_Callback(hObject, eventdata, handles)
% hObject    handle to as_stimulus_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
elementline=get(handles.lb_element_pool, 'Value');
triadline=get(handles.lb_triad_list, 'Value');
TSP.sections{PP.edit_section_line,5}{1,1}(triadline,2)=TSP.sections{PP.edit_section_line,4}{1,1}(elementline,1);
fill_list_triads(handles)
%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der User m?glicherweise R?ckg?ngig machen will
set(handles.pb_cancel,'Enable', 'on');

% --- Executes on button press in as_stimulus_3.
function as_stimulus_3_Callback(hObject, eventdata, handles)
% hObject    handle to as_stimulus_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
elementline=get(handles.lb_element_pool, 'Value');
triadline=get(handles.lb_triad_list, 'Value');
TSP.sections{PP.edit_section_line,5}{1,1}(triadline,3)=TSP.sections{PP.edit_section_line,4}{1,1}(elementline,1);
fill_list_triads(handles)
%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der User m?glicherweise R?ckg?ngig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in pb_import_triad_list_from_file.
function pb_import_triad_list_from_file_Callback(hObject, eventdata, handles)
% hObject    handle to pb_import_triad_list_from_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_add_triad.
function pb_add_triad_Callback(hObject, eventdata, handles)
% hObject    handle to pb_add_triad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

add_triad(handles) %Funktion zum Generieren einer neuen leeren Triade aufrufen


% --- Executes on button press in pb_add_5_triads.
function pb_add_5_triads_Callback(hObject, eventdata, handles)
% hObject    handle to pb_add_5_triads (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

add_triad(handles) %Funktion zum Generieren einer neuen leeren Triade 5x aufrufen
add_triad(handles)
add_triad(handles)
add_triad(handles)
add_triad(handles)


function add_triad(handles)
global TSP PP
% neue Triade wird am Ende der Liste erzeugt,
if isempty(TSP.sections{PP.edit_section_line,5}{1,1}) ==1
    newline=1;
else
    newline=length(TSP.sections{PP.edit_section_line,5}{1,1}(:,1))+1; % %neuer Zeilenindex im Array
end
TSP.sections{PP.edit_section_line,5}{1,1}(newline,1)=0;
TSP.sections{PP.edit_section_line,5}{1,1}(newline,2)=0;
TSP.sections{PP.edit_section_line,5}{1,1}(newline,3)=0;

fill_list_triads(handles); %Funktion zum F?llen/Aktualisieren der Stimulus-Liste aufrufen (befindet sich ebenfalls in dieser m-Datei)
%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der User m?glicherweise R?ckg?ngig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in pb_delete.
function pb_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pb_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
deleteline=get(handles.lb_triad_list,'Value');
set(handles.lb_triad_list,'Value', 1);
TSP.sections{PP.edit_section_line,5}{1,1}(deleteline,:)=[];
fill_list_triads(handles);
%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der User m?glicherweise R?ckg?ngig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on selection change in lb_triad_list.
function lb_triad_list_Callback(hObject, eventdata, handles)
% hObject    handle to lb_triad_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lb_triad_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_triad_list


% --- Executes during object creation, after setting all properties.
function lb_triad_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_triad_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_complete_variation.
function pb_complete_variation_Callback(hObject, eventdata, handles)
% hObject    handle to pb_complete_variation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
if length(TSP.sections{PP.edit_section_line,4}{1,1}(:,1))<16
    TSP.sections{PP.edit_section_line,5}{1,1}=nchoosek(TSP.sections{PP.edit_section_line,4}{1,1}(:,1),3);
    fill_list_triads(handles)
else
    PP.whisper_message='Only allowed for element lists up to 15 elements';
    whisper_message
end
%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der User m?glicherweise R?ckg?ngig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in pb_move_up.
function pb_move_up_Callback(hObject, eventdata, handles)
% hObject    handle to pb_move_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
line_to_move_up=get(handles.lb_triad_list, 'Value');
if line_to_move_up > 1
    temp=TSP.sections{PP.edit_section_line,5}{1,1}(line_to_move_up-1,:);
    TSP.sections{PP.edit_section_line,5}{1,1}(line_to_move_up-1,:)=TSP.sections{PP.edit_section_line,5}{1,1}(line_to_move_up,:);
    TSP.sections{PP.edit_section_line,5}{1,1}(line_to_move_up,:)=temp;
    fill_list_triads(handles)
    %Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
    %User m?glicherweise R?ckg?ngig machen will
    set(handles.pb_cancel,'Enable', 'on');
    set(handles.lb_triad_list,'Value', line_to_move_up-1);
end


% --- Executes on button press in pb_move_down.
function pb_move_down_Callback(hObject, eventdata, handles)
% hObject    handle to pb_move_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
line_to_move_down=get(handles.lb_triad_list, 'Value');
if isempty(TSP.sections{PP.edit_section_line,5}{1,1})==0
    lastline=length(TSP.sections{PP.edit_section_line,5}{1,1}(:,1));
    if line_to_move_down < lastline
      temp=TSP.sections{PP.edit_section_line,5}{1,1}(line_to_move_down+1,:);
      TSP.sections{PP.edit_section_line,5}{1,1}(line_to_move_down+1,:)=TSP.sections{PP.edit_section_line,5}{1,1}(line_to_move_down,:);
      TSP.sections{PP.edit_section_line,5}{1,1}(line_to_move_down,:)=temp;
      fill_list_triads(handles)
     %Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
     %User m?glicherweise R?ckg?ngig machen will
      set(handles.pb_cancel,'Enable', 'on');
      set(handles.lb_triad_list,'Value', line_to_move_down+1);
    end
end


% --- Executes on selection change in lb_element_pool.
function lb_element_pool_Callback(hObject, eventdata, handles)
% hObject    handle to lb_element_pool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lb_element_pool contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_element_pool


% --- Executes during object creation, after setting all properties.
function lb_element_pool_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_element_pool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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
save ([PP.path filesep 'TSP.mat'],'TSP');
close


% --- Executes when user attempts to close fig_rgt_edit_triads.
function fig_rgt_edit_triads_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_rgt_edit_triads (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

rgt_edit_main
% Hint: delete(hObject) closes the figure
delete(hObject);

