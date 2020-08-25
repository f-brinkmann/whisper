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
% Author :   Martina Vrhovnik and Fabian Brinkmann,
%            Audio Communication Group, TU Berlin
% Email  :   fabian.brinkmann at tu-berlin dot de
% Date   :   Oct. 2013
% Updated: 
%             
% =========================================================================

function varargout = saqi_vp_7(varargin)
% SAQI_VP_6 MATLAB code for saqi_vp_7.fig
%      SAQI_VP_6, by itself, creates a new SAQI_VP_6 or raises the existing
%      singleton*.
%
%      H = SAQI_VP_6 returns the handle to a new SAQI_VP_6 or the handle to
%      the existing singleton*.
%
%      SAQI_VP_6('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAQI_VP_6.M with the given input arguments.
%
%      SAQI_VP_6('Property','Value',...) creates a new SAQI_VP_6 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before saqi_vp_7_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to saqi_vp_7_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help saqi_vp_7

% Last Modified by GUIDE v2.5 21-Jul-2014 15:35:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @saqi_vp_7_OpeningFcn, ...
                   'gui_OutputFcn',  @saqi_vp_7_OutputFcn, ...
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


% --- Executes just before saqi_vp_7 is made visible.
function saqi_vp_7_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to saqi_vp_7 (see VARARGIN)

% Choose default command line output for saqi_vp_7
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes saqi_vp_7 wait for user response (see UIRESUME)
% uiwait(handles.saqi_vp_7);
movegui(hObject,'center');
global PP TSP

% Figure display name
set(hObject,'Name',['Quality ' num2str(PP.current_id) '/' num2str(PP.number_of_items) ' (' TSP.sections{PP.run_section_line,2} ')']);

% set question
set(handles.txt_question, 'String', TSP.sections{PP.run_section_line,4}{1,9}{13,2});

%set entity names 
set(handles.txt_bezugsobjekt_1, 'String', TSP.sections{PP.run_section_line,4}{1,11}{1,2});
set(handles.txt_bezugsobjekt_2, 'String', TSP.sections{PP.run_section_line,4}{1,11}{2,2});
set(handles.txt_bezugsobjekt_3, 'String', TSP.sections{PP.run_section_line,4}{1,11}{3,2});
set(handles.txt_bezugsobjekt_4, 'String', TSP.sections{PP.run_section_line,4}{1,11}{4,2});
set(handles.txt_bezugsobjekt_5, 'String', TSP.sections{PP.run_section_line,4}{1,11}{5,2});
set(handles.txt_bezugsobjekt_weiss_nicht, 'String', TSP.sections{PP.run_section_line,4}{1,11}{6,2});
set(handles.txt_bezugsobjekt_sonstiges, 'String', TSP.sections{PP.run_section_line,4}{1,11}{7,2});

% make play_B button invisible if we are comparing against a inner reference
if TSP.sections{PP.run_section_line,4}{1,3}{11}
    set(handles.pb_play_a, 'Visible', 'off');
    set(handles.pb_play_b, 'Position', [300 86 84 24], 'string', 'Play A');
end

tmp_entities = cell2mat(TSP.sections{PP.run_section_line,4}{1,10});

% set visibility based on selected entities
if isempty(find(tmp_entities == 1))
    set(handles.txt_bezugsobjekt_1, 'Visible', 'off');
    set(handles.rad_bezugsobjekt_1, 'Visible', 'off');
end
if isempty(find(tmp_entities == 2))
    set(handles.txt_bezugsobjekt_2, 'Visible', 'off');
    set(handles.rad_bezugsobjekt_2, 'Visible', 'off');
end
if isempty(find(tmp_entities == 3))
    set(handles.txt_bezugsobjekt_3, 'Visible', 'off');
    set(handles.rad_bezugsobjekt_3, 'Visible', 'off');
end
if isempty(find(tmp_entities == 4))
    set(handles.txt_bezugsobjekt_4, 'Visible', 'off');
    set(handles.rad_bezugsobjekt_4, 'Visible', 'off');
end
if isempty(find(tmp_entities == 5))
    set(handles.txt_bezugsobjekt_5, 'Visible', 'off');
    set(handles.rad_bezugsobjekt_5, 'Visible', 'off');
end
if isempty(find(tmp_entities == 6))
    set(handles.txt_bezugsobjekt_weiss_nicht, 'Visible', 'off');
    set(handles.rad_weiss_nicht, 'Visible', 'off');
end
if isempty(find(tmp_entities == 7))
    set(handles.txt_bezugsobjekt_sonstiges, 'Visible', 'off');
    set(handles.rad_sonstiges, 'Visible', 'off');
    set(handles.ed_sonstiges, 'Visible', 'off');
end

% set position based on selected entities
switch numel(find(tmp_entities <= 5))
    case 1
        offset = [181 -50 0 0];
        tmp = {'txt_bezugsobjekt_1', 'rad_bezugsobjekt_1'};
        for n = 1:numel(tmp)
            set(eval(['handles.' tmp{n}]), 'Position', get(eval(['handles.' tmp{n}]), 'Position')+offset);
        end
    case 2
        offset = [91 -50 0 0];
        tmp = {'txt_bezugsobjekt_1', 'rad_bezugsobjekt_1' 'txt_bezugsobjekt_2', 'rad_bezugsobjekt_2'};
        for n = 1:numel(tmp)
            set(eval(['handles.' tmp{n}]), 'Position', get(eval(['handles.' tmp{n}]), 'Position')+offset);
        end
    case 3
        offset = [0 -50 0 0];
        tmp = {'txt_bezugsobjekt_1', 'rad_bezugsobjekt_1' 'txt_bezugsobjekt_2', 'rad_bezugsobjekt_2' 'txt_bezugsobjekt_3', 'rad_bezugsobjekt_3'};
        for n = 1:numel(tmp)
            set(eval(['handles.' tmp{n}]), 'Position', get(eval(['handles.' tmp{n}]), 'Position')+offset);
        end
    case 4
        offset = [91 0 0 0];
        tmp = {'txt_bezugsobjekt_4', 'rad_bezugsobjekt_4'};
        for n = 1:numel(tmp)
            set(eval(['handles.' tmp{n}]), 'Position', get(eval(['handles.' tmp{n}]), 'Position')+offset);
        end
end
if ~isempty(find(tmp_entities == 6)) && isempty(find(tmp_entities == 7))
    offset = [188 0 0 0];
    tmp = {'txt_bezugsobjekt_weiss_nicht', 'rad_weiss_nicht'};
    for n = 1:numel(tmp)
        set(eval(['handles.' tmp{n}]), 'Position', get(eval(['handles.' tmp{n}]), 'Position')+offset);
    end
end

% --- Outputs from this function are returned to the command line.
function varargout = saqi_vp_7_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_play_a.
function pb_play_a_Callback(hObject, eventdata, handles)
% hObject    handle to pb_play_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
play_a_b('a', 1, handles)

% --- Executes on button press in pb_play_b.
function pb_play_b_Callback(hObject, eventdata, handles)
% hObject    handle to pb_play_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
play_a_b('b', 1, handles)


function play_a_b(type, num, handles)
global PP TSP
% set play flag
eval(['PP.play_' type '(' num2str(num) ') = 1;']);
% decide which stimuli to play based on randomization
if PP.rand_stimuli{PP.current_id}{PP.nScreen}(num,1)
% randomized
    if strcmpi(type, 'a')
        stimID = PP.conditions{PP.current_id}{PP.nScreen}(num);
    else
        stimID = PP.references{PP.current_id}{PP.nScreen}(num);
    end
else
% not randomized
    if strcmpi(type, 'a')
        stimID = PP.references{PP.current_id}{PP.nScreen}(num);
    else
        stimID = PP.conditions{PP.current_id}{PP.nScreen}(num);
    end
end
stimID = TSP.sections{PP.run_section_line,4}{5}(stimID);
% play the stimulus
present_stimulus(stimID);


function ed_sonstiges_Callback(hObject, eventdata, handles)
% hObject    handle to ed_sonstiges (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_sonstiges as text
%        str2double(get(hObject,'String')) returns contents of ed_sonstiges as a double


% --- Executes during object creation, after setting all properties.
function ed_sonstiges_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_sonstiges (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_ok.
function pb_ok_Callback(hObject, eventdata, handles)
% hObject    handle to pb_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% stops the player by pushing the ok_button
global TSP TSD PP player

if ~isempty(player)
    stop(player);
end

% for n = 1:numel(PP.u)
%     fopen(PP.u{n});
%     oscsend(PP.u{n},PP.osc_stop_path,PP.osc_stop_type,PP.osc_stop_data);
%     fclose(PP.u{n});
% end

% if 'sonstiges'/'other' entity was selected, a text has to be provided in
% the edit box
if (...
    get(handles.rad_sonstiges, 'Value') &&...                   % 'other' checkbox is selected
   ~strcmpi(get(handles.ed_sonstiges, 'String'), '...') &&...   % '...' is invalid
   ~strcmpi(get(handles.ed_sonstiges, 'String'), '') &&...      % ''    is invalid
   ~isempty(get(handles.ed_sonstiges, 'String'))...             % []    is invalid
    ) ||...
    ~get(handles.rad_sonstiges, 'Value')                        % 'other' checkbox was not selected
    
    tmp_entities = cell2mat(TSP.sections{PP.run_section_line,4}{1,10});
    % set visibility based on selected entities

    % get & save rating
    if ~isempty(find(tmp_entities == 1))
        PP.subject_data{PP.current_item+1,18} = get(handles.rad_bezugsobjekt_1, 'Value');
    end
    if ~isempty(find(tmp_entities == 2))
        PP.subject_data{PP.current_item+1,20} = get(handles.rad_bezugsobjekt_2, 'Value');
    end
    if ~isempty(find(tmp_entities == 3))
        PP.subject_data{PP.current_item+1,22} = get(handles.rad_bezugsobjekt_3, 'Value');
    end
    if ~isempty(find(tmp_entities == 4))
        PP.subject_data{PP.current_item+1,24} = get(handles.rad_bezugsobjekt_4, 'Value');
    end
    if ~isempty(find(tmp_entities == 5))
        PP.subject_data{PP.current_item+1,26} = get(handles.rad_bezugsobjekt_5, 'Value');
    end
    if ~isempty(find(tmp_entities == 6))
        PP.subject_data{PP.current_item+1,28} = get(handles.rad_weiss_nicht, 'Value');
    end
    if ~isempty(find(tmp_entities == 7))
        PP.subject_data{PP.current_item+1,30} = get(handles.rad_sonstiges, 'Value');
        if get(handles.rad_sonstiges, 'Value')
            PP.subject_data{PP.current_item+1,29} = get(handles.ed_sonstiges, 'String');
        end
    end
    
    TSD{PP.run_number+1,3+PP.run_section_line} = PP.subject_data;
    save ([PP.path filesep 'TSD.mat'],'TSD');
    
    % close current window
    PP.allowed_to_close = 1;
    close
    PP.allowed_to_close = 0;
    
    %check what to do next
    if PP.current_id == numel(TSP.sections{PP.run_section_line,4}{1,4}) % last item
            PP.run_section_line = PP.run_section_line+1;
            vp_main;
    elseif TSP.sections{PP.run_section_line,4}{1,3}{2} % go to next item definition
        saqi_vp_3;
    else  % go to next item rating
        saqi_vp_1;
    end
else
    PP.whisper_message = 'Please give a description in the text-field';
    whisper_message;
end


% --- Executes on button press in pb_stop.
function pb_stop_Callback(hObject, eventdata, handles)
% hObject    handle to pb_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% stops the player 
global player PP TSP

if ~isempty(player)
    stop(player);
end

% for n = 1:numel(PP.u)
%     fopen(PP.u{n});
%     oscsend(PP.u{n},PP.osc_stop_path,PP.osc_stop_type,PP.osc_stop_data);
%     fclose(PP.u{n});
% end


% --- Executes on button press in rad_bezugsobjekt_1.
function rad_bezugsobjekt_1_Callback(hObject, eventdata, handles)
% hObject    handle to rad_bezugsobjekt_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_bezugsobjekt_1

if get(hObject, 'Value') == 1
   set(handles.rad_weiss_nicht, 'Value', 0);
end

% enable/disable save button
if get(handles.rad_bezugsobjekt_1, 'Value') || ...
   get(handles.rad_bezugsobjekt_2, 'Value') || ...
   get(handles.rad_bezugsobjekt_3, 'Value') || ...
   get(handles.rad_bezugsobjekt_4, 'Value') || ...
   get(handles.rad_bezugsobjekt_5, 'Value') || ...
   get(handles.rad_weiss_nicht, 'Value') || ...
   get(handles.rad_sonstiges, 'Value')
    set(handles.pb_ok, 'Enable', 'On');
else
    set(handles.pb_ok, 'Enable', 'off');
end


% --- Executes during object creation, after setting all properties.
function pan_entities_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pan_entities (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in rad_bezugsobjekt_2.
function rad_bezugsobjekt_2_Callback(hObject, eventdata, handles)
% hObject    handle to rad_bezugsobjekt_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_bezugsobjekt_2

if get(hObject, 'Value') == 1
   set(handles.rad_weiss_nicht, 'Value', 0);
end

% enable/disable save button
if get(handles.rad_bezugsobjekt_1, 'Value') || ...
   get(handles.rad_bezugsobjekt_2, 'Value') || ...
   get(handles.rad_bezugsobjekt_3, 'Value') || ...
   get(handles.rad_bezugsobjekt_4, 'Value') || ...
   get(handles.rad_bezugsobjekt_5, 'Value') || ...
   get(handles.rad_weiss_nicht, 'Value') || ...
   get(handles.rad_sonstiges, 'Value')
    set(handles.pb_ok, 'Enable', 'On');
else
    set(handles.pb_ok, 'Enable', 'off');
end


% --- Executes on button press in rad_bezugsobjekt_3.
function rad_bezugsobjekt_3_Callback(hObject, eventdata, handles)
% hObject    handle to rad_bezugsobjekt_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_bezugsobjekt_3
if get(hObject, 'Value') == 1
   set(handles.rad_weiss_nicht, 'Value', 0);
end

% enable/disable save button
if get(handles.rad_bezugsobjekt_1, 'Value') || ...
   get(handles.rad_bezugsobjekt_2, 'Value') || ...
   get(handles.rad_bezugsobjekt_3, 'Value') || ...
   get(handles.rad_bezugsobjekt_4, 'Value') || ...
   get(handles.rad_bezugsobjekt_5, 'Value') || ...
   get(handles.rad_weiss_nicht, 'Value') || ...
   get(handles.rad_sonstiges, 'Value')
    set(handles.pb_ok, 'Enable', 'On');
else
    set(handles.pb_ok, 'Enable', 'off');
end


% --- Executes on button press in rad_bezugsobjekt_4.
function rad_bezugsobjekt_5_Callback(hObject, eventdata, handles)
% hObject    handle to rad_bezugsobjekt_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_bezugsobjekt_4
if get(hObject, 'Value') == 1
   set(handles.rad_weiss_nicht, 'Value', 0);
end

% enable/disable save button
if get(handles.rad_bezugsobjekt_1, 'Value') || ...
   get(handles.rad_bezugsobjekt_2, 'Value') || ...
   get(handles.rad_bezugsobjekt_3, 'Value') || ...
   get(handles.rad_bezugsobjekt_4, 'Value') || ...
   get(handles.rad_bezugsobjekt_5, 'Value') || ...
   get(handles.rad_weiss_nicht, 'Value') || ...
   get(handles.rad_sonstiges, 'Value')
    set(handles.pb_ok, 'Enable', 'On');
else
    set(handles.pb_ok, 'Enable', 'off');
end


% --- Executes on button press in rad_bezugsobjekt_4.
function rad_bezugsobjekt_4_Callback(hObject, eventdata, handles)
% hObject    handle to rad_bezugsobjekt_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_bezugsobjekt_4
if get(hObject, 'Value') == 1
   set(handles.rad_weiss_nicht, 'Value', 0);
end

% enable/disable save button
if get(handles.rad_bezugsobjekt_1, 'Value') || ...
   get(handles.rad_bezugsobjekt_2, 'Value') || ...
   get(handles.rad_bezugsobjekt_3, 'Value') || ...
   get(handles.rad_bezugsobjekt_4, 'Value') || ...
   get(handles.rad_bezugsobjekt_5, 'Value') || ...
   get(handles.rad_weiss_nicht, 'Value') || ...
   get(handles.rad_sonstiges, 'Value')
    set(handles.pb_ok, 'Enable', 'On');
else
    set(handles.pb_ok, 'Enable', 'off');
end


% --- Executes on button press in rad_sonstiges.
function rad_sonstiges_Callback(hObject, eventdata, handles)
% hObject    handle to rad_sonstiges (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_sonstiges
if get(hObject, 'Value') == 1
    set(handles.rad_weiss_nicht, 'Value', 0);
    set(handles.ed_sonstiges, 'Enable', 'on');
else
    set(handles.ed_sonstiges, 'Enable', 'off');
end

% enable/disable save button
if get(handles.rad_bezugsobjekt_1, 'Value') || ...
   get(handles.rad_bezugsobjekt_2, 'Value') || ...
   get(handles.rad_bezugsobjekt_3, 'Value') || ...
   get(handles.rad_bezugsobjekt_4, 'Value') || ...
   get(handles.rad_bezugsobjekt_5, 'Value') || ...
   get(handles.rad_weiss_nicht, 'Value') || ...
   get(handles.rad_sonstiges, 'Value')
    set(handles.pb_ok, 'Enable', 'On');
else
    set(handles.pb_ok, 'Enable', 'off');
end


% --- Executes on button press in rad_weiss_nicht.
function rad_weiss_nicht_Callback(hObject, eventdata, handles)
% hObject    handle to rad_weiss_nicht (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_weiss_nicht
if get(hObject, 'Value') == 1
   set(handles.rad_bezugsobjekt_1, 'Value', 0);
   set(handles.rad_bezugsobjekt_2, 'Value', 0);
   set(handles.rad_bezugsobjekt_3, 'Value', 0);
   set(handles.rad_bezugsobjekt_4, 'Value', 0);
   set(handles.rad_bezugsobjekt_5, 'Value', 0);
   set(handles.rad_sonstiges, 'Value', 0);
end

% enable/disable save button
if get(handles.rad_bezugsobjekt_1, 'Value') || ...
   get(handles.rad_bezugsobjekt_2, 'Value') || ...
   get(handles.rad_bezugsobjekt_3, 'Value') || ...
   get(handles.rad_bezugsobjekt_4, 'Value') || ...
   get(handles.rad_bezugsobjekt_5, 'Value') || ...
   get(handles.rad_weiss_nicht, 'Value') || ...
   get(handles.rad_sonstiges, 'Value')
    set(handles.pb_ok, 'Enable', 'On');
else
    set(handles.pb_ok, 'Enable', 'off');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over ed_sonstiges.
function ed_sonstiges_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to ed_sonstiges (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmpi(get(handles.ed_sonstiges, 'Enable'), 'on');
    set(handles.ed_sonstiges, 'String', '');
end


% --- Executes on key press with focus on ed_sonstiges and none of its controls.
function ed_sonstiges_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_sonstiges (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close saqi_vp_7.
function saqi_vp_7_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to saqi_vp_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
global PP
if PP.allowed_to_close==1
    delete(hObject);
end


% --- Executes on button press in pb_delete.
function pb_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pb_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.fig_saqi_vp_7);
