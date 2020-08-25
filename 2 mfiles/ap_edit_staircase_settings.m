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


function varargout = ap_edit_staircase_settings(varargin)
% AP_EDIT_STAIRCASE_SETTINGS M-file for ap_edit_staircase_settings.fig
%      AP_EDIT_STAIRCASE_SETTINGS, by itself, creates a new AP_EDIT_STAIRCASE_SETTINGS or raises the existing
%      singleton*.
%
%      H = AP_EDIT_STAIRCASE_SETTINGS returns the handle to a new AP_EDIT_STAIRCASE_SETTINGS or the handle to
%      the existing singleton*.
%
%      AP_EDIT_STAIRCASE_SETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AP_EDIT_STAIRCASE_SETTINGS.M with the given input arguments.
%
%      AP_EDIT_STAIRCASE_SETTINGS('Property','Value',...) creates a new AP_EDIT_STAIRCASE_SETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ap_edit_staircase_settings_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ap_edit_staircase_settings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ap_edit_staircase_settings

% Last Modified by GUIDE v2.5 26-Oct-2008 23:26:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ap_edit_staircase_settings_OpeningFcn, ...
                   'gui_OutputFcn',  @ap_edit_staircase_settings_OutputFcn, ...
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


% --- Executes just before ap_edit_staircase_settings is made visible.
function ap_edit_staircase_settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ap_edit_staircase_settings (see VARARGIN)

% Choose default command line output for ap_edit_staircase_settings
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ap_edit_staircase_settings wait for user response (see UIRESUME)
% uiwait(handles.fig_staircase_settings);

movegui(hObject,'center')
global TSP PP
load ([PP.path filesep 'TSP.mat']);
%Auffüllen der GUI mit den gepeicherten Werten
set(hObject,'Name',['AP - edit staircase settings (' TSP.sections{PP.edit_section_line,2} '; Track: ' TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,6} ')']);
%stimulus domain
set(handles.ed_reversals, 'String', num2str(TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,2}))
if TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,1}==1 %GUI-Voreinstellung 0 (no)
    set(handles.rad_yes,'Value', 1);
    set(handles.ed_reversals,'Enable', 'on');
end
%initial-level-Box auffüllen, maximaler Wert ist range
range=TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(1,1);
set(handles.pop_initial_level, 'String', [1:range]);
initial_level=TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,3};
if (initial_level==0) || (initial_level>range) %falls noch nicht zugewiesen oder zu groß (falls der range verkleinert wurde)
    initial_level=range;
end
set(handles.pop_initial_level, 'Value', initial_level);  
%adaption rule
if TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,4}==2 %Voreinstellung der GUI ist Auswahl 1 (1up/1down)
    set(handles.rad_2_1,'Value', 1);
end
if TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,4}==3
    set(handles.rad_3_1,'Value', 1);
end
%termination
set(handles.ed_number_of_reversals, 'String', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,5});
set(handles.ed_jump_out_after, 'String', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,6});
%estimation
set(handles.ed_averaging_reversals, 'String', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,7});
set(handles.cb_secondary_termination, 'Value', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,8});
if get(handles.cb_secondary_termination,'Value')==1
    set(handles.ed_jump_out_after, 'Enable','On')
end


% --- Outputs from this function are returned to the command line.
function varargout = ap_edit_staircase_settings_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function ed_initial_stepsize_Callback(hObject, eventdata, handles)
% hObject    handle to ed_initial_stepsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_initial_stepsize as text
%        str2double(get(hObject,'String')) returns contents of ed_initial_stepsize as a double


