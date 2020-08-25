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

function varargout = abchr_mushra_vp(varargin)
% abchr_mushra_vp MATLAB code for saqi_vp_1.fig
%      abchr_mushra_vp, by itself, creates a new abchr_mushra_vp or raises the existing
%      singleton*.
%
%      H = abchr_mushra_vp returns the handle to a new abchr_mushra_vp or the handle to
%      the existing singleton*.
%
%      abchr_mushra_vp('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in abchr_mushra_vp.M with the given input arguments.
%
%      abchr_mushra_vp('Property','Value',...) creates a new abchr_mushra_vp or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before saqi_vp_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to saqi_vp_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help saqi_vp_1

% Last Modified by GUIDE v2.5 25-Jul-2014 18:00:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @saqi_vp_1_OpeningFcn, ...
    'gui_OutputFcn',  @saqi_vp_1_OutputFcn, ...
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


% --- Executes just before saqi_vp_1 is made visible.
function saqi_vp_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to saqi_vp_1 (see VARARGIN)

% Choose default command line output for saqi_vp_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global PP TSP

% --- load parameter ---
scale_size = TSP.sections{PP.run_section_line,4}{1,3}{9};
% number of condition on current screen
PP.current_id = 1; % arifact from SAQI
cond_on_screen = numel(PP.conditions{PP.current_id}{PP.nScreen});

% start debugging code
%TSP.sections{PP.run_section_line,4}{1,4} = 1;
%PP.GUIwidth = [];
%TSP.sections{PP.run_section_line,4}{1,3}{1,8}{1} = 'identicalicous';
%warning('Delete debugging code above')

% --- Figure display name ---
if TSP.sections{PP.run_section_line,4}{1,4} == 1
    set(hObject,'Name',['ABC/HR Test  -- Panel ' num2str(PP.nScreen) ' of ' num2str(PP.numScreens)]);
else
    set(hObject,'Name',['MUSHRA Test  -- Panel ' num2str(PP.nScreen) ' of ' num2str(PP.numScreens)]);
end

% --- to check if stimuli were played back ---
PP.play_a   = zeros(cond_on_screen,1);
PP.play_b   = PP.play_a;
PP.play_ref = PP.play_a;


% --- set different figure layouts for multi and single stimulus saqi ---
% GUI width
% NOTE: 90 = geo.dx, and 100 = geo.lab(1)
try
    tmp_width = PP.GUIwidth;
catch
    tmp_width = 90*cond_on_screen+2*100;
    PP.GUIwidth = tmp_width; 
end
if isempty(PP.GUIwidth)
    tmp_width = 90*cond_on_screen+2*100;
    PP.GUIwidth = tmp_width; 
end

% set position of rating question
set(handles.fig_abchr_mushra_vp_1, 'position', [624 325 tmp_width 480])
tmp = get(handles.txt_question, 'position');
set(handles.txt_question, 'position', [tmp(1:2) tmp_width tmp(4)]);
% set position of reset and ok buttons
tmp = get(handles.pb_reset, 'position');
set(handles.pb_reset, 'position', [ceil(tmp_width/2)-tmp(3)-5 tmp(2:4)]);
tmp = get(handles.pb_ok, 'position');
set(handles.pb_ok, 'position', [ceil(tmp_width/2)+5 tmp(2:4)]);
% center GUI
movegui(hObject,'center');

% --- reference points and distances for arragement of GUI items ---
% slider width and height
tmp = get(handles.sli1_1, 'position');
geo.sli = tmp(3:4);
% slider range and y-offset for label positioning
% if ispc
%     geo.sli_range  = geo.sli(2)*.745;
%     geo.sli_range_off = 2;
% elseif ismac
%     geo.sli_range  = geo.sli(2)*0.875;
%     geo.sli_range_off = 0;
% else
%     geo.sli_range = geo.sli(2)*0.875;
%     geo.sli_range_off = 0;
% end

% slider range and y-offset for label positioning
geo.sli_range  = geo.sli(2) * TSP.sections{PP.run_section_line,4}{1,3}{22}(1); % label range for bipolar slider
geo.sli_range_off = TSP.sections{PP.run_section_line,4}{1,3}{22}(2);

% scale annotation width and heigt
tmp = get(handles.txt_scale1_1, 'position');
geo.lab = tmp(3:4);
geo.lab_x_offset = 20;

% play botton y offset (distance to labels)
geo.offset_play = 5;
% play botton width and heigt
tmp = get(handles.pb_play_a1, 'position');
geo.play = tmp(3:4);
tmp = get(handles.pb_stop1, 'position');
geo.stop = tmp(3:4);

% x offset from ideal x positions to place to sliders next to each other in
% ABC/HR mode
geo.offset_sli = .3*geo.play(1);

% edit fields width and height
tmp = get(handles.ed1_1, 'position');
geo.ed = tmp(3:4);

% center of GUI, most things will be arranged relatively
tmp = get(handles.fig_abchr_mushra_vp_1, 'position');
geo.zero = [ceil(tmp(3)/2) 266];
% pixel offset in x-direction for rating elements (slider, radio bottuns, etc)
geo.dx   = 90;
%vector containing all base x-positions for rating objects
geo.x = (0:cond_on_screen-1)*geo.dx + geo.zero(1) - (cond_on_screen-1)*geo.dx/2;
% y positions of labels
geo.lab_y  = geo.zero(2) + linspace(geo.sli_range, 0, scale_size) - geo.sli_range/2 - geo.lab(2)/2;


% --- set scale annotation and position of sliders, radio bottons and edit fields ---
if TSP.sections{PP.run_section_line,4}{1,4} == 1 % ABC/HR
    % set slider positions
    for n = 1:cond_on_screen
        set(eval(['handles.sli' num2str(n) '_1']), 'visible', 'on', 'position', [geo.x(n)-geo.offset_sli-geo.sli(1)/2 geo.zero(2)-geo.sli(2)/2 geo.sli])
        set(eval(['handles.sli' num2str(n) '_2']), 'visible', 'on', 'position', [geo.x(n)+geo.offset_sli-geo.sli(1)/2 geo.zero(2)-geo.sli(2)/2 geo.sli])
    end
    % set play buttons
    geo.offset_play = geo.offset_play + geo.sli(2)/2;
    for n = 1:cond_on_screen
        set(eval(['handles.pb_play_a' num2str(n)]), 'Visible', 'on',...
            'position', [geo.x(n)-geo.stop(1)/2 geo.zero(2)-geo.offset_play-geo.play(2) geo.play]);
        set(eval(['handles.pb_play_b' num2str(n)]), 'Visible', 'on',...
            'position', [geo.x(n) geo.zero(2)-geo.offset_play-geo.play(2) geo.play]);
        set(eval(['handles.pb_ref' num2str(n)]), 'Visible', 'on',...
            'position', [geo.x(n)-geo.stop(1)/2 geo.zero(2)-geo.offset_play-geo.play(2)-geo.play(2)*1.005 geo.stop]);
        set(eval(['handles.pb_stop' num2str(n)]), 'Visible', 'on',...
            'position', [geo.x(n)-geo.stop(1)/2 geo.zero(2)-geo.offset_play-geo.play(2)-2*geo.play(2)*1.005 geo.stop]);
    end
    % set edit fields
    for n = 1:cond_on_screen
        set(eval(['handles.ed' num2str(n) '_1']), 'Visible', 'on',...
            'position', [geo.x(n)-geo.ed(1) geo.zero(2)+geo.offset_play geo.ed]);
        set(eval(['handles.ed' num2str(n) '_2']), 'Visible', 'on',...
            'position', [geo.x(n) geo.zero(2)+geo.offset_play geo.ed]);
    end
else % MUSHRA
    % set slider positions
    for n = 1:cond_on_screen
        set(eval(['handles.sli' num2str(n) '_1']), 'visible', 'on', 'position', [geo.x(n)-geo.sli(1)/2 geo.zero(2)-geo.sli(2)/2 geo.sli])
    end
    % set play buttons
    geo.offset_play = geo.offset_play + geo.sli(2)/2;
    for n = 1:cond_on_screen
        set(eval(['handles.pb_play_b' num2str(n)]), 'Visible', 'on',...
            'position', [geo.x(n)-geo.stop(1)/2 geo.zero(2)-geo.offset_play-geo.play(2) geo.stop], 'string', 'A');
        set(eval(['handles.pb_ref' num2str(n)]), 'Visible', 'on',...
            'position', [geo.x(n)-geo.stop(1)/2 geo.zero(2)-geo.offset_play-geo.play(2)-geo.play(2)*1.005 geo.stop]);
        set(eval(['handles.pb_stop' num2str(n)]), 'Visible', 'on',...
            'position', [geo.x(n)-geo.stop(1)/2 geo.zero(2)-geo.offset_play-geo.play(2)-2*geo.play(2)*1.005 geo.stop]);
    end
    % set edit fields
    for n = 1:cond_on_screen
        set(eval(['handles.ed' num2str(n) '_1']), 'Visible', 'on',...
            'position', [geo.x(n)-geo.ed(1)/2 geo.zero(2)+geo.offset_play geo.ed]);
    end
end

% set label positions
for n = 1:scale_size
    if ~isempty(TSP.sections{PP.run_section_line,4}{1,3}{1,8}{n})
        set(eval(['handles.txt_scale1_' num2str(n)]), 'visible', 'on', 'position', [geo.x(1)-geo.offset_sli-geo.sli(1)-geo.lab(1) geo.lab_y(n), geo.lab], 'string', TSP.sections{PP.run_section_line,4}{1,3}{1,8}{n})
        set(eval(['handles.txt_scale2_' num2str(n)]), 'visible', 'on', 'position', [geo.x(end)+geo.offset_sli+geo.sli(1) geo.lab_y(n), geo.lab], 'string', TSP.sections{PP.run_section_line,4}{1,3}{1,8}{n})
        
        % check if the text fits one column
        extend = get(eval(['handles.txt_scale1_' num2str(n)]), 'extent');
        lines = ceil(extend(3)/geo.lab(1));
        if lines > 1
            set(eval(['handles.txt_scale1_' num2str(n)]), 'position', [geo.x(1)-geo.offset_sli-geo.sli(1)-geo.lab(1) geo.lab_y(n)-lines*geo.lab(2)/2, geo.lab(1) lines*geo.lab(2)])
            set(eval(['handles.txt_scale2_' num2str(n)]), 'position', [geo.x(end)+geo.offset_sli+geo.sli(1) geo.lab_y(n)-lines*geo.lab(2)/2, geo.lab(1) lines*geo.lab(2)])
        end
    end
    set(eval(['handles.txt_scale3_' num2str(n)]), 'visible', 'on', 'position', [geo.x(1)-geo.offset_sli-geo.sli(1) geo.lab_y(n), geo.x(end)-geo.x(1)+2*geo.offset_sli+2*geo.sli(1) geo.lab(2)],...
        'string', ['------------------------------------------------------------------------------------------------------------------------' ...
        '-----------------------------------------------------------------------------------------------------------------------------------------------------------------']);
end

% % --- set question text ---
set(handles.txt_question, 'string', TSP.sections{PP.run_section_line,4}{1,1})


% --- Executes on button press in pb_ok.
function pb_ok_Callback(hObject, eventdata, handles)
% hObject    handle to pb_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP TSD TSP player other_quality
cond_on_screen = numel(PP.conditions{PP.current_id}{PP.nScreen});     % number of condition on current screen

% Stop the player
if ~isempty(player)
    stop(player);
end
% Stop osc messages
for n = 1:numel(PP.u)
    fopen(PP.u{n});
    oscsend(PP.u{n},PP.osc_stop_path,PP.osc_stop_type,PP.osc_stop_data);
    fclose(PP.u{n});
end

% get rating
tmp_rating = zeros(cond_on_screen, 1);
if TSP.sections{PP.run_section_line,4}{1,4} == 1 % ABC/HR
    for n = 1:cond_on_screen
        % get non-zero rating
        tmp_rating(n) = 1-get(eval(['handles.sli' num2str(n) '_1']), 'value');
        rating_src = 'a';
        if ~tmp_rating(n)
            tmp_rating(n) = 1-get(eval(['handles.sli' num2str(n) '_2']), 'value');
            rating_src = 'b';
        end
        
        % change sign if the correct slider was used (in this case the
        % comparative stimulus was set to be worse than the reference)
        if (PP.rand_stimuli{PP.current_id}{PP.nScreen}(n,1)==0 && strcmpi(rating_src, 'b')) ||...
                (PP.rand_stimuli{PP.current_id}{PP.nScreen}(n,1)==1 && strcmpi(rating_src, 'a'))
            tmp_rating(n) = -tmp_rating(n);
        end
    end
else  % MUSHRA
    for n = 1:cond_on_screen
        % get rating
        tmp_rating(n) = get(eval(['handles.sli' num2str(n) '_1']), 'value')-1;
    end
end


% empty GUI width in case we have a second ABC/HR or MUSHRA scheduled after
% the current one
if PP.nScreen==PP.numScreens
    PP.GUIwidth = [];
end


    
% save ratings for all conditions on screen
for n = 1:cond_on_screen
    % find rated item in suject data:
    % PP.conditions holds the id of the stimulus in the local stimulus pool
    % TSP.sections holds the line of the stimulus in the global stimulus pool
    % TSP.stimuli holds the ID of the stimulus
    stimID = PP.conditions{PP.current_id}{PP.nScreen}(n);
    stimID = TSP.sections{PP.run_section_line,4}{5}(stimID);
    stimID = TSP.stimuli{stimID,1};
    for m = 1:PP.nCond
        tmp = PP.subject_data{1,m};
        tmp = strfind(tmp, ['(S' num2str(stimID)]);
        if tmp
            break
        end
    end
    
    % save rating
    PP.subject_data{2,m} = tmp_rating(n);
end

% save to TSD
TSD{PP.run_number+1,3+PP.run_section_line} = PP.subject_data;
save ([PP.path filesep 'TSD.mat'],'TSD');

% close current window
PP.allowed_to_close = 1;
close
PP.allowed_to_close = 0;

% check what to do next if all conditions of current item have been
% rated
if PP.nScreen == PP.numScreens
    
    % reset screen count and global varibles
    PP.nScreen = 1;
    other_quality = [];
    % increase section count and go to vp_main
    PP.run_section_line = PP.run_section_line+1;
    vp_main;

else
    % Screen counter, is needed to check if all rating screens were already displayed
    PP.nScreen = PP.nScreen+1;
    % rate remaining conditions for current item
    abchr_mushra_vp;
end



% --- Executes on button press in pb_reset.
function pb_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pb_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP TSP
cond_on_screen = numel(PP.conditions{PP.current_id}{PP.nScreen});     % number of condition on current screen


for n = 1:cond_on_screen
    set(eval(['handles.sli' num2str(n) '_1']), 'value', 1);
    set(eval(['handles.sli' num2str(n) '_2']), 'value', 1);
    set(eval(['handles.ed' num2str(n) '_1']), 'string', '0');
    set(eval(['handles.ed' num2str(n) '_2']), 'string', '0');
end


% ----------------------- pb_play_a/bX. callbacks ----------------------- %
function pb_play_a1_Callback(hObject, eventdata, handles)
play_a_b_ref('a', 1, handles)
function pb_play_a2_Callback(hObject, eventdata, handles)
play_a_b_ref('a', 2, handles)
function pb_play_a3_Callback(hObject, eventdata, handles)
play_a_b_ref('a', 3, handles)
function pb_play_a4_Callback(hObject, eventdata, handles)
play_a_b_ref('a', 4, handles)
function pb_play_a5_Callback(hObject, eventdata, handles)
play_a_b_ref('a', 5, handles)
function pb_play_a6_Callback(hObject, eventdata, handles)
play_a_b_ref('a', 6, handles)
function pb_play_a7_Callback(hObject, eventdata, handles)
play_a_b_ref('a', 7, handles)
function pb_play_a8_Callback(hObject, eventdata, handles)
play_a_b_ref('a', 8, handles)
function pb_play_a9_Callback(hObject, eventdata, handles)
play_a_b_ref('a', 9, handles)

function pb_play_b1_Callback(hObject, eventdata, handles)
play_a_b_ref('b', 1, handles)
function pb_play_b2_Callback(hObject, eventdata, handles)
play_a_b_ref('b', 2, handles)
function pb_play_b3_Callback(hObject, eventdata, handles)
play_a_b_ref('b', 3, handles)
function pb_play_b4_Callback(hObject, eventdata, handles)
play_a_b_ref('b', 4, handles)
function pb_play_b5_Callback(hObject, eventdata, handles)
play_a_b_ref('b', 5, handles)
function pb_play_b6_Callback(hObject, eventdata, handles)
play_a_b_ref('b', 6, handles)
function pb_play_b7_Callback(hObject, eventdata, handles)
play_a_b_ref('b', 7, handles)
function pb_play_b8_Callback(hObject, eventdata, handles)
play_a_b_ref('b', 8, handles)
function pb_play_b9_Callback(hObject, eventdata, handles)
play_a_b_ref('b', 9, handles)


% --------------------------- pb_ref callbacks -------------------------- %
function pb_ref1_Callback(hObject, eventdata, handles)
play_a_b_ref('ref', 1, handles)
function pb_ref2_Callback(hObject, eventdata, handles)
play_a_b_ref('ref', 2, handles)
function pb_ref3_Callback(hObject, eventdata, handles)
play_a_b_ref('ref', 3, handles)
function pb_ref4_Callback(hObject, eventdata, handles)
play_a_b_ref('ref', 4, handles)
function pb_ref5_Callback(hObject, eventdata, handles)
play_a_b_ref('ref', 5, handles)
function pb_ref6_Callback(hObject, eventdata, handles)
play_a_b_ref('ref', 6, handles)
function pb_ref7_Callback(hObject, eventdata, handles)
play_a_b_ref('ref', 7, handles)
function pb_ref8_Callback(hObject, eventdata, handles)
play_a_b_ref('ref', 8, handles)
function pb_ref9_Callback(hObject, eventdata, handles)
play_a_b_ref('ref', 9, handles)


function play_a_b_ref(type, num, handles)
global TSP PP
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
    if strcmpi(type, 'b')
        stimID = PP.conditions{PP.current_id}{PP.nScreen}(num);
    else
        stimID = PP.references{PP.current_id}{PP.nScreen}(num);        
    end
end
% PP.conditions holds the id of the stimulus in the local stimulus pool
% TSP.sections holds the line of the stimulus in the global stimulus pool
% TSP.stimuli holds the ID of the stimulus
stimID = TSP.sections{PP.run_section_line,4}{5}(stimID);
stimID = TSP.stimuli{stimID,1};
% play the stimulus
present_stimulus(stimID);
% enable rating objects if
% - play a, b and ref buttons were pressed (ABC/HR)
% - play b and ref buttons were pressed (MUSHRA)
if (TSP.sections{PP.run_section_line,4}{1,4}==1 && PP.play_a(num)==1 && PP.play_b(num)==1 && PP.play_ref(num)==1) ||...
        (TSP.sections{PP.run_section_line,4}{1,4}==2 && PP.play_b(num)==1 && PP.play_ref(num)==1)
    set(eval(['handles.sli' num2str(num) '_1']), 'enable', 'on');
    set(eval(['handles.sli' num2str(num) '_2']), 'enable', 'on');
    set(eval(['handles.ed' num2str(num) '_1']), 'enable', 'on');
    set(eval(['handles.ed' num2str(num) '_2']), 'enable', 'on');
end
% enable ok button
if (TSP.sections{PP.run_section_line,4}{1,4}==1 && min(PP.play_a)==1 && min(PP.play_b)==1 && min(PP.play_ref)==1) ||...
        (TSP.sections{PP.run_section_line,4}{1,4}==2 && min(PP.play_b)==1 && min(PP.play_ref)==1)
    set(handles.pb_ok, 'enable', 'on');
end


% --------------------------- pb_stop callbacks ------------------------- %
function pb_stop1_Callback(hObject, eventdata, handles)
stop_all
function pb_stop2_Callback(hObject, eventdata, handles)
stop_all
function pb_stop3_Callback(hObject, eventdata, handles)
stop_all
function pb_stop4_Callback(hObject, eventdata, handles)
stop_all
function pb_stop5_Callback(hObject, eventdata, handles)
stop_all
function pb_stop6_Callback(hObject, eventdata, handles)
stop_all
function pb_stop7_Callback(hObject, eventdata, handles)
stop_all
function pb_stop8_Callback(hObject, eventdata, handles)
stop_all
function pb_stop9_Callback(hObject, eventdata, handles)
stop_all

function stop_all
global PP player
% Stop the player
if ~isempty(player)
    stop(player);
end
% stop osc message
for n = 1:numel(PP.u)
    fopen(PP.u{n});
    oscsend(PP.u{n},PP.osc_stop_path,PP.osc_stop_type,PP.osc_stop_data);
    fclose(PP.u{n});
end


% ----------------------------- sli callbacks --------------------------- %
function sli1_1_Callback(hObject, eventdata, handles)
slider_action(1, 1, handles)
function sli2_1_Callback(hObject, eventdata, handles)
slider_action(2, 1, handles)
function sli3_1_Callback(hObject, eventdata, handles)
slider_action(3, 1, handles)
function sli4_1_Callback(hObject, eventdata, handles)
slider_action(4, 1, handles)
function sli5_1_Callback(hObject, eventdata, handles)
slider_action(5, 1, handles)
function sli6_1_Callback(hObject, eventdata, handles)
slider_action(6, 1, handles)
function sli7_1_Callback(hObject, eventdata, handles)
slider_action(7, 1, handles)
function sli8_1_Callback(hObject, eventdata, handles)
slider_action(8, 1, handles)
function sli9_1_Callback(hObject, eventdata, handles)
slider_action(9, 1, handles)
function sli1_2_Callback(hObject, eventdata, handles)
slider_action(1, 2, handles)
function sli2_2_Callback(hObject, eventdata, handles)
slider_action(2, 2, handles)
function sli3_2_Callback(hObject, eventdata, handles)
slider_action(3, 2, handles)
function sli4_2_Callback(hObject, eventdata, handles)
slider_action(4, 2, handles)
function sli5_2_Callback(hObject, eventdata, handles)
slider_action(5, 2, handles)
function sli6_2_Callback(hObject, eventdata, handles)
slider_action(6, 2, handles)
function sli7_2_Callback(hObject, eventdata, handles)
slider_action(7, 2, handles)
function sli8_2_Callback(hObject, eventdata, handles)
slider_action(8, 2, handles)
function sli9_2_Callback(hObject, eventdata, handles)
slider_action(9, 2, handles)

function sli1_1_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli2_1_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli3_1_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli4_1_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli5_1_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli6_1_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli7_1_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli8_1_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli9_1_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli1_2_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli2_2_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli3_2_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli4_2_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli5_2_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli6_2_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli7_2_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli8_2_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli9_2_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)

