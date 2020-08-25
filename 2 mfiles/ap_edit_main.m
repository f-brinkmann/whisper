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
% Updated:   20-Nov-2008 minor change in function for deleting tracks
% =========================================================================


function varargout = ap_edit_main(varargin)
% AP_EDIT_MAIN M-file for ap_edit_main.fig
%      AP_EDIT_MAIN, by itself, creates a new AP_EDIT_MAIN or raises the existing
%      singleton*.
%
%      H = AP_EDIT_MAIN returns the handle to a new AP_EDIT_MAIN or the handle to
%      the existing singleton*.
%
%      AP_EDIT_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AP_EDIT_MAIN.M with the given input arguments.
%
%      AP_EDIT_MAIN('Property','Value',...) creates a new AP_EDIT_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ap_edit_main_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ap_edit_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ap_edit_main

% Last Modified by GUIDE v2.5 03-Sep-2009 15:51:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ap_edit_main_OpeningFcn, ...
                   'gui_OutputFcn',  @ap_edit_main_OutputFcn, ...
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


% --- Executes just before ap_edit_main is made visible.
function ap_edit_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ap_edit_main (see VARARGIN)

% Choose default command line output for ap_edit_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ap_edit_main wait for user response (see UIRESUME)
% uiwait(handles.fig_ap_edit_main);

movegui(hObject,'center')
global TSP PP
load ([PP.path filesep 'TSP.mat']);
%Auff?llen der GUI mit den gepeicherten Werten
set(hObject,'Name',['AP - main settings (' TSP.sections{PP.edit_section_line,2} ')']);
set(handles.ed_break_between_trials,'String', TSP.sections{PP.edit_section_line,4}{1,1});
set(handles.ed_initial_subject_instruction,'String', TSP.sections{PP.edit_section_line,4}{1,2});
set(handles.ed_short_instruction,'String', TSP.sections{PP.edit_section_line,4}{1,3});
if TSP.sections{PP.edit_section_line,4}{1,4}{1,1}==2 %Voreinstellung ist Auswahl 1
    set(handles.rad_multi_session_use,'Value', 1);
    set(handles.pb_organize_sessions,'Enable', 'on');
end
fill_list(handles)


function fill_list(handles)
% Inhalt der Track-Liste wird generiert.
% Mit Hilfe der Funktion str_to_len.m werden die Inhalte in die richtige
% L?nge gebracht f?r die tabellarisch korrekte Darstellung, jeder
% generiert dabei eine Zeile der Liste.
global TSP PP

for i=1:length(TSP.sections{PP.edit_section_line,4}(:,6))
   tracks{i,1}=['Track ' num2str(i) ': ' ...%Spalte: ID 
                      str_to_len(TSP.sections{PP.edit_section_line,4}{i,6}, 25)];      %Spalte: name
end
set(handles.lb_tracks,'String', tracks);


% --- Outputs from this function are returned to the command line.
function varargout = ap_edit_main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_settings_nafc.
function pb_settings_nafc_Callback(hObject, eventdata, handles)
% hObject    handle to pb_settings_nafc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP
PP.dontopenparent=1; %verhindern, dass beim schlie?en die ?bergeordnete GUI ge?ffnet wird
pb_save_Callback(hObject, eventdata, handles) %Speichern und schlie?en
ap_edit_nafc_settings


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


% --- Executes on button press in pb_edit.
function pb_edit_Callback(hObject, eventdata, handles)
% hObject    handle to pb_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
PP.edit_track_line=get(handles.lb_tracks,'Value');
PP.dontopenparent=1; %verhindern, dass beim schlie?en die ?bergeordnete GUI ge?ffnet wird
pb_save_Callback(hObject, eventdata, handles) %Speichern und schlie?en
ap_edit_track_settings
handles;


% --- Executes on selection change in lb_tracks.
function lb_tracks_Callback(hObject, eventdata, handles)
% hObject    handle to lb_tracks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lb_tracks contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_tracks