% --- Executes during object creation, after setting all properties.
function ed_initial_stepsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_initial_stepsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_jump_out_after_Callback(hObject, eventdata, handles)
% hObject    handle to ed_jump_out_after (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_jump_out_after as text
%        str2double(get(hObject,'String')) returns contents of ed_jump_out_after as a double

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function ed_jump_out_after_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_jump_out_after (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_number_of_reversals_Callback(hObject, eventdata, handles)
% hObject    handle to ed_number_of_reversals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_number_of_reversals as text
%        str2double(get(hObject,'String')) returns contents of ed_number_of_reversals as a double


% --- Executes during object creation, after setting all properties.
function ed_number_of_reversals_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_number_of_reversals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_calculate_initial_stepsize.
function pb_calculate_initial_stepsize_Callback(hObject, eventdata, handles)
% hObject    handle to pb_calculate_initial_stepsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP
halfings_enabled=get(handles.rad_yes,'Value');
if halfings_enabled==1
    halfings_string=get(handles.ed_reversals, 'String');
    halfings_vector=strread(halfings_string);
    set(handles.ed_reversals, 'String', num2str(halfings_vector)); %eingegebenes wird neu dargestellt zur Kontrolle, ob sinnvoll eingeben
    number_of_reversals=length(halfings_vector);
    initial_stepsize=2^number_of_reversals;
else
    initial_stepsize=1;
end
set(handles.ed_initial_stepsize,'String', initial_stepsize);


function ed_reversals_Callback(hObject, eventdata, handles)
% hObject    handle to ed_reversals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_reversals as text
%        str2double(get(hObject,'String')) returns contents of ed_reversals as a double


% --- Executes during object creation, after setting all properties.
function ed_reversals_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_reversals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_averaging_reversals_Callback(hObject, eventdata, handles)
% hObject    handle to ed_averaging_reversals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_averaging_reversals as text
%        str2double(get(hObject,'String')) returns contents of ed_averaging_reversals as a double


% --- Executes during object creation, after setting all properties.
function ed_averaging_reversals_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_averaging_reversals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on ed_reversals and no controls selected.
function ed_reversals_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_reversals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%initial stepsize-feld löschen, da sich diese nun ändern könnte
set(handles.ed_initial_stepsize,'String', '');
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on selection change in pop_initial_level.
function pop_initial_level_Callback(hObject, eventdata, handles)
% hObject    handle to pop_initial_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_initial_level contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_initial_level

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function pop_initial_level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_initial_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in rad_no.
function rad_no_Callback(hObject, eventdata, handles)
% hObject    handle to rad_no (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_no

global TSP PP
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,1}=0;
set(handles.rad_no,'Value', 1);
set(handles.ed_reversals,'Enable', 'off');
set(handles.ed_initial_stepsize,'String', '');
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');



% --- Executes on button press in rad_yes.
function rad_yes_Callback(hObject, eventdata, handles)
% hObject    handle to rad_yes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_yes

global TSP PP
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,1}=1;
set(handles.rad_yes,'Value', 1);
set(handles.ed_reversals,'Enable', 'on');
set(handles.ed_initial_stepsize,'String', '');
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
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
global PP TSP
halfings_string=get(handles.ed_reversals, 'String');
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,2}=strread(halfings_string);
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,3}=get(handles.pop_initial_level,'Value');
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,5}=str2num(get(handles.ed_number_of_reversals,'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,6}=str2num(get(handles.ed_jump_out_after,'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,7}=str2num(get(handles.ed_averaging_reversals,'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,8}=get(handles.cb_secondary_termination,'Value');
save ([PP.path filesep 'TSP.mat'],'TSP');
close


% --- Executes on button press in rad_1_1.
function rad_1_1_Callback(hObject, eventdata, handles)
% hObject    handle to rad_1_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_1_1
global TSP PP
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,4}=1;
set(handles.rad_1_1,'Value', 1);
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in rad_2_1.
function rad_2_1_Callback(hObject, eventdata, handles)
% hObject    handle to rad_2_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_2_1
global TSP PP
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,4}=2;
set(handles.rad_2_1,'Value', 1);
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in rad_3_1.
function rad_3_1_Callback(hObject, eventdata, handles)
% hObject    handle to rad_3_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_3_1
global TSP PP
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,2}{1,4}=3;
set(handles.rad_3_1,'Value', 1);
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes when user attempts to close fig_staircase_settings.
function fig_staircase_settings_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_staircase_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
if PP.dontopenparent~=1
    ap_edit_track_settings
end
PP.dontopenparent=0;

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on key press with focus on ed_number_of_reversals and no controls selected.
function ed_number_of_reversals_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_number_of_reversals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_averaging_reversals and no controls selected.
function ed_averaging_reversals_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_averaging_reversals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in cb_secondary_termination.
function cb_secondary_termination_Callback(hObject, eventdata, handles)
% hObject    handle to cb_secondary_termination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_secondary_termination

state=get(handles.cb_secondary_termination,'Value');
switch state
    case 0
        set(handles.ed_jump_out_after,'Enable', 'Off');
    case 1
        set(handles.ed_jump_out_after,'Enable', 'On');
end

