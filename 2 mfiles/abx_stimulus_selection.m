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
% Author :   Andreas Rotter, student at FG Audiokommunikation, TU Berlin
% Email  :   andreas.rotter.kontakt AT googlemail DOT com
% Date   :   08-Sep-2009
% Updated:   
% =========================================================================


function varargout = abx_stimulus_selection(varargin)
% ABX_STIMULUS_SELECTION M-file for abx_stimulus_selection.fig
%      ABX_STIMULUS_SELECTION, by itself, creates a new ABX_STIMULUS_SELECTION or raises the existing
%      singleton*.
%
%      H = ABX_STIMULUS_SELECTION returns the handle to a new ABX_STIMULUS_SELECTION or the handle to
%      the existing singleton*.
%
%      ABX_STIMULUS_SELECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ABX_STIMULUS_SELECTION.M with the given input arguments.
%
%      ABX_STIMULUS_SELECTION('Property','Value',...) creates a new ABX_STIMULUS_SELECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before abx_stimulus_selection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to abx_stimulus_selection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help abx_stimulus_selection

% Last Modified by GUIDE v2.5 20-Mar-2014 11:54:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @abx_stimulus_selection_OpeningFcn, ...
                   'gui_OutputFcn',  @abx_stimulus_selection_OutputFcn, ...
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


% --- Executes just before abx_stimulus_selection is made visible.
function abx_stimulus_selection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to abx_stimulus_selection (see VARARGIN)

% Choose default command line output for abx_stimulus_selection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Center GUI
movegui(hObject,'center');
% UIWAIT makes abx_stimulus_selection wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global TSP PP
load ([PP.path filesep 'TSP.mat']);
set(hObject,'Name',['ABX - stimulus assignment (' TSP.sections{PP.edit_section_line,2} ')']);
fill_list_gsp(handles) %funktionsaufruf: globalen stimulus pool f?llen
fill_assignment(handles) % Eintragen der, wenn vorhanden, zwei Stimuli

if isempty(TSP.sections{PP.edit_section_line,4}{1,5}) == 0
set(handles.txt_assign_a,'String',TSP.stimuli{TSP.sections{PP.edit_section_line,4}{1,5}(1,1),2});
set(handles.txt_assign_b,'String',TSP.stimuli{TSP.sections{PP.edit_section_line,4}{1,5}(1,2),2});
end


function fill_list_gsp(handles)
% Inhalt der Liste wird generiert.
% Mit Hilfe der Funktion str_to_len.m werden die Inhalte in die richtige
% L?nge gebracht f?r die tabellarisch korrekte Darstellung, jeder
% Schleifendurchlauf generiert dabei eine Zeile der Liste.
global TSP

for i=1:length(TSP.stimuli(:,1))
   stimuli_list{i,1}=['S' str_to_len(num2str(TSP.stimuli{i,1}), 15) ...%Spalte: ID 
                      str_to_len(TSP.stimuli{i,2}, 35)];      %Spalte: name
end
set(handles.lb_global_stimulus_pool,'String', stimuli_list);

function fill_assignment(handles)

% --- Outputs from this function are returned to the command line.
function varargout = abx_stimulus_selection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes when user attempts to close fig_abx_edit_main.
function fig_abx_stimulus_selection_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_abx_edit_main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP

if PP.dontopenparent~=1
    abx_edit_main
end
PP.dontopenparent=0;

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in pb_assign_a.
function pb_assign_a_Callback(hObject, eventdata, handles)
% hObject    handle to pb_assign_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP TSP
selection_list=get(handles.lb_global_stimulus_pool, 'Value');
for i=1:numel(selection_list)
    add_from_global_pool_line=selection_list(i);
    TSP.sections{PP.edit_section_line,4}{1,5}(1,1)=TSP.stimuli{add_from_global_pool_line,1};
end
set(handles.txt_assign_a,'String',TSP.stimuli{add_from_global_pool_line,2});
    
% --- Executes on button press in pb_assign_b.
function pb_assign_b_Callback(hObject, eventdata, handles)
% hObject    handle to pb_assign_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP TSP
selection_list=get(handles.lb_global_stimulus_pool, 'Value');
for i=1:numel(selection_list)
    add_from_global_pool_line=selection_list(i);
    TSP.sections{PP.edit_section_line,4}{1,5}(1,2)=TSP.stimuli{add_from_global_pool_line,1};
end
set(handles.txt_assign_b,'String',TSP.stimuli{add_from_global_pool_line,2});

% --- Executes on button press in pb_save.
function pb_save_Callback(hObject, eventdata, handles)
% hObject    handle to pb_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close


% --- Executes on button press in pb_cancel.
function pb_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
abx_edit_main

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



function txt_assign_a_Callback(hObject, eventdata, handles)
% hObject    handle to txt_assign_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_assign_a as text
%        str2double(get(hObject,'String')) returns contents of txt_assign_a as a double


% --- Executes during object creation, after setting all properties.
function txt_assign_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_assign_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_assign_b_Callback(hObject, eventdata, handles)
% hObject    handle to txt_assign_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_assign_b as text
%        str2double(get(hObject,'String')) returns contents of txt_assign_b as a double


% --- Executes during object creation, after setting all properties.
function txt_assign_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_assign_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