% --- Executes during object creation, after setting all properties.
function lb_tracks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_tracks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_organize_sessions.
function pb_organize_sessions_Callback(hObject, eventdata, handles)
% hObject    handle to pb_organize_sessions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP
PP.dontopenparent=1; %verhindern, dass beim schlie?en die ?bergeordnete GUI ge?ffnet wird
pb_save_Callback(hObject, eventdata, handles) %Speichern und schlie?en
ap_edit_sessions


function ed_initial_subject_instruction_Callback(hObject, eventdata, handles)
% hObject    handle to ed_initial_subject_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_initial_subject_instruction as text
%        str2double(get(hObject,'String')) returns contents of ed_initial_subject_instruction as a double


% --- Executes during object creation, after setting all properties.
function ed_initial_subject_instruction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_initial_subject_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_short_instruction_Callback(hObject, eventdata, handles)
% hObject    handle to ed_short_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_short_instruction as text
%        str2double(get(hObject,'String')) returns contents of ed_short_instruction as a double


% --- Executes during object creation, after setting all properties.
function ed_short_instruction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_short_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rad_interleave_all_tracks.
function rad_interleave_all_tracks_Callback(hObject, eventdata, handles)
% hObject    handle to rad_interleave_all_tracks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_interleave_all_tracks

%Value immer auf 1 setzen, damit auswahl nicht durch zweimaliges Dr?cken
%v?llig gel?scht werden kann
set(handles.rad_interleave_all_tracks,'Value', 1);
%edit-M?glichkeit sperren, da interleave gew?hlt wurde
set(handles.pb_organize_sessions,'Enable', 'off');
%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
%User m?glicherweise R?ckg?ngig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in rad_multi_session_use.
function rad_multi_session_use_Callback(hObject, eventdata, handles)
% hObject    handle to rad_multi_session_use (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_multi_session_use

%Value immer auf 1 setzen, damit auswahl nicht durch zweimaliges Dr?cken
%v?llig gel?scht werden kann
set(handles.rad_multi_session_use,'Value', 1);
%edit-M?glichkeit erlaube, da organize gew?hlt wurde
set(handles.pb_organize_sessions,'Enable', 'on');
%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
%User m?glicherweise R?ckg?ngig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in pb_add_new_track.
function pb_add_new_track_Callback(hObject, eventdata, handles)
% hObject    handle to pb_add_new_track (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP PC
newline=length(TSP.sections{PP.edit_section_line,4}(:,7))+1;
TSP.sections{PP.edit_section_line,4}{newline,6}=PC.emptydata_stimulus{1,1}; % der default-Name f?r Stimuli
TSP.sections{PP.edit_section_line,4}{newline,7}=PC.emptydata_track_ap_nafc;

% f?r ML/Bayes guessing rate anpassen, da diese hier fest 1/n ist.
n=TSP.sections{PP.edit_section_line,4}{1,8}{1,1};
TSP.sections{PP.edit_section_line,4}{newline,7}{1,4}{1,2}=1/n;
fill_list(handles)
%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
%User m?glicherweise R?ckg?ngig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in pb_delete_track.
function pb_delete_track_Callback(hObject, eventdata, handles)
% hObject    handle to pb_delete_track (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP
deleteline=get(handles.lb_tracks,'Value');
if length(TSP.sections{PP.edit_section_line,4}(:,1))>1
   set(handles.lb_tracks,'Value', 1);
   TSP.sections{PP.edit_section_line,4}(deleteline,:)=[];
   fill_list(handles);
 %Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
 %User m?glicherweise R?ckg?ngig machen will
   set(handles.pb_cancel,'Enable', 'on');
else
    PP.whisper_message='Last track cannot be deleted.';
    whisper_message;
end    


% --- Executes on button press in pb_move_up.
function pb_move_up_Callback(hObject, eventdata, handles)
% hObject    handle to pb_move_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
line_to_move_up=get(handles.lb_tracks, 'Value');
if line_to_move_up > 1
    temp=TSP.sections{PP.edit_section_line,4}(line_to_move_up-1,6);
    TSP.sections{PP.edit_section_line,4}(line_to_move_up-1,6)=TSP.sections{PP.edit_section_line,4}(line_to_move_up,6);
    TSP.sections{PP.edit_section_line,4}(line_to_move_up,6)=temp;
    temp=TSP.sections{PP.edit_section_line,4}(line_to_move_up-1,7);
    TSP.sections{PP.edit_section_line,4}(line_to_move_up-1,7)=TSP.sections{PP.edit_section_line,4}(line_to_move_up,7);
    TSP.sections{PP.edit_section_line,4}(line_to_move_up,7)=temp;
    fill_list(handles)
    set(handles.lb_tracks,'Value', line_to_move_up-1);
    %Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
    %User m?glicherweise R?ckg?ngig machen will
    set(handles.pb_cancel,'Enable', 'on');
end


% --- Executes on button press in pb_move_down.
function pb_move_down_Callback(hObject, eventdata, handles)
% hObject    handle to pb_move_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
line_to_move_down=get(handles.lb_tracks, 'Value');
lastline=length(TSP.sections{PP.edit_section_line,4}(:,7));
  if line_to_move_down < lastline
      temp=TSP.sections{PP.edit_section_line,4}(line_to_move_down+1,6);
      TSP.sections{PP.edit_section_line,4}(line_to_move_down+1,6)=TSP.sections{PP.edit_section_line,4}(line_to_move_down,6);
      TSP.sections{PP.edit_section_line,4}(line_to_move_down,6)=temp;
      temp=TSP.sections{PP.edit_section_line,4}(line_to_move_down+1,7);
      TSP.sections{PP.edit_section_line,4}(line_to_move_down+1,7)=TSP.sections{PP.edit_section_line,4}(line_to_move_down,7);
      TSP.sections{PP.edit_section_line,4}(line_to_move_down,7)=temp;
      fill_list(handles)
      set(handles.lb_tracks,'Value', line_to_move_down+1);
     %Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
     %User m?glicherweise R?ckg?ngig machen will
      set(handles.pb_cancel,'Enable', 'on');
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
TSP.sections{PP.edit_section_line,4}{1,1}=get(handles.ed_break_between_trials,'String');
TSP.sections{PP.edit_section_line,4}{1,2}=cellstr(get(handles.ed_initial_subject_instruction,'String'));
TSP.sections{PP.edit_section_line,4}{1,3}=cellstr(get(handles.ed_short_instruction,'String'));

save PP.mat PP

%radiobutons
rb_1=get(handles.rad_interleave_all_tracks,'Value');
rb_2=get(handles.rad_multi_session_use,'Value');
TSP.sections{PP.edit_section_line,4}{1,4}{1,1}=rb_1 + 2*rb_2;
%ergibt 1 bei Auswahl des ersten Buttons und 2 bei Auswahl des zweiten

save ([PP.path filesep 'TSP.mat'],'TSP');
close


% --- Executes when user attempts to close fig_ap_edit_main.
function fig_ap_edit_main_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_ap_edit_main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
if PP.dontopenparent~=1
    edit_procedures
end
PP.dontopenparent=0;

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on key press with focus on ed_break_between_trials and no controls selected.
function ed_break_between_trials_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_break_between_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der User m?glicherweise R?ckg?ngig machen will
 set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_initial_subject_instruction and no controls selected.
function ed_initial_subject_instruction_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_initial_subject_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der User m?glicherweise R?ckg?ngig machen will
 set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_short_instruction and no controls selected.
function ed_short_instruction_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_short_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der User m?glicherweise R?ckg?ngig machen will
 set(handles.pb_cancel,'Enable', 'on');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pb_save.
function pb_save_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pb_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



