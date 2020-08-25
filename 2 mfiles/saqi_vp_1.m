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

function varargout = saqi_vp_1(varargin)
% SAQI_VP_2 MATLAB code for saqi_vp_1.fig
%      SAQI_VP_2, by itself, creates a new SAQI_VP_2 or raises the existing
%      singleton*.
%
%      H = SAQI_VP_2 returns the handle to a new SAQI_VP_2 or the handle to
%      the existing singleton*.
%
%      SAQI_VP_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAQI_VP_2.M with the given input arguments.
%
%      SAQI_VP_2('Property','Value',...) creates a new SAQI_VP_2 or raises the
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

% Last Modified by GUIDE v2.5 21-Jul-2014 14:23:57

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

global PP TSP other_quality

% start debugging code
% PP.current_id = 4;
% warning('Delete debugging code above')


% --- increase counter and load parameter ---
if PP.nScreen == 1
% only increase the item count, of all conditions for last items have been
% rated (in case of multiple stimuli SAQI)
    % count of current item
    PP.current_id = PP.current_id+1;
    % id of current item
    PP.current_item = TSP.sections{PP.run_section_line,4}{1,4}{PP.current_id};
    % name of current item
    PP.item = TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,2};
    
    % WARNING: some operations are done using PP.current_id, others use
    % PP.current_item - dont fuck it up!
end

scale_size = TSP.sections{PP.run_section_line,4}{1,3}{9};
% number of condition on current screen
cond_on_screen = numel(PP.conditions{PP.current_id}{PP.nScreen});

% --- Figure display name ---
set(hObject,'Name',['Quality ' num2str(PP.current_id) '/' num2str(PP.number_of_items) ': ' PP.item   ' (' TSP.sections{PP.run_section_line,2} ')']);

% --- to check if stimuli were played back ---
PP.play_a = zeros(cond_on_screen,1);
PP.play_b = PP.play_a;


% --- set different figure layouts for multi and single stimulus saqi ---
% GUI width
try
    tmp_width = PP.GUIwidth;
catch
    tmp_width = max(680, 105*cond_on_screen);
    PP.GUIwidth = tmp_width; 
end
if isempty(PP.GUIwidth)
    tmp_width = max(680, 105*cond_on_screen);
    PP.GUIwidth = tmp_width; 
end

% set position of txt objects
set(handles.fig_saqi_vp_1, 'position', [624 325 tmp_width 480])
tmp = get(handles.txt_scale_label_top, 'position');
set(handles.txt_scale_label_top, 'position', [tmp(1:2) tmp_width tmp(4)]);
tmp = get(handles.txt_scale_label_bottom, 'position');
set(handles.txt_scale_label_bottom, 'position', [tmp(1:2) tmp_width tmp(4)]);
tmp = get(handles.txt_item, 'position');
set(handles.txt_item, 'position', [tmp(1:2) tmp_width tmp(4)]);
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
tmp = get(handles.sli_bi1, 'position');
geo.sli_bi = tmp(3:4);
tmp = get(handles.sli_uni1, 'position');
geo.sli_uni = tmp(3:4);

% slider range and y-offset for label positioning
geo.sli_range_bi  = geo.sli_bi(2) * TSP.sections{PP.run_section_line,4}{1,3}{22}(1); % label range for bipolar slider
geo.sli_range_uni = geo.sli_uni(2)* TSP.sections{PP.run_section_line,4}{1,3}{23}(1);
geo.sli_range_off = [TSP.sections{PP.run_section_line,4}{1,3}{22}(2)...
                     TSP.sections{PP.run_section_line,4}{1,3}{23}(2)];
                 
% x offset from ideal x positions to make slider and label look centered
geo.offset_sli = 10;

% scale annotation width and heigt
tmp = get(handles.txt_scale1_1, 'position');
geo.lab = tmp(3:4);
% y offset for label to be above the scales
geo.offset_lab = 30;

% scale label width and height
tmp = get(handles.txt_scale_label_top, 'position');
geo.sc_lab = tmp(3:4);

% radio button width and heigt
tmp = get(handles.rad_dich_top1, 'position');
geo.rad = tmp(3:4);
% x offset for centering radio buttons
geo.offset_rad = 10;

% play botton y offset (distance to labels)
geo.offset_play = 5;
% play botton width and heigt
tmp = get(handles.pb_play_a1, 'position');
geo.play = tmp(3:4);
tmp = get(handles.pb_stop1, 'position');
geo.stop = tmp(3:4);

