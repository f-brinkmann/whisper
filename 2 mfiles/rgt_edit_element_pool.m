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


function varargout = rgt_edit_element_pool(varargin)
% RGT_EDIT_ELEMENT_POOL M-file for rgt_edit_element_pool.fig
%      RGT_EDIT_ELEMENT_POOL, by itself, creates a new RGT_EDIT_ELEMENT_POOL or raises the existing
%      singleton*.
%
%      H = RGT_EDIT_ELEMENT_POOL returns the handle to a new RGT_EDIT_ELEMENT_POOL or the handle to
%      the existing singleton*.
%
%      RGT_EDIT_ELEMENT_POOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RGT_EDIT_ELEMENT_POOL.M with the given input arguments.
%
%      RGT_EDIT_ELEMENT_POOL('Property','Value',...) creates a new RGT_EDIT_ELEMENT_POOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rgt_edit_element_pool_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rgt_edit_element_pool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rgt_edit_element_pool

% Last Modified by GUIDE v2.5 14-Aug-2008 23:52:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rgt_edit_element_pool_OpeningFcn, ...
                   'gui_OutputFcn',  @rgt_edit_element_pool_OutputFcn, ...
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


% --- Executes just before rgt_edit_element_pool is made visible.
function rgt_edit_element_pool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rgt_edit_element_pool (see VARARGIN)

% Choose default command line output for rgt_edit_element_pool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rgt_edit_element_pool wait for user response (see UIRESUME)
% uiwait(handles.fig_edit_element_pool);

movegui(hObject,'center')
global TSP PP
load ([PP.path filesep 'TSP.mat']);
set(hObject,'Name',['RGT - element pool (' TSP.sections{PP.edit_section_line,2} ')'])
fill_list_gsp(handles) %funktionsaufruf: globalen stimulus pool füllen
fill_list_elements(handles)%funktionsaufruf: element pool füllen


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


function fill_list_elements(handles)
% Inhalt der Liste wird generiert.
% Mit Hilfe der Funktion str_to_len.m werden die Inhalte in die richtige
% Länge gebracht für die tabellarisch korrekte Darstellung, jeder
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
    %übernommen
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


% --- Outputs from this function are returned to the command line.
function varargout = rgt_edit_element_pool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


% --- Executes on button press in pb_delete_this_element.
function pb_delete_this_element_Callback(hObject, eventdata, handles)
% hObject    handle to pb_delete_this_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP

deleteline=get(handles.lb_element_pool,'Value');
set(handles.lb_element_pool,'Value', 1);
TSP.sections{PP.edit_section_line,4}{1,1}(deleteline,:)=[];
fill_list_elements(handles)%funktionsaufruf: element pool füllen
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


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


% --- Executes on button press in pb_add_to_element_pool.
function pb_add_to_element_pool_Callback(hObject, eventdata, handles)
% hObject    handle to pb_add_to_element_pool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP

selection_list=get(handles.lb_global_stimulus_pool, 'Value');
for i=1:numel(selection_list)
 add_from_global_pool_line=selection_list(i);
 %neuen Zeilenindex für die Stelle im Element pool ermitteln, wenn noch
 %leer, Zeile 1 nehmen.
 if isempty(TSP.sections{PP.edit_section_line,4}{1,1}) == 0
     element_pool_newline=length(TSP.sections{PP.edit_section_line,4}{1,1}(:,1))+1;
 else
     element_pool_newline=1;
 end
 TSP.sections{PP.edit_section_line,4}{1,1}(element_pool_newline,1)=TSP.stimuli{add_from_global_pool_line,1};
 fill_list_elements(handles)%funktionsaufruf: element pool füllen
 %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
 set(handles.pb_cancel,'Enable', 'on');
end


% --- Executes on button press in pb_move_up.
function pb_move_up_Callback(hObject, eventdata, handles)
% hObject    handle to pb_move_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
line_to_move_up=get(handles.lb_element_pool, 'Value');
if line_to_move_up > 1
    temp=TSP.sections{PP.edit_section_line,4}{1,1}(line_to_move_up-1,:);
    TSP.sections{PP.edit_section_line,4}{1,1}(line_to_move_up-1,:)=TSP.sections{PP.edit_section_line,4}{1,1}(line_to_move_up,:);
    TSP.sections{PP.edit_section_line,4}{1,1}(line_to_move_up,:)=temp;
    fill_list_elements(handles)
    %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
    %User möglicherweise Rückgängig machen will
    set(handles.pb_cancel,'Enable', 'on');
    set(handles.lb_element_pool,'Value', line_to_move_up-1);
end


% --- Executes on button press in pb_move_down.
function pb_move_down_Callback(hObject, eventdata, handles)
% hObject    handle to pb_move_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
line_to_move_down=get(handles.lb_element_pool, 'Value');
if isempty(TSP.sections{PP.edit_section_line,4}(1,1))==0
    lastline=length(TSP.sections{PP.edit_section_line,4}{1,1}(:,1));
    if line_to_move_down < lastline
      temp=TSP.sections{PP.edit_section_line,4}{1,1}(line_to_move_down+1,:);
      TSP.sections{PP.edit_section_line,4}{1,1}(line_to_move_down+1,:)=TSP.sections{PP.edit_section_line,4}{1,1}(line_to_move_down,:);
      TSP.sections{PP.edit_section_line,4}{1,1}(line_to_move_down,:)=temp;
      fill_list_elements(handles)
     %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
     %User möglicherweise Rückgängig machen will
      set(handles.pb_cancel,'Enable', 'on');
      set(handles.lb_element_pool,'Value', line_to_move_down+1);
    end
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


% --- Executes when user attempts to close fig_edit_element_pool.
function fig_edit_element_pool_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_edit_element_pool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
if PP.dontopenparent~=1
    rgt_edit_main
end
PP.dontopenparent=0;

% Hint: delete(hObject) closes the figure
delete(hObject);

