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
% Author :   Fabian Brinkmann,
%            Audio Communication Group, TU Berlin
% Email  :   fabian.brinkmann at tu-berlin dot de
% Date   :   Oct. 2013
% Updated: 
%             
% =========================================================================


function varargout = abchr_mushra_edit_main(varargin)
% abchr_mushra_EDIT_MAIN M-file for abchr_mushra_edit_main.fig
%      abchr_mushra_EDIT_MAIN, by itself, creates a new abchr_mushra_EDIT_MAIN or raises the existing
%      singleton*.
%
%      H = abchr_mushra_EDIT_MAIN returns the handle to a new abchr_mushra_EDIT_MAIN or the handle to
%      the existing singleton*.
%
%      abchr_mushra_EDIT_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in abchr_mushra_EDIT_MAIN.M with the given input arguments.
%
%      abchr_mushra_EDIT_MAIN('Property','Value',...) creates a new abchr_mushra_EDIT_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before abchr_mushra_edit_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to abchr_mushra_edit_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help abchr_mushra_edit_main

% Last Modified by GUIDE v2.5 24-Jul-2014 16:57:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @abchr_mushra_edit_main_OpeningFcn, ...
                   'gui_OutputFcn',  @abchr_mushra_edit_main_OutputFcn, ...
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


% --- Executes just before abchr_mushra_edit_main is made visible.
function abchr_mushra_edit_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to abchr_mushra_edit_main (see VARARGIN)

% Choose default command line output for abchr_mushra_edit_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes abchr_mushra_edit_main wait for user response (see UIRESUME)
% uiwait(handles.fig_abchr_mushra_edit_main);

movegui(hObject,'center');

global TSP PP current_slider_size
load ([PP.path filesep 'TSP.mat']);

% Figure display name
set(hObject,'Name',['Main Settings (' TSP.sections{PP.edit_section_line,2} ')']);

% ----------------------------------------------------- Set Values from TSP

% -------- general settings -------- %
% test type
set(handles.pop_test_type,'Value',TSP.sections{PP.edit_section_line,4}{1,4});

% -------- scale settings -------- %
% Scale size (default = 5)
switch TSP.sections{PP.edit_section_line,4}{1,3}{9}
    case 3
        set(handles.rad_set_scale_size_3, 'Value', 1)    
    case 5
        set(handles.rad_set_scale_size_5, 'Value', 1)
    case 7
        set(handles.rad_set_scale_size_7, 'Value', 1)
end
current_slider_size = TSP.sections{PP.edit_section_line,4}{1,3}{9};

set_pop_scale_steps(handles)
set_scale_assignment(handles)

set(handles.ed_scale_label, 'string', TSP.sections{PP.edit_section_line,4}{1,3}{1,8}{1})

% -------- stimulus settings -------- %
% number of groups and group randomization
set(handles.ed_num_groups, 'string', num2str(TSP.sections{PP.edit_section_line,4}{1,3}{14}));
set(handles.cb_rand_grp, 'value', TSP.sections{PP.edit_section_line,4}{1,3}{17}-1);
% number and randomization of test conditions
set(handles.ed_num_conditions, 'string', num2str(TSP.sections{PP.edit_section_line,4}{1,3}{15}));
set(handles.cb_rand_cond, 'value', TSP.sections{PP.edit_section_line,4}{1,3}{18}-1);

% number of anchor conditions
set(handles.ed_num_anchor, 'string', num2str(TSP.sections{PP.edit_section_line,4}{1,3}{16}));

% en/disable categorization and assessment entities
num_grps  = str2double(get(handles.ed_num_groups, 'string'));
num_cond  = str2double(get(handles.ed_num_conditions, 'string'));
num_anch  = str2double(get(handles.ed_num_anchor, 'string'));

%Stimuli setting
if isempty(TSP.sections{PP.edit_section_line,4}{5})
    TSP.sections{PP.edit_section_line,4}{5} = zeros(1, num_grps*(num_cond+num_anch+1));
end
set_conditions(handles)

% -------- instructions -------- %
set(handles.ed_rating_instruction,'String', TSP.sections{PP.edit_section_line,4}{1,1});
set(handles.ed_initial_subject_instruction,'String', TSP.sections{PP.edit_section_line,4}{1,2});



% --- Outputs from this function are returned to the command line.
function varargout = abchr_mushra_edit_main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes when user attempts to close fig_abchr_mushra_edit_main.
function fig_abchr_mushra_edit_main_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_abchr_mushra_edit_main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP

if PP.dontopenparent~=1
    edit_procedures
end
PP.dontopenparent=0;

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in pb_save.
function pb_save_Callback(hObject, eventdata, handles)
% hObject    handle to pb_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP TSP current_slider_size all_conditions_assigned