% center of GUI, most things will be arranged relatively
tmp = get(handles.fig_saqi_vp_1, 'position');
geo.zero = [ceil(tmp(3)/2) 246];
% pixel offset in x-direction for rating elements (slider, radio bottuns, etc)
geo.dx   = 100;
%vector containing all base x-positions for rating objects
geo.x = (0:cond_on_screen-1)*geo.dx + geo.zero(1) - (cond_on_screen-1)*geo.dx/2;
% y positions of labels
geo.lab_y_bi  = geo.zero(2) + linspace(0, geo.sli_range_bi, scale_size) - geo.sli_range_bi/2 - geo.lab(2)/2;
geo.lab_y_uni = geo.zero(2) + linspace(0, geo.sli_range_uni, ceil((scale_size+1)/2)) - geo.sli_range_uni/2 - geo.lab(2)/2;


% --- set scale annotation and position of sliders, radio bottons and edit fields ---
if TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,3} == 1   % dichotom
    for n = 1:cond_on_screen
        % set position
        set(eval(['handles.rad_dich_top' num2str(n)]), 'visible', 'on',...
            'position', [geo.x(n)-geo.offset_rad geo.zero(2)+geo.sli_uni(2)/3-geo.rad(2)/2 geo.rad])
        set(eval(['handles.rad_dich_bottom' num2str(n)]), 'visible', 'on',...
            'position', [geo.x(n)-geo.offset_rad geo.zero(2)-geo.sli_uni(2)/3-geo.rad(2)/2 geo.rad])
        % set default value
        if PP.rand_scale_label(PP.current_id)
            set(eval(['handles.rad_dich_top' num2str(n)]), 'Value', 1);
        else
            set(eval(['handles.rad_dich_bottom' num2str(n)]), 'Value', 1);
        end
    end
    % set position of quality label
    set(handles.txt_scale_label_top, 'Position' , [0 geo.zero(2)+geo.sli_uni(2)/3+geo.offset_lab-geo.sc_lab(2)/2 geo.sc_lab]);
    set(handles.txt_scale_label_bottom, 'Position', [0 geo.zero(2)-geo.sli_uni(2)/3-geo.offset_lab-geo.sc_lab(2)/2 geo.sc_lab]);
    % offset for play buttons
    geo.offset_play = geo.offset_play + geo.sli_uni(2)/3+geo.offset_lab+geo.sc_lab(2);
elseif TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,6} == 1   % degree scale (elevation, azimuth)
    for n = 1:cond_on_screen
        % set position
        set(eval(['handles.ed_angle' num2str(n)]),'Visible', 'on',...
            'position', [geo.x(n)+geo.rad(1)/2-33-geo.offset_rad geo.zero(2)-18 60 36]);
        set(eval(['handles.rad_dich_top' num2str(n)]), 'visible', 'on',...
            'position', [geo.x(n)-geo.offset_rad geo.zero(2)+geo.sli_uni(2)/3-geo.rad(2)/2 geo.rad])
        set(eval(['handles.rad_dich_bottom' num2str(n)]), 'visible', 'on',...
            'position', [geo.x(n)-geo.offset_rad geo.zero(2)-geo.sli_uni(2)/3-geo.rad(2)/2 geo.rad])
    end
    % set position of quality label
    set(handles.txt_scale_label_top, 'Position' , [0 geo.zero(2)+geo.sli_uni(2)/3+geo.offset_lab-geo.sc_lab(2)/2 geo.sc_lab]);
    set(handles.txt_scale_label_bottom, 'Position', [0 geo.zero(2)-geo.sli_uni(2)/3-geo.offset_lab-geo.sc_lab(2)/2 geo.sc_lab]);
    % offset for play buttons
    geo.offset_play = geo.offset_play + geo.sli_uni(2)/3+geo.offset_lab+geo.sc_lab(2);
