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


function varargout = rgt_edit_main(varargin)
% RGT_EDIT_MAIN M-file for rgt_edit_main.fig
%      RGT_EDIT_MAIN, by itself, creates a new RGT_EDIT_MAIN or raises the existing
%      singleton*.
%
%      H = RGT_EDIT_MAIN returns the handle to a new RGT_EDIT_MAIN or the handle to
%      the existing singleton*.
%
%      RGT_EDIT_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RGT_EDIT_MAIN.M with the given input arguments.
%
%      RGT_EDIT_MAIN('Property','Value',...) creates a new RGT_EDIT_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rgt_edit_main_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rgt_edit_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rgt_edit_main

% Last Modified by GUIDE v2.5 10-Oct-2008 03:04:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rgt_edit_main_OpeningFcn, ...
                   'gui_OutputFcn',  @rgt_edit_main_OutputFcn, ...
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


% --- Executes just before rgt_edit_main is made visible.
function rgt_edit_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rgt_edit_main (see VARARGIN)

% Choose default command line output for rgt_edit_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rgt_edit_main wait for user response (see UIRESUME)
% uiwait(handles.fig_rgt_edit_main);

movegui(hObject,'center')
global TSP PP
load ([PP.path filesep 'TSP.mat']);
%Auffüllen der GUI mit den gepeicherten Werten - links (construct
%elicitation)
set(hObject,'Name',['RGT - main settings (' TSP.sections{PP.edit_section_line,2} ')']);
set(handles.pop_maxnum_constructs,'Value', TSP.sections{PP.edit_section_line,5}{1,3});
if TSP.sections{PP.edit_section_line,5}{1,2}{1,1}==2 %Voreinstellung ist Auswahl 1
    set(handles.rad_triads_manual_selection,'Value', 1);
    set(handles.pb_edit_triad_sequences,'Enable', 'on');
end
set(handles.ed_constructs_initial_instruction,'String', TSP.sections{PP.edit_section_line,5}{1,4});
set(handles.ed_intermediate_instruction,'String', TSP.sections{PP.edit_section_line,5}{1,5});
%Auffüllen der GUI mit den gepeicherten Werten - rechts (rating)
if TSP.sections{PP.edit_section_line,4}{1,6}{1,1}==2 %Voreinstellung ist Auswahl 1
    set(handles.rad_elements_manual_selection,'Value', 1);
    set(handles.pb_edit_element_sequences,'Enable', 'on');
end
set(handles.ed_break_between_trials,'String', TSP.sections{PP.edit_section_line,4}{1,7});
set(handles.ed_rating_initial_instuction,'String', TSP.sections{PP.edit_section_line,4}{1,8});
set(handles.ed_rating_short_instruction,'String', TSP.sections{PP.edit_section_line,4}{1,9});