% save settings to TSP
TSP.sections{PP.edit_section_line,4}{1,1} = get(handles.ed_rating_instruction,'String');
TSP.sections{PP.edit_section_line,4}{1,2} = get(handles.ed_initial_subject_instruction,'String');
TSP.sections{PP.edit_section_line,4}{1,4} = get(handles.pop_test_type,'value');
TSP.sections{PP.edit_section_line,4}{1,3}{9} = current_slider_size;
TSP.sections{PP.edit_section_line,4}{1,3}{14} = str2double(get(handles.ed_num_groups,'string'));
TSP.sections{PP.edit_section_line,4}{1,3}{15} = str2double(get(handles.ed_num_conditions,'string'));
TSP.sections{PP.edit_section_line,4}{1,3}{16} = str2double(get(handles.ed_num_anchor,'string'));
TSP.sections{PP.edit_section_line,4}{1,3}{17} = get(handles.cb_rand_grp,'value')+1;
TSP.sections{PP.edit_section_line,4}{1,3}{18} = get(handles.cb_rand_cond,'value')+1;

% check if all test conditions have stimuli assigned
set_show_assignmant_popup(handles)

% save TSP
save ([PP.path filesep 'TSP.mat'],'TSP');
close

% go to next screen
edit_procedures

% output warning if some conditions have no stimulus assigned
if ~all_conditions_assigned
    PP.whisper_message = {'Warning: At least one condition is missing a stimulus assignment', '-', 'Fix this before conducting a test'};
    whisper_message
end


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

 % --- Executes on key press with focus on ed_initial_subject_instruction and no controls selected.
function ed_initial_subject_instruction_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_initial_subject_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in cb_randomstimuli.
function cb_randomstimuli_Callback(hObject, eventdata, handles)
% hObject    handle to cb_randomstimuli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_randomstimuli


% --- Executes when selected object is changed in pan_set_scale_size.
function pan_set_scale_size_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in pan_set_scale_size 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global TSP PP current_slider_size

% get current scale size
tmp = get(eventdata.NewValue,'Tag');
current_slider_size = str2double(tmp(end));

% set pop up menue for selecting scale labes
set_pop_scale_steps(handles)
set(handles.pop_scale_steps, 'value', 1)
% set cell array for setting scale labels
TSP.sections{PP.edit_section_line,4}{1,3}{1,8} = cell(current_slider_size,1);
set(handles.ed_scale_label, 'string', '');

set_scale_assignment(handles)

% --- Executes during object creation, after setting all properties.
function pan_scale_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pan_scale_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function pan_set_scale_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pan_set_scale_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function ed_num_conditions_Callback(hObject, eventdata, handles)
% hObject    handle to ed_num_conditions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_num_conditions as text
%        str2double(get(hObject,'String')) returns contents of ed_num_conditions as a double
global TSP PP

% re-initialize stimuli vector, if neccessary
num_grps  = str2double(get(handles.ed_num_groups, 'string'));
num_cond  = str2double(get(handles.ed_num_conditions, 'string'));
num_anch  = str2double(get(handles.ed_num_anchor, 'string'));
TSP.sections{PP.edit_section_line,4}{1,5} = zeros(1, num_grps*(1+num_anch+num_cond));

if num_cond + num_anch >26
    PP.whisper_message = 'Number of test conditions plus number of anchors must not exceed 26';
    whisper_message
    set(hObject,'String', num2str(26-num_anch));
end

set_conditions(handles)


% --- Executes during object creation, after setting all properties.
function ed_num_conditions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_num_conditions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_conditions.
function pop_conditions_Callback(hObject, eventdata, handles)
% hObject    handle to pop_conditions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_conditions contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_conditions
set(handles.pop_cond_assignment, 'value', 1);
set_stimuli(handles)


% --- Executes during object creation, after setting all properties.
function pop_conditions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_conditions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_cond_assignment.
function pop_cond_assignment_Callback(hObject, eventdata, handles)
% hObject    handle to pop_cond_assignment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_cond_assignment contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_cond_assignment
global TSP PP

selection     = get(hObject,'Value')-2;
cur_condition = get(handles.pop_conditions, 'value');
assignments   = TSP.sections{PP.edit_section_line,4}{5};

if selection >= 1
    % write new assignment to stimulus vactor
    assignments(cur_condition) = selection;
    % write chosen stimulus to pop-up menue
    tmp = get(hObject, 'string');
    tmp{1} = tmp{selection+2};
    set(hObject, 'string', tmp);
end

TSP.sections{PP.edit_section_line,4}{1,5} = assignments;
set(hObject,'Value', 1);

set_show_assignmant_popup(handles)


% --- Executes during object creation, after setting all properties.
function pop_cond_assignment_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_cond_assignment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_show_assignment.
function pop_show_assignment_Callback(hObject, eventdata, handles)
% hObject    handle to pop_show_assignment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_show_assignment contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_show_assignment
if get(hObject, 'value')-2 > 0
    set(handles.pop_conditions, 'value', get(hObject, 'value')-2)
    set_stimuli(handles)