elseif TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,4} == 1 % unipolar scale
    for n = 1:cond_on_screen
        % set slider properties
        set(eval(['handles.sli_uni' num2str(n)]), 'visible', 'on', 'position', [geo.x(n)-geo.offset_sli geo.zero(2)-geo.sli_uni(2)/2 geo.sli_uni])
        % set default values
        if PP.rand_scale_label(PP.current_id) == 0 % no randomization scale label
            set(eval(['handles.sli_uni' num2str(n)]), 'value', 0)
        else
            set(eval(['handles.sli_uni' num2str(n)]), 'value', 1)
        end
        % set label position and text
        for m = 1:ceil((scale_size+1)/2)
            set(eval(['handles.txt_scale' num2str(n) '_' num2str(m)]), 'visible', 'on',...
                'position', [geo.x(n)+geo.sli_uni(1)-geo.offset_sli geo.lab_y_uni(m)+geo.sli_range_off(2) geo.lab])
            if PP.rand_scale_label(PP.current_id) == 0 % no randomization scale label
                set(eval(['handles.txt_scale' num2str(n) '_' num2str(m)]), 'string', ['- ' num2str(m-1)])
            else
                set(eval(['handles.txt_scale' num2str(n) '_' num2str(m)]), 'string', ['- ' num2str(ceil((scale_size+1)/2)-m)])
            end
        end
    end  
    % set position of quality label
    set(handles.txt_scale_label_top, 'Position' , [0 geo.zero(2)+geo.sli_uni(2)/2+geo.offset_lab-geo.sc_lab(2)/2 geo.sc_lab]);
    set(handles.txt_scale_label_bottom, 'Position', [0 geo.zero(2)-geo.sli_uni(2)/2-geo.offset_lab-geo.sc_lab(2)/2 geo.sc_lab]);
    % offset for play buttons
    geo.offset_play = geo.offset_play + geo.sli_uni(2)/2+geo.offset_lab+geo.sc_lab(2);
elseif TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,4} == 0 % bipolar
    for n = 1:cond_on_screen
        % set slider properties
        set(eval(['handles.sli_bi' num2str(n)]), 'visible', 'on', 'position', [geo.x(n)-geo.offset_sli geo.zero(2)-geo.sli_bi(2)/2 geo.sli_bi])
        % set label positions and text
        for m = 1:scale_size
            set(eval(['handles.txt_scale' num2str(n) '_' num2str(m)]), 'visible', 'on',...
                'position', [geo.x(n)+geo.sli_bi(1)-geo.offset_sli geo.lab_y_bi(m)+geo.sli_range_off(1) geo.lab],...
                'string', ['- ' num2str(abs(m-ceil(scale_size/2)))])
        end
    end
    % set position of quality label
    set(handles.txt_scale_label_top, 'Position' , [0 geo.zero(2)+geo.sli_bi(2)/2+geo.offset_lab-geo.sc_lab(2)/2 geo.sc_lab]);
    set(handles.txt_scale_label_bottom, 'Position', [0 geo.zero(2)-geo.sli_bi(2)/2-geo.offset_lab-geo.sc_lab(2)/2 geo.sc_lab]);
    % offset for play buttons
    geo.offset_play = geo.offset_play + geo.sli_bi(2)/2+geo.offset_lab+geo.sc_lab(2);
end

% --- set position of play and stop buttons ---
if TSP.sections{PP.run_section_line,4}{1,3}{11}
% compare against implicit/inner reference
    for n = 1:cond_on_screen
        set(eval(['handles.pb_play_b' num2str(n)]), 'Visible', 'on', 'string', 'Play A',...
            'position', [geo.x(n)-geo.stop(1)/2 geo.zero(2)-geo.offset_play-geo.play(2) geo.stop]);
        set(eval(['handles.pb_stop' num2str(n)]), 'Visible', 'on',...
            'position', [geo.x(n)-geo.stop(1)/2 geo.zero(2)-geo.offset_play-geo.play(2)-geo.play(2)*1.005 geo.stop]);
    end
else
% compare against explicit/outer reference
    for n = 1:cond_on_screen
        set(eval(['handles.pb_play_a' num2str(n)]), 'Visible', 'on',...
            'position', [geo.x(n)-geo.stop(1)/2 geo.zero(2)-geo.offset_play-geo.play(2) geo.play]);
        set(eval(['handles.pb_play_b' num2str(n)]), 'Visible', 'on',...
            'position', [geo.x(n) geo.zero(2)-geo.offset_play-geo.play(2) geo.play]);
        set(eval(['handles.pb_stop' num2str(n)]), 'Visible', 'on',...
            'position', [geo.x(n)-geo.stop(1)/2 geo.zero(2)-geo.offset_play-geo.play(2)-geo.play(2)*1.005 geo.stop]);
    end
end