% --- Outputs from this function are returned to the command line.
function varargout = rgt_edit_main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_edit_triads.
function pb_edit_triads_Callback(hObject, eventdata, handles)
% hObject    handle to pb_edit_triads (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP
PP.dontopenparent=1; %verhindern, dass beim schließen die übergeordnete GUI geöffnet wird
pb_save_Callback(hObject, eventdata, handles) %Speichern und schließen
rgt_edit_triads


% --- Executes on button press in pb_edit_triad_sequences.
function pb_edit_triad_sequences_Callback(hObject, eventdata, handles)
% hObject    handle to pb_edit_triad_sequences (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP
PP.dontopenparent=1; %verhindern, dass beim schließen die übergeordnete GUI geöffnet wird
pb_save_Callback(hObject, eventdata, handles) %Speichern und schließen
rgt_edit_triad_seq


% --- Executes on button press in pb_edit_element_sequences.
function pb_edit_element_sequences_Callback(hObject, eventdata, handles)
% hObject    handle to pb_edit_element_sequences (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP
PP.dontopenparent=1; %verhindern, dass beim schließen die übergeordnete GUI geöffnet wird
pb_save_Callback(hObject, eventdata, handles) %Speichern und schließen
rgt_edit_rating_seq


% --- Executes on button press in pb_edit_scales.
function pb_edit_scales_Callback(hObject, eventdata, handles)
% hObject    handle to pb_edit_scales (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP
PP.dontopenparent=1;
pb_save_Callback(hObject, eventdata, handles) %Speichern und schließen
rgt_edit_scale_format


% --- Executes on button press in pb_element_pool.
function pb_element_pool_Callback(hObject, eventdata, handles)
% hObject    handle to pb_element_pool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP
PP.dontopenparent=1; %verhindern, dass beim schließen die übergeordnete GUI geöffnet wird
pb_save_Callback(hObject, eventdata, handles) %Speichern und schließen
rgt_edit_element_pool


function ed_break_between_trials_Callback(hObject, eventdata, handles)
% hObject    handle to ed_break_between_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_break_between_trials as text
%        str2double(get(hObject,'String')) returns contents of ed_break_between_trials as a double


% --- Executes during object creation, after setting all properties.
function ed_break_between_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_break_between_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_maxnum_constructs.
function pop_maxnum_constructs_Callback(hObject, eventdata, handles)
% hObject    handle to pop_maxnum_constructs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_maxnum_constructs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_maxnum_constructs


% --- Executes during object creation, after setting all properties.
function pop_maxnum_constructs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_maxnum_constructs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_constructs_initial_instruction_Callback(hObject, eventdata, handles)
% hObject    handle to ed_constructs_initial_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_constructs_initial_instruction as text
%        str2double(get(hObject,'String')) returns contents of ed_constructs_initial_instruction as a double


% --- Executes during object creation, after setting all properties.
function ed_constructs_initial_instruction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_constructs_initial_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_intermediate_instruction_Callback(hObject, eventdata, handles)
% hObject    handle to ed_intermediate_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_intermediate_instruction as text
%        str2double(get(hObject,'String')) returns contents of ed_intermediate_instruction as a double


% --- Executes during object creation, after setting all properties.
function ed_intermediate_instruction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_intermediate_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_rating_short_instruction_Callback(hObject, eventdata, handles)
% hObject    handle to ed_rating_short_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_rating_short_instruction as text
%        str2double(get(hObject,'String')) returns contents of ed_rating_short_instruction as a double


% --- Executes during object creation, after setting all properties.
function ed_rating_short_instruction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_rating_short_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_rating_initial_instuction_Callback(hObject, eventdata, handles)
% hObject    handle to ed_rating_initial_instuction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_rating_initial_instuction as text
%        str2double(get(hObject,'String')) returns contents of ed_rating_initial_instuction as a double


% --- Executes during object creation, after setting all properties.
function ed_rating_initial_instuction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_rating_initial_instuction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close fig_rgt_edit_main.
function fig_rgt_edit_main_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_rgt_edit_main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP TSP

if PP.dontopenparent~=1
    edit_procedures
end
PP.dontopenparent=0;

% Hint: delete(hObject) closes the figure
delete(hObject);


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

%linke seite auswerten und speichern
%-----------------------------------
TSP.sections{PP.edit_section_line,5}{1,3}=get(handles.pop_maxnum_constructs,'Value');
%radiobutons
rb_tr_1=get(handles.rad_triads_random_order,'Value');
rb_tr_2=get(handles.rad_triads_manual_selection,'Value');
TSP.sections{PP.edit_section_line,5}{1,2}{1,1}=rb_tr_1 + 2*rb_tr_2;
%ergibt 1 bei Auswahl des ersten Buttons und 2 bei Auswahl des zweiten

TSP.sections{PP.edit_section_line,5}{1,4}=cellstr(get(handles.ed_constructs_initial_instruction,'String'));
TSP.sections{PP.edit_section_line,5}{1,5}=cellstr(get(handles.ed_intermediate_instruction,'String'));

%rechte seite auswerten und speichern
%------------------------------------
TSP.sections{PP.edit_section_line,4}{1,7}=str2num(get(handles.ed_break_between_trials,'String'));
%radiobutons
rb_rat_1=get(handles.rad_elements_random_order,'Value');
rb_rat_2=get(handles.rad_elements_manual_selection,'Value');
TSP.sections{PP.edit_section_line,4}{1,6}{1,1}=rb_rat_1 + 2*rb_rat_2;
%ergibt 1 bei Auswahl des ersten Buttons und 2 bei Auswahl des zweiten

TSP.sections{PP.edit_section_line,4}{1,8}=cellstr(get(handles.ed_rating_initial_instuction,'String'));
TSP.sections{PP.edit_section_line,4}{1,9}=cellstr(get(handles.ed_rating_short_instruction,'String'));

save ([PP.path filesep 'TSP.mat'],'TSP');
close


% --- Executes on button press in pb_edit_element_sequences.
function pb_edit_element_setup_Callback(hObject, eventdata, handles)
% hObject    handle to pb_edit_element_sequences (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in rad_triads_random_order.
function rad_triads_random_order_Callback(hObject, eventdata, handles)
% hObject    handle to rad_triads_random_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_triads_random_order

%Value immer auf 1 setzen, damit auswahl nicht durch zweimaliges Drücken
%völlig gelöscht werden kann
set(handles.rad_triads_random_order,'Value', 1);

%edit-Möglichkeit sperren, da random gewählt wurde
set(handles.pb_edit_triad_sequences,'Enable', 'off');


% --- Executes on button press in rad_triads_manual_selection.
function rad_triads_manual_selection_Callback(hObject, eventdata, handles)
% hObject    handle to rad_triads_manual_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_triads_manual_selection

%Value immer auf 1 setzen, damit auswahl nicht durch zweimaliges Drücken
%völlig gelöscht werden kann
set(handles.rad_triads_manual_selection,'Value', 1);

%edit-Möglichkeit freischalten, da manual gewählt wurde
set(handles.pb_edit_triad_sequences,'Enable', 'on');


% --- Executes on button press in rad_elements_random_order.
function rad_elements_random_order_Callback(hObject, eventdata, handles)
% hObject    handle to rad_elements_random_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_elements_random_order

%Value immer auf 1 setzen, damit auswahl nicht durch zweimaliges Drücken
%völlig gelöscht werden kann
set(handles.rad_elements_random_order,'Value', 1);
%edit-Möglichkeit sperren, da random gewählt wurde
set(handles.pb_edit_element_sequences,'Enable', 'off');
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
%User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in rad_elements_manual_selection.
function rad_elements_manual_selection_Callback(hObject, eventdata, handles)
% hObject    handle to rad_elements_manual_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_elements_manual_selection

%Value immer auf 1 setzen, damit auswahl nicht durch zweimaliges Drücken
%völlig gelöscht werden kann
set(handles.rad_elements_manual_selection,'Value', 1);
%edit-Möglichkeit freischalten, da manual gewählt wurde
set(handles.pb_edit_element_sequences,'Enable', 'on');
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
%User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');