function slider_action(sli_grp, sli_num, handles)
global TSP PP

% set edit field
sli_val = get(eval(['handles.sli' num2str(sli_grp) '_' num2str(sli_num)]), 'value');
sli_val = round(sli_val*100)/100;
sli_val = (1-sli_val) * (TSP.sections{PP.run_section_line,4}{1,3}{9}-1);
set(eval(['handles.ed' num2str(sli_grp) '_' num2str(sli_num)]), 'string', num2str(sli_val))

% reset other slider and edit field in case of abc/hr
if TSP.sections{PP.run_section_line,4}{1,4}==1
    set(eval(['handles.ed' num2str(sli_grp) '_' num2str(mod(sli_num,2)+1)]), 'string', num2str(0))
    set(eval(['handles.sli' num2str(sli_grp) '_' num2str(mod(sli_num,2)+1)]), 'value', 1)
end

function create_sli(hObject)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% ----------------------------- ed callbacks ---------------------------- %
function ed1_1_Callback(hObject, eventdata, handles)
ed_action(1, 1, handles)
function ed1_2_Callback(hObject, eventdata, handles)
ed_action(1, 2, handles)
function ed2_1_Callback(hObject, eventdata, handles)
ed_action(2, 1, handles)
function ed2_2_Callback(hObject, eventdata, handles)
ed_action(2, 2, handles)
function ed3_1_Callback(hObject, eventdata, handles)
ed_action(3, 1, handles)
function ed3_2_Callback(hObject, eventdata, handles)
ed_action(3, 2, handles)
function ed4_1_Callback(hObject, eventdata, handles)
ed_action(4, 1, handles)
function ed4_2_Callback(hObject, eventdata, handles)
ed_action(4, 2, handles)
function ed5_1_Callback(hObject, eventdata, handles)
ed_action(5, 1, handles)
function ed5_2_Callback(hObject, eventdata, handles)
ed_action(5, 2, handles)
function ed6_1_Callback(hObject, eventdata, handles)
ed_action(6, 1, handles)
function ed6_2_Callback(hObject, eventdata, handles)
ed_action(6, 2, handles)
function ed7_1_Callback(hObject, eventdata, handles)
ed_action(7, 1, handles)
function ed7_2_Callback(hObject, eventdata, handles)
ed_action(7, 2, handles)
function ed8_1_Callback(hObject, eventdata, handles)
ed_action(8, 1, handles)
function ed8_2_Callback(hObject, eventdata, handles)
ed_action(8, 2, handles)
function ed9_1_Callback(hObject, eventdata, handles)
ed_action(9, 1, handles)
function ed9_2_Callback(hObject, eventdata, handles)
ed_action(9, 2, handles)