% --- set question text ---
if PP.current_item == 1
% first question
    if TSP.sections{PP.run_section_line,4}{1,3}{1,11}
    % phrase for inner reference (Stimulus A only))
        set(handles.txt_question, 'String', TSP.sections{PP.run_section_line,4}{1,9}{1,2}{2,1});
    else
    % rating with A & B
        set(handles.txt_question, 'String', TSP.sections{PP.run_section_line,4}{1,9}{1,2}{1,1});
    end
    set(handles.txt_item, 'Visible', 'off');
elseif PP.current_id == numel(TSP.sections{PP.run_section_line,4}{1,4})
% last question
    if TSP.sections{PP.run_section_line,4}{1,3}{1,11}
    % phrase for inner reference (Stimulus A only))
        set(handles.txt_question, 'String', TSP.sections{PP.run_section_line,4}{1,9}{14,2}{2,1});
    else
    % rating with A & B
        set(handles.txt_question, 'String', TSP.sections{PP.run_section_line,4}{1,9}{14,2}{1,1});
        set(handles.ed_other, 'Position', [20.2 22.3 69.6 1.8]);
    end
    set(handles.txt_item, 'Visible', 'off');

    set(handles.ed_other, 'visible', 'on', 'position', [geo.zero(1)-130 geo.zero(2)+geo.offset_play 261 27])
    if ~isempty(other_quality)
        set(handles.ed_other, 'string', other_quality, 'enable', 'off')
    end
else
% current item item questions
    set(handles.txt_question, 'String', TSP.sections{PP.run_section_line,4}{1,9}{2,2});
    set(handles.txt_item, 'String', TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,2});
end


% --- set quality label ---
if PP.rand_scale_label(PP.current_id) == 0 % no randomization of scale label
    if ~TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,3} &&...      % not dichotom "B:"
            ~TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,4} &&... % not unipolar
            ~TSP.sections{PP.run_section_line,4}{1,3}{11}                      % no inner reference
        set(handles.txt_scale_label_top, 'String', ['B: ' TSP.sections{PP.run_section_line,4}{1,7}{PP.current_item,3}]);
        set(handles.txt_scale_label_bottom, 'String', ['B: ' TSP.sections{PP.run_section_line,4}{1,7}{PP.current_item,2}]);
    else
        set(handles.txt_scale_label_top, 'String', TSP.sections{PP.run_section_line,4}{1,7}{PP.current_item,3});
        set(handles.txt_scale_label_bottom, 'String', TSP.sections{PP.run_section_line,4}{1,7}{PP.current_item,2});
    end
else % randomization
    if ~TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,3} &&...      % not dichotom "B:"
            ~TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,4} &&... % not unipolar
            ~TSP.sections{PP.run_section_line,4}{1,3}{11}                      % no inner reference
        set(handles.txt_scale_label_top, 'String', ['B: ' TSP.sections{PP.run_section_line,4}{1,7}{PP.current_item,2}]);
        set(handles.txt_scale_label_bottom, 'String', ['B: ' TSP.sections{PP.run_section_line,4}{1,7}{PP.current_item,3}]);
    else
        set(handles.txt_scale_label_top, 'String', TSP.sections{PP.run_section_line,4}{1,7}{PP.current_item,2});
        set(handles.txt_scale_label_bottom, 'String', TSP.sections{PP.run_section_line,4}{1,7}{PP.current_item,3});
    end
end

%  --- initially enable gui elements ---
% if this is not the first quality, and we only have one screen per quality, and
% - stimuli are not randomly assigned to A and B, and conditions & groups are not randomized per quality, or
% - if we are comparing to inner reference, and conditions & groups are not randomized per quality
if PP.current_id>1 && PP.numScreens==1 &&...
        (...
            (TSP.sections{PP.run_section_line,4}{1,3}{12}==0 && TSP.sections{PP.run_section_line,4}{1,3}{17}~=3 && TSP.sections{PP.run_section_line,4}{1,3}{18}~=3) || ...
            (TSP.sections{PP.run_section_line,4}{1,3}{11}==1 && TSP.sections{PP.run_section_line,4}{1,3}{17}~=3 && TSP.sections{PP.run_section_line,4}{1,3}{18}~=3) ...
        )
    for n = 1:cond_on_screen
        set(eval(['handles.sli_bi' num2str(n)]), 'enable', 'on');
        set(eval(['handles.sli_uni' num2str(n)]), 'enable', 'on');
        set(eval(['handles.rad_dich_top' num2str(n)]), 'enable', 'on');
        set(eval(['handles.rad_dich_bottom' num2str(n)]), 'enable', 'on');
        set(eval(['handles.ed_angle' num2str(n)]), 'enable', 'on');
        set(handles.pb_ok, 'enable', 'on');
    end