end
set(hObject, 'value', 1)


% --- Executes during object creation, after setting all properties.
function pop_show_assignment_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_show_assignment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ed_num_groups_Callback(hObject, eventdata, handles)
% hObject    handle to ed_num_groups (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_num_groups as text
%        str2double(get(hObject,'String')) returns contents of ed_num_groups as a double
global TSP PP

% re-initialize stimuli vector, if neccessary
num_grps  = str2double(get(handles.ed_num_groups, 'string'));
num_cond  = str2double(get(handles.ed_num_conditions, 'string'));
num_anch  = str2double(get(handles.ed_num_anchor, 'string'));
TSP.sections{PP.edit_section_line,4}{1,5} = zeros(1, num_grps*(1+num_anch+num_cond));

set_conditions(handles)

% --- Executes during object creation, after setting all properties.
function ed_num_groups_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_num_groups (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_num_anchor_Callback(hObject, eventdata, handles)
% hObject    handle to ed_num_anchor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_num_anchor as text
%        str2double(get(hObject,'String')) returns contents of ed_num_anchor as a double
global TSP PP

% re-initialize stimuli vector, if neccessary
num_grps  = str2double(get(handles.ed_num_groups, 'string'));
num_cond  = str2double(get(handles.ed_num_conditions, 'string'));
num_anch  = str2double(get(handles.ed_num_anchor, 'string'));
TSP.sections{PP.edit_section_line,4}{1,5} = zeros(1, num_grps*(1+num_anch+num_cond));

if num_anch > 3
    PP.whisper_message = 'Number of anchor conditions must 3 or less';
    whisper_message
    num_anch = 3;
    set(hObject,'String', '3');
end


if num_cond + num_anch >26
    PP.whisper_message = 'Number of test conditions plus number of anchors must not exceed 26';
    whisper_message
    set(hObject,'String', num2str(26-num_cond));
end

set_conditions(handles)


% --- Executes during object creation, after setting all properties.
function ed_num_anchor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_num_anchor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function set_conditions(handles)

% reset pop-up-menues in case of parameter change
set(handles.pop_conditions, 'value', 1);

num_grps  = str2double(get(handles.ed_num_groups, 'string'));
num_cond  = str2double(get(handles.ed_num_conditions, 'string'));
num_anch  = str2double(get(handles.ed_num_anchor, 'string'));

% fill the left pop-up menue
for k = 1:num_grps
    m = (k-1)*num_cond + (k-1)*num_anch + (k-1);
    tmp{m+1} = ['A' num2str(k) ' Reference condition'];
    for l = 1:num_anch
        tmp{m+l+1} = [char(65+l) num2str(k) ' Anchor condition'];
    end
    for o = 1:num_cond
        tmp{m+o+num_anch+1} = [char(65+o+num_anch) num2str(k) ' Test condition'];
    end
end
set(handles.pop_conditions, 'string', tmp);

% fill the right pop-up menue
set_stimuli(handles)


function set_stimuli(handles)
global TSP PP

cur_cond  = get(handles.pop_conditions, 'value');
cur_name  = get(handles.pop_conditions, 'string');
cur_name  = cur_name{cur_cond};

assignments = TSP.sections{PP.edit_section_line,4}{5};

% get ID and name of currently selected stimulus
if assignments(cur_cond) ~= 0
    cur_stim = TSP.sections{PP.edit_section_line,4}{1,5}(1,cur_cond);
    tmp{1} = ['S' str_to_len(num2str(TSP.stimuli{cur_stim,1}),4) TSP.stimuli{cur_stim,2}]; % ID and name
else
    tmp{1} = 'not assigned';
end

tmp{2} = '-----------------';

for i=1:length(TSP.stimuli(:,1))
    tmp{i+2}=['S' str_to_len(num2str(TSP.stimuli{i,1}),4) TSP.stimuli{i,2}];
end

set(handles.pop_cond_assignment, 'string', tmp);

set_show_assignmant_popup(handles);



function set_show_assignmant_popup(handles)
global TSP PP all_conditions_assigned

all_conditions_assigned = true;

num_grps  = str2double(get(handles.ed_num_groups, 'string'));
num_cond  = str2double(get(handles.ed_num_conditions, 'string'));
num_anch  = str2double(get(handles.ed_num_anchor, 'string'));

conditions = get(handles.pop_conditions, 'string');

tmp{1} = 'show assignment';
tmp{2} = '-----------------';

for n = 1:num_grps*(1+num_anch+num_cond)
    condition_assignment = TSP.sections{PP.edit_section_line,4}{1,5}(1,n);
    if condition_assignment == 0
            tmp{n+2} = [str_to_len(conditions{n},25) ': Not assigned'];
            all_conditions_assigned = false;
    else
        tmp{n+2} = [str_to_len(conditions{n},25) ': S' str_to_len(num2str(TSP.stimuli{condition_assignment,1}),4) TSP.stimuli{condition_assignment,2}];
    end
end

set(handles.pop_show_assignment, 'string', tmp);


% --- Executes on selection change in pop_rand_grp.
function pop_rand_grp_Callback(hObject, eventdata, handles)
% hObject    handle to pop_rand_grp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_rand_grp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_rand_grp


% --- Executes during object creation, after setting all properties.
function pop_rand_grp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_rand_grp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_rand_cond.
function pop_rand_cond_Callback(hObject, eventdata, handles)
% hObject    handle to pop_rand_cond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_rand_cond contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_rand_cond


% --- Executes during object creation, after setting all properties.
function pop_rand_cond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_rand_cond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_gui_settings.
function pb_gui_settings_Callback(hObject, eventdata, handles)
% hObject    handle to pb_gui_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
abchr_mushra_gui_settings



function ed_rating_instruction_Callback(hObject, eventdata, handles)
% hObject    handle to ed_rating_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_rating_instruction as text
%        str2double(get(hObject,'String')) returns contents of ed_rating_instruction as a double


% --- Executes during object creation, after setting all properties.
function ed_rating_instruction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_rating_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_scale_label_Callback(hObject, eventdata, handles)
% hObject    handle to ed_scale_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_scale_label as text
%        str2double(get(hObject,'String')) returns contents of ed_scale_label as a double
global TSP PP

scale_step = get(handles.pop_scale_steps, 'value');
TSP.sections{PP.edit_section_line,4}{1,3}{1,8}{scale_step,1} = get(hObject, 'string');

set_scale_assignment(handles)


% --- Executes during object creation, after setting all properties.
function ed_scale_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_scale_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_scale_assignment.
function pop_scale_assignment_Callback(hObject, eventdata, handles)
% hObject    handle to pop_scale_assignment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_scale_assignment contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_scale_assignment
global TSP PP

if get(hObject, 'value')-2 > 0
    set(handles.pop_scale_steps, 'value', get(hObject, 'value')-2)
    set(handles.ed_scale_label, 'string', TSP.sections{PP.edit_section_line,4}{1,3}{1,8}{get(hObject, 'value')-2})
end

set(hObject, 'value', 1)

% --- Executes during object creation, after setting all properties.
function pop_scale_assignment_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_scale_assignment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_scale_steps.
function pop_scale_steps_Callback(hObject, eventdata, handles)
% hObject    handle to pop_scale_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_scale_steps contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_scale_steps
global TSP PP

set(handles.ed_scale_label, 'string', TSP.sections{PP.edit_section_line,4}{1,3}{1,8}{get(hObject, 'value'),1})

% --- Executes during object creation, after setting all properties.
function pop_scale_steps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_scale_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_test_type.
function pop_test_type_Callback(hObject, eventdata, handles)
% hObject    handle to pop_test_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_test_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_test_type


% --- Executes during object creation, after setting all properties.
function pop_test_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_test_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cb_rand_grp.
function cb_rand_grp_Callback(hObject, eventdata, handles)
% hObject    handle to cb_rand_grp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_rand_grp


% --- Executes on button press in cb_rand_cond.
function cb_rand_cond_Callback(hObject, eventdata, handles)
% hObject    handle to cb_rand_cond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_rand_cond

function set_pop_scale_steps(handles)
global current_slider_size

tmp = {};
for n = 1:current_slider_size
    tmp{n,1} = num2str(n-1);
end

set(handles.pop_scale_steps, 'string', tmp)


function set_scale_assignment(handles)
global TSP PP current_slider_size
tmp = {'show assignment'; '---------------------'};

for n = 1:current_slider_size
    tmp{n+2,1} = [num2str(n-1) ': ' TSP.sections{PP.edit_section_line,4}{1,3}{1,8}{n,1}];
end

set(handles.pop_scale_assignment, 'string', tmp)


% --- Executes during object creation, after setting all properties.
function pan_set_scale_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pan_set_scale_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in rad_set_scale_size_3.
function rad_set_scale_size_3_Callback(hObject, eventdata, handles)
% hObject    handle to rad_set_scale_size_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_set_scale_size_3


% --- Executes on button press in rad_set_scale_size_5.
function rad_set_scale_size_5_Callback(hObject, eventdata, handles)
% hObject    handle to rad_set_scale_size_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_set_scale_size_5


% --- Executes on button press in rad_set_scale_size_7.
function rad_set_scale_size_7_Callback(hObject, eventdata, handles)
% hObject    handle to rad_set_scale_size_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_set_scale_size_7
