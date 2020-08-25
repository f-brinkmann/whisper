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

function varargout = saqi_vp_5(varargin)
% FIG_SAQI_VP_5 MATLAB code for fig_saqi_vp_5.fig
%      FIG_SAQI_VP_5, by itself, creates a new FIG_SAQI_VP_5 or raises the existing
%      singleton*.
%
%      H = FIG_SAQI_VP_5 returns the handle to a new FIG_SAQI_VP_5 or the handle to
%      the existing singleton*.
%
%      FIG_SAQI_VP_5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIG_SAQI_VP_5.M with the given input arguments.
%
%      FIG_SAQI_VP_5('Property','Value',...) creates a new FIG_SAQI_VP_5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before saqi_vp_5_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to saqi_vp_5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fig_saqi_vp_5

% Last Modified by GUIDE v2.5 21-Jul-2014 15:37:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @saqi_vp_5_OpeningFcn, ...
                   'gui_OutputFcn',  @saqi_vp_5_OutputFcn, ...
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


% --- Executes just before fig_saqi_vp_5 is made visible.
function saqi_vp_5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fig_saqi_vp_5 (see VARARGIN)

% Choose default command line output for fig_saqi_vp_5
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fig_saqi_vp_5 wait for user response (see UIRESUME)
% uiwait(handles.fig_saqi_vp_5);
movegui(hObject,'center');
global PP TSP

% Figure display name
set(hObject,'Name',['Quality ' num2str(PP.current_id) '/' num2str(PP.number_of_items) ' (' TSP.sections{PP.run_section_line,2} ')']);

% make play_B button invisible if we are comparing against a inner reference
if TSP.sections{PP.run_section_line,4}{1,3}{11}
    set(handles.pb_play_a, 'Visible', 'off');
    set(handles.pb_play_b, 'Position', [300 86 84 24], 'string', 'Play A');
end

% set proper categorization phrase
set(handles.txt_question_constant, 'String', TSP.sections{PP.run_section_line,4}{1,9}{3,2});
set(handles.txt_konstant, 'String', TSP.sections{PP.run_section_line,4}{1,9}{4,2});
set(handles.txt_question_regelhaft, 'String', TSP.sections{PP.run_section_line,4}{1,9}{5,2});
set(handles.txt_question_regellos, 'String', TSP.sections{PP.run_section_line,4}{1,9}{6,2});
set(handles.txt_regelhaft_stetig, 'String', TSP.sections{PP.run_section_line,4}{1,9}{7,2});
set(handles.txt_regelhaft_unstetig, 'String', TSP.sections{PP.run_section_line,4}{1,9}{8,2});
set(handles.txt_regellos_stetig, 'String', TSP.sections{PP.run_section_line,4}{1,9}{7,2});
set(handles.txt_regellos_unstetig, 'String', TSP.sections{PP.run_section_line,4}{1,9}{8,2});

% set visibility of objects depending on user settings
if ~TSP.sections{PP.run_section_line,4}{1,3}{4}
    set(handles.txt_regelhaft_stetig, 'Visible', 'off')
    set(handles.txt_regelhaft_unstetig, 'Visible', 'off')
    set(handles.rad_regelhaft_unstetig, 'Visible', 'off')
    set(handles.rad_regelhaft_stetig, 'Position', [144 44 26 21])
    
    set(handles.txt_regellos_stetig, 'Visible', 'off')
    set(handles.txt_regellos_unstetig, 'Visible', 'off')
    set(handles.rad_regellos_unstetig, 'Visible', 'off')
    set(handles.rad_regellos_stetig, 'Position', [450 44 26 21])
    
    tmp = {'txt_konstant', 'rad_konstant', 'txt_question_regelhaft', 'txt_question_regellos'};
    offset = 35;
    for n = 1:numel(tmp)
        h = eval(['handles.' tmp{n}]);
        set(h, 'position', get(h, 'position')-[0 offset 0 0])
    end
end


% --- Outputs from this function are returned to the command line.
function varargout = saqi_vp_5_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pb_ok.
function pb_ok_Callback(hObject, eventdata, handles)
% hObject    handle to pb_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP TSD TSP player

% stops the player by pushing the ok_button
if ~isempty(player)
    stop(player);
end

% for n = 1:numel(PP.u)
%     fopen(PP.u{n});
%     oscsend(PP.u{n},PP.osc_stop_path,PP.osc_stop_type,PP.osc_stop_data);
%     fclose(PP.u{n});
% end

% get & save rating 
if get(handles.rad_konstant, 'Value')
    PP.subject_data{PP.current_item+1,8} = 1; %constant
elseif get(handles.rad_regelhaft_stetig, 'Value') || get(handles.rad_regelhaft_unstetig, 'Value')
    PP.subject_data{PP.current_item+1,8} = 2; % regelhaft zeitvernderlich
elseif get(handles.rad_regellos_stetig, 'Value') || get(handles.rad_regellos_unstetig, 'Value')
    PP.subject_data{PP.current_item+1,8} = 3; % regellos zeitvernderlich
end

if TSP.sections{PP.run_section_line,4}{1,3}{4}  % second category was used
    if get(handles.rad_regelhaft_stetig, 'Value') || get(handles.rad_regellos_stetig, 'Value') % steady
        PP.subject_data{PP.current_item+1,10} = 1;
    elseif get(handles.rad_regelhaft_unstetig, 'Value') || get(handles.rad_regellos_unstetig, 'Value')
        PP.subject_data{PP.current_item+1,10} = 2;  % not steady
    end
end

% save to TSD
TSD{PP.run_number+1,3+PP.run_section_line} = PP.subject_data;
save ([PP.path filesep 'TSD.mat'],'TSD');

% close current window
PP.allowed_to_close = 1;
close
PP.allowed_to_close = 0;

% check what to do next
if TSP.sections{PP.run_section_line,4}{1,3}{5}
    % go to Categorization -> Interactivity
    saqi_vp_6
elseif TSP.sections{PP.run_section_line,4}{1,3}{6}
    saqi_vp_7
else
    if TSP.sections{PP.run_section_line,4}{1,3}{2} % go to next item definition
        saqi_vp_3;
    else  % go to next item rating
        saqi_vp_1;
    end
end



% --- Executes when selected object is changed in pan_categorization.
function pan_categorization_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in pan_categorization 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
set (handles.pb_ok, 'enable', 'on');


% --- Executes on button press in pb_stop.
function pb_stop_Callback(hObject, eventdata, handles)
% hObject    handle to pb_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% stops the player 
global PP TSP player

if ~isempty(player)
    stop(player);
end

% for n = 1:numel(PP.u)
%     fopen(PP.u{n});
%     oscsend(PP.u{n},PP.osc_stop_path,PP.osc_stop_type,PP.osc_stop_data);
%     fclose(PP.u{n});
% end

% --- Executes when user attempts to close fig_saqi_vp_5.
function fig_saqi_vp_5_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_saqi_vp_5 (see GCBO)
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
delete(handles.fig_saqi_vp_5)