end

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

% % Send OSC stop message
% for n = 1:numel(PP.u)
%     fopen(PP.u{n});
%     oscsend(PP.u{n},PP.osc_stop_path,PP.osc_stop_type,PP.osc_stop_data);
%     fclose(PP.u{n});
% end

% get rating
tmp_rating = zeros(cond_on_screen, 1);
for n = 1:cond_on_screen
    if TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,3} == 1 % dichotom
        if PP.rand_scale_label(PP.current_id)
            tmp_rating(n) = get(eval(['handles.rad_dich_bottom' num2str(n)]), 'Value');
        else
            tmp_rating(n) = get(eval(['handles.rad_dich_top' num2str(n)]), 'Value');
        end
    elseif TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,4} == 1 % unipolar
        tmp_rating(n) = get(eval(['handles.sli_uni' num2str(n)]), 'Value');
        if PP.rand_scale_label(PP.current_id)
            tmp_rating(n) = 1-tmp_rating(n);
        end
    elseif TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,6} == 1 % degree
        tmp = get(eval(['handles.ed_angle' num2str(n)]), 'String');
        tmp_rating(n) = str2double(tmp)/180; % normalize rating to range -1 ... 1
        
        if get(eval(['handles.rad_dich_bottom' num2str(n)]), 'Value')
            tmp_rating(n) = -tmp_rating(n);
        end
        if PP.rand_scale_label(PP.current_id)
            tmp_rating(n) = -tmp_rating(n);
        end
        if PP.rand_stimuli{PP.current_id}{1}(n,1) % randomized stimuli
            tmp_rating(n) = -tmp_rating(n);
        end
    else
        tmp_rating(n) = get(eval(['handles.sli_bi' num2str(n)]), 'Value'); % bipolar
        if PP.rand_scale_label(PP.current_id)
            tmp_rating(n) = -tmp_rating(n);
        end
        if PP.rand_stimuli{PP.current_id}{1}(n,1) % randomized stimuli
            tmp_rating(n) = -tmp_rating(n);
        end
    end
end

% --- check user input ---
do_continue = 1;

% check input in case of degree item
if TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,6}==1 && any(tmp_rating)
    for n=1:cond_on_screen
        if tmp_rating(n) &&...
           ~get(eval(['handles.rad_dich_top' num2str(n)]), 'value') &&...
           ~get(eval(['handles.rad_dich_bottom' num2str(n)]), 'value')
            do_continue = 0;
            PP.whisper_message = 'Indicate direction of offset by pressing a radio button';
            whisper_message
            break
        end
    end
end

% check input in case of last item
if PP.current_id==PP.number_of_items && any(tmp_rating)
% save user name for 'other' item if it was rated
    if ~isempty(get(handles.ed_other, 'String')) % optional input at last question
        other_quality = get(handles.ed_other, 'String');
        for n = 1:cond_on_screen
            PP.subject_data{PP.current_item+1,2,n} = other_quality;
        end
    else
        PP.whisper_message = 'Please give a description in the text-field';
        whisper_message;
        do_continue = 0;
    end
elseif PP.current_id==PP.number_of_items && ~any(tmp_rating)
% ask for rating if 'other' item was specified by user
    if ~isempty(get(handles.ed_other, 'String')) && strcmpi(get(handles.ed_other, 'enable'), 'on') % optional input at last question
        PP.whisper_message = 'Please rate or delete the text in the description field';
        whisper_message;
        do_continue = 0;
    end
end

% empty GUI width in case we have a second SAQI scheduled after the current
% one
if (PP.current_id==PP.number_of_items && PP.nScreen==PP.numScreens) ||...
   (PP.current_id==1 && ~any(tmp_rating))
    PP.GUIwidth = [];
end