function ed1_1_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)
function ed1_2_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)
function ed2_1_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)
function ed2_2_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)
function ed3_1_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)
function ed3_2_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)
function ed4_1_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)
function ed4_2_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)
function ed5_1_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)
function ed5_2_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)
function ed6_1_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)
function ed6_2_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)
function ed7_1_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)
function ed7_2_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)
function ed8_1_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)
function ed8_2_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)
function ed9_1_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)
function ed9_2_CreateFcn(hObject, eventdata, handles)
create_edit(hObject)

function ed_action(sli_grp, sli_num, handles)
global TSP PP

% get value from edit field
ed_val = str2double(get(eval(['handles.ed' num2str(sli_grp) '_' num2str(sli_num)]), 'string'));

set_other_elements = 1;
% parse user input
if ed_val < 0
    PP.whisper_message = 'value must be at least 0';
    whisper_message
    ed_val = 0;
    set(eval(['handles.ed' num2str(sli_grp) '_' num2str(sli_num)]), 'string', num2str(ed_val))
    set_other_elements = 0;
elseif ed_val > TSP.sections{PP.run_section_line,4}{1,3}{9}-1
    PP.whisper_message = ['value must be not be larger than least ' num2str(TSP.sections{PP.run_section_line,4}{1,3}{9}-1)];
    whisper_message
    ed_val = TSP.sections{PP.run_section_line,4}{1,3}{9}-1;
    set(eval(['handles.ed' num2str(sli_grp) '_' num2str(sli_num)]), 'string', num2str(ed_val))
end

% set edit fields and slider
ed_val = 1-ed_val/(TSP.sections{PP.run_section_line,4}{1,3}{9}-1);
set(eval(['handles.sli' num2str(sli_grp) '_' num2str(sli_num)]), 'value', ed_val)

% reset other slider and edit field in case of abc/hr
if TSP.sections{PP.run_section_line,4}{1,4}==1 && set_other_elements
    set(eval(['handles.ed' num2str(sli_grp) '_' num2str(mod(sli_num,2)+1)]), 'string', num2str(0))
    set(eval(['handles.sli' num2str(sli_grp) '_' num2str(mod(sli_num,2)+1)]), 'value', 1)
end

function create_edit(hObject)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object deletion, before destroying properties.
function fig_abchr_mushra_vp_1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to fig_abchr_mushra_vp_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pd_delete.
function pd_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pd_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.fig_abchr_mushra_vp_1)


% --- Executes when user attempts to close fig_abchr_mushra_vp_1.
function fig_abchr_mushra_vp_1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_abchr_mushra_vp_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
global PP
if PP.allowed_to_close==1
    delete(hObject);
end


% --- Outputs from this function are returned to the command line.
function varargout = saqi_vp_1_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