if do_continue
    
    % save ratings for all conditions on screen
    for n = 1:cond_on_screen
        % find rated item in suject data
        % PP.conditions holds the id of the stimulus in the local stimulus pool
        % TSP.sections holds the line of the stimulus in the global stimulus pool
        % TSP.stimuli holds the ID of the stimulus
        stimID = PP.conditions{PP.current_id}{PP.nScreen}(n);
        stimID = TSP.sections{PP.run_section_line,4}{5}(stimID);
        stimID = TSP.stimuli{stimID,1};
        for m = 1:PP.nCond
            tmp = PP.subject_data{PP.current_item+1,31,m};
            tmp = strfind(tmp, ['(S' num2str(stimID)]);
            if tmp
                break
            end
        end
             
        % save flag indicating that a difference was perceived
        if tmp_rating(n)
            PP.subject_data{PP.current_item+1,6,m} = 1;
        else
            PP.subject_data{PP.current_item+1,6,m} = 0;
        end
        
        % save rating
        PP.subject_data{PP.current_item+1,15,m} = tmp_rating(n);
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
        
        % check what to do next if item was rated
        if any(tmp_rating)
            if TSP.sections{PP.run_section_line,4}{1,3}{3} % go to categorization time variance
                saqi_vp_5;
            elseif TSP.sections{PP.run_section_line,4}{1,3}{5} % go to categorization interactivity
                saqi_vp_6;
            elseif TSP.sections{PP.run_section_line,4}{1,3}{6} % go to assessment entities
                saqi_vp_7;
            elseif PP.current_id == numel(TSP.sections{PP.run_section_line,4}{1,4}) % last item
                PP.run_section_line = PP.run_section_line+1;
                vp_main;
            elseif TSP.sections{PP.run_section_line,4}{1,3}{2} % go to next item definition
                saqi_vp_3;
            else  % go to next item rating
                saqi_vp_1;
            end
        % check what to do next if item was not rated    
        else
            if PP.current_id == 1   % first item
                PP.run_section_line = PP.run_section_line+1;
                vp_main;
            elseif PP.current_id == numel(TSP.sections{PP.run_section_line,4}{1,4}) % last item
                PP.run_section_line = PP.run_section_line+1;
                vp_main;
            elseif TSP.sections{PP.run_section_line,4}{1,3}{2} % go to next item definition
                saqi_vp_3;
            else  % go to next item rating
                saqi_vp_1;
            end
        end
    else
        % Screen counter, is needed to check if all rating screens were already displayed
        PP.nScreen = PP.nScreen+1;
        % rate remaining conditions for current item
        saqi_vp_1;
    end
end


% --- Executes on button press in pb_reset.
function pb_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pb_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP TSP
cond_on_screen = numel(PP.conditions{PP.current_id}{PP.nScreen});     % number of condition on current screen

if TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,3} == 1     % dichotom
    for n = 1:cond_on_screen
        if PP.rand_scale_label(PP.current_id)
            set(eval(['handles.rad_dich_top' num2str(n)]), 'Value', 1);
            set(eval(['handles.rad_dich_bottom' num2str(n)]), 'Value', 0);
        else
            set(eval(['handles.rad_dich_bottom' num2str(n)]), 'Value', 1);
            set(eval(['handles.rad_dich_top' num2str(n)]), 'Value', 0);
        end
    end
elseif TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,6} == 1 % degree scale (elevation, azimuth)
    for n = 1:cond_on_screen
        set(eval(['handles.ed_angle' num2str(n)]), 'String', '0');
        set(eval(['handles.rad_dich_top' num2str(n)]), 'Value', 0);
        set(eval(['handles.rad_dich_bottom' num2str(n)]), 'Value', 0);
    end
elseif TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,4} == 1 % unipolar scale
    for n = 1:cond_on_screen
        if PP.rand_scale_label(PP.current_id)
            set(eval(['handles.sli_uni' num2str(n)]), 'value', 1);
        else
            set(eval(['handles.sli_uni' num2str(n)]), 'value', 0);
        end
    end
elseif TSP.sections{PP.run_section_line,4}{1,6}{PP.current_item,4} == 0 % bipolar scale
    for n = 1:cond_on_screen
        set(eval(['handles.sli_bi' num2str(n)]), 'value', 0);
    end
end

if ~isempty(get(handles.ed_other, 'String'))
    set(handles.ed_other, 'String', '');
end


% ----------------------- pb_play_a/bX. callbacks ----------------------- %
function pb_play_a1_Callback(hObject, eventdata, handles)
play_a_b('a', 1, handles)
function pb_play_a2_Callback(hObject, eventdata, handles)
play_a_b('a', 2, handles)
function pb_play_a3_Callback(hObject, eventdata, handles)
play_a_b('a', 3, handles)
function pb_play_a4_Callback(hObject, eventdata, handles)
play_a_b('a', 4, handles)
function pb_play_a5_Callback(hObject, eventdata, handles)
play_a_b('a', 5, handles)
function pb_play_a6_Callback(hObject, eventdata, handles)
play_a_b('a', 6, handles)
function pb_play_a7_Callback(hObject, eventdata, handles)
play_a_b('a', 7, handles)
function pb_play_a8_Callback(hObject, eventdata, handles)
play_a_b('a', 8, handles)
function pb_play_a9_Callback(hObject, eventdata, handles)
play_a_b('a', 9, handles)

function pb_play_b1_Callback(hObject, eventdata, handles)
play_a_b('b', 1, handles)
function pb_play_b2_Callback(hObject, eventdata, handles)
play_a_b('b', 2, handles)
function pb_play_b3_Callback(hObject, eventdata, handles)
play_a_b('b', 3, handles)
function pb_play_b4_Callback(hObject, eventdata, handles)
play_a_b('b', 4, handles)
function pb_play_b5_Callback(hObject, eventdata, handles)
play_a_b('b', 5, handles)
function pb_play_b6_Callback(hObject, eventdata, handles)
play_a_b('b', 6, handles)
function pb_play_b7_Callback(hObject, eventdata, handles)
play_a_b('b', 7, handles)
function pb_play_b8_Callback(hObject, eventdata, handles)
play_a_b('b', 8, handles)
function pb_play_b9_Callback(hObject, eventdata, handles)
play_a_b('b', 9, handles)


function play_a_b(type, num, handles)
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
    if strcmpi(type, 'a')
        stimID = PP.references{PP.current_id}{PP.nScreen}(num);
    else
        stimID = PP.conditions{PP.current_id}{PP.nScreen}(num);
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
% - play a and b buttons were pressed, of
% - play b button was pressed and we are comparing to inner reference
if (PP.play_a(num)==1 && PP.play_b(num)==1) || (PP.play_b(num)==1 && TSP.sections{PP.run_section_line,4}{1,3}{11})
    set(eval(['handles.sli_bi' num2str(num)]), 'enable', 'on');
    set(eval(['handles.sli_uni' num2str(num)]), 'enable', 'on');
    set(eval(['handles.rad_dich_top' num2str(num)]), 'enable', 'on');
    set(eval(['handles.rad_dich_bottom' num2str(num)]), 'enable', 'on');
    set(eval(['handles.ed_angle' num2str(num)]), 'enable', 'on');
end
% enable ok button
if (min(PP.play_a)==1 && min(PP.play_b)==1) || (min(PP.play_b)==1 && TSP.sections{PP.run_section_line,4}{1,3}{11})
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

% % stop osc message
% for n = 1:numel(PP.u)
%     fopen(PP.u{n});
%     oscsend(PP.u{n},PP.osc_stop_path,PP.osc_stop_type,PP.osc_stop_data);
%     fclose(PP.u{n});
% end


% ------------------------ sli_uni/biX. callbacks ----------------------- %
function sli_bi1_Callback(hObject, eventdata, handles)
function sli_bi2_Callback(hObject, eventdata, handles)
function sli_bi3_Callback(hObject, eventdata, handles)
function sli_bi4_Callback(hObject, eventdata, handles)
function sli_bi5_Callback(hObject, eventdata, handles)
function sli_bi6_Callback(hObject, eventdata, handles)
function sli_bi7_Callback(hObject, eventdata, handles)
function sli_bi8_Callback(hObject, eventdata, handles)
function sli_bi9_Callback(hObject, eventdata, handles)

function sli_bi1_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli_bi2_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli_bi3_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli_bi4_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli_bi5_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli_bi6_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli_bi7_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli_bi8_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli_bi9_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)

function sli_uni1_Callback(hObject, eventdata, handles)
function sli_uni2_Callback(hObject, eventdata, handles)
function sli_uni3_Callback(hObject, eventdata, handles)
function sli_uni4_Callback(hObject, eventdata, handles)
function sli_uni5_Callback(hObject, eventdata, handles)
function sli_uni6_Callback(hObject, eventdata, handles)
function sli_uni7_Callback(hObject, eventdata, handles)
function sli_uni8_Callback(hObject, eventdata, handles)
function sli_uni9_Callback(hObject, eventdata, handles)

function sli_uni1_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli_uni2_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli_uni3_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli_uni4_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli_uni5_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli_uni6_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli_uni7_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli_uni8_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)
function sli_uni9_CreateFcn(hObject, eventdata, handles)
create_sli(hObject)

function create_sli(hObject)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% ------------------- rad_dich_top/bottomX. callbacks ------------------- %
function rad_dich_top1_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_bottom1);
function rad_dich_bottom1_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_top1);

function rad_dich_top2_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_bottom2);
function rad_dich_bottom2_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_top2);

function rad_dich_top3_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_bottom3);
function rad_dich_bottom3_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_top3);

function rad_dich_top4_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_bottom4);
function rad_dich_bottom4_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_top4);

function rad_dich_top5_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_bottom5);
function rad_dich_bottom5_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_top5);

function rad_dich_top6_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_bottom6);
function rad_dich_bottom6_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_top6);

function rad_dich_top7_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_bottom7);
function rad_dich_bottom7_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_top7);

function rad_dich_top8_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_bottom8);
function rad_dich_bottom8_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_top8);

function rad_dich_top9_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_bottom9);
function rad_dich_bottom9_Callback(hObject, eventdata, handles)
set_rad_value(get(hObject,'Value'), handles.rad_dich_top9);


function set_rad_value(val, h)
if val
    set(h, 'value', 0)
else
    set(h, 'value', 1)
end

% ------------------------ ed_angleX. callbacks ------------------------- %
function ed_angle1_Callback(hObject, eventdata, handles)
check_ed_angle(hObject, get(hObject, 'string'))
function ed_angle2_Callback(hObject, eventdata, handles)
check_ed_angle(hObject, get(hObject, 'string'))
function ed_angle3_Callback(hObject, eventdata, handles)
check_ed_angle(hObject, get(hObject, 'string'))
function ed_angle4_Callback(hObject, eventdata, handles)
check_ed_angle(hObject, get(hObject, 'string'))
function ed_angle5_Callback(hObject, eventdata, handles)
check_ed_angle(hObject, get(hObject, 'string'))
function ed_angle6_Callback(hObject, eventdata, handles)
check_ed_angle(hObject, get(hObject, 'string'))
function ed_angle7_Callback(hObject, eventdata, handles)
check_ed_angle(hObject, get(hObject, 'string'))
function ed_angle8_Callback(hObject, eventdata, handles)
check_ed_angle(hObject, get(hObject, 'string'))
function ed_angle9_Callback(hObject, eventdata, handles)
check_ed_angle(hObject, get(hObject, 'string'))

function check_ed_angle(h, str)
global PP
if str2double(str) > 180
    set(h, 'string', '180')
    PP.whisper_message = 'Must be between 0 and 180 degrees!';
    whisper_message;
elseif str2double(str) < 0
    set(h, 'string', '0')
    PP.whisper_message = 'Must be between 0 and 180 degrees!';
    whisper_message;
end

function ed_angle1_CreateFcn(hObject, eventdata, handles)
create_ed(hObject)
function ed_angle2_CreateFcn(hObject, eventdata, handles)
create_ed(hObject)
function ed_angle3_CreateFcn(hObject, eventdata, handles)
create_ed(hObject)
function ed_angle4_CreateFcn(hObject, eventdata, handles)
create_ed(hObject)
function ed_angle5_CreateFcn(hObject, eventdata, handles)
create_ed(hObject)
function ed_angle6_CreateFcn(hObject, eventdata, handles)
create_ed(hObject)
function ed_angle7_CreateFcn(hObject, eventdata, handles)
create_ed(hObject)
function ed_angle8_CreateFcn(hObject, eventdata, handles)
create_ed(hObject)
function ed_angle9_CreateFcn(hObject, eventdata, handles)
create_ed(hObject)

function create_ed(hObject)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object deletion, before destroying properties.
function fig_saqi_vp_1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to fig_saqi_vp_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pd_delete.
function pd_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pd_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.fig_saqi_vp_1)


% --- Executes during object deletion, before destroying properties.
function sli_uni1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to sli_uni1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes when user attempts to close fig_saqi_vp_1.
function fig_saqi_vp_1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_saqi_vp_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
global PP
if PP.allowed_to_close==1
    delete(hObject);
end


function ed_other_Callback(hObject, eventdata, handles)
% hObject    handle to ed_other (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_other as text
%        str2double(get(hObject,'String')) returns contents of ed_other as a double


% --- Executes during object creation, after setting all properties.
function ed_other_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_other (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Outputs from this function are returned to the command line.
function varargout = saqi_vp_1_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over txt_item.
function txt_item_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to txt_item (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
saqi_vp_2
