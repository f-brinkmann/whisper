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
% Author :   Andr Wlodarski, student at FG Audiokommunikation, TU Berlin
% Email  :   awlodarski AT gmx DOT de
% Date   :   16-Nov-2008
% Updated:   11-Sep-2009 16:29 Rotter, adding ABX-Trial Parameter
%
% =========================================================================


function varargout = vp_main(varargin)
% VP_MAIN M-file for vp_main.fig
%      VP_MAIN, by itself, creates a new VP_MAIN or raises the existing
%      singleton*.
%
%      H = VP_MAIN returns the handle to a new VP_MAIN or the handle to
%      the existing singleton*.
%
%      VP_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VP_MAIN.M with the given input arguments.
%
%      VP_MAIN('Property','Value',...) creates a new VP_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vp_main_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vp_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vp_main

% Last Modified by GUIDE v2.5 24-Jul-2014 17:57:05

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vp_main_OpeningFcn, ...
                   'gui_OutputFcn',  @vp_main_OutputFcn, ...
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


% --- Executes just before vp_main is made visible.
function vp_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vp_main (see VARARGIN)

% Choose default command line output for vp_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vp_main wait for user response (see UIRESUME)
% uiwait(handles.vp_main);

warning('off', 'MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
setfigdocked('GroupName','Versuchsdurchfuehrung','Figure',hObject,'Maximize',1,'GroupDocked',0);
warning('on', 'MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');

global TSP PP TSD
PP.allowed_to_close=0;

subject_id=TSD{PP.run_number+1,2};
session=TSD{PP.run_number+1,3};
set(hObject,'Name',['(run: ' num2str(PP.run_number) ',  subject: ' subject_id ',  session: ' session ')'])
set(handles.ed_instruction,'Visible','Off');
set(handles.pb_ok,'Visible','Off');
set(handles.pb_close,'Visible','Off');
set(handles.pan_status,'Visible','On');
set(handles.txt_versuchsstatus,'Visible','On');
if PP.run_section_line<=length(TSP.sections(:,1))
    set(handles.pb_weiter,'Visible','On');
else
    set(handles.pb_close,'Visible','On');
end

%Statusanzeige generieren
%notwendige Farben
green = [0 1 0.251];
grey   = [0.7 0.7 0.7];
black = [0 0 0];

for i=1:length(TSP.sections(:,1))
    %Farbe und Inhalt des Eintrags i festlegen
    PP.run_section_line
    if PP.run_section_line==i
        color=green;
        statustext='folgt jetzt';
    end
    if PP.run_section_line>i
        color=grey;
        statustext='erledigt';
    end
    if PP.run_section_line<i
        color=black;
        statustext='noch anstehend';
    end
    set(eval( ['handles.txt_status_' num2str(i)] ), 'String', statustext, 'ForegroundColor', color);
    set(eval( ['handles.txt_teil_' num2str(i)] ), 'String', TSP.sections{i,3});
end


% --- Outputs from this function are returned to the command line.
function varargout = vp_main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_weiter.
function pb_weiter_Callback(hObject, eventdata, handles)
% hObject    handle to pb_weiter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP
set(handles.pan_status,'Visible','Off');
set(handles.txt_versuchsstatus,'Visible','Off');
set(handles.pb_weiter,'Visible','Off');
switch TSP.sections{PP.run_section_line,1}
    case 'tid1' %AP
        set(handles.ed_instruction,'String',TSP.sections{PP.run_section_line,4}{1,2},'Visible','On');
    case 'tid2' %RGT
        set(handles.ed_instruction,'String',TSP.sections{PP.run_section_line,5}{1,4},'Visible','On');
    case 'tid3' %SD
        set(handles.ed_instruction,'String',TSP.sections{PP.run_section_line,4}{1,8},'Visible','On');
    case 'tid4' %ABX
        set(handles.ed_instruction,'String',TSP.sections{PP.run_section_line,4}{1,2},'Visible','On');
    case 'tid5' %SAQI
        set(handles.ed_instruction,'String',TSP.sections{PP.run_section_line,4}{1,2},'Visible','On');
    case 'tid6' %ABCHR & MUSHRA
        set(handles.ed_instruction,'String',TSP.sections{PP.run_section_line,4}{1,2},'Visible','On');
end
set(handles.pb_ok,'Visible','On');


% --- Executes on button press in pb_ok.
function pb_ok_Callback(hObject, eventdata, handles)
% hObject    handle to pb_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP TSD PS

% Initialize OSC-messages for stopping stimulus playback.
% By default this is done by sending '/stop 1' to all IPs in the network settings.

% Create UDP/OSC-servers
PP.u={};
cur_count = 1;
for IPs = 1:size(PS.network{1,1},1)
    if  ~isempty(PS.network{1,1}{IPs,1})
        host = PS.network{1,1}{IPs,1};
        port = str2num(PS.network{1,1}{IPs,2});
        PP.u{cur_count} = udp(host, port);
        cur_count = cur_count + 1;
    end
end

%Create OSC-stop-message
PP.osc_stop_path = '/stop';
PP.osc_stop_type = 'i';
PP.osc_stop_data = 1;

% % How to send OSC-stop-messages:
% % insert this bllock at the desired position into the code of your listening test module
% for n = 1:numel(PP.u)
%     fopen(PP.u{n});
%     oscsend(PP.u{n},PP.osc_stop_path,PP.osc_stop_type,PP.osc_stop_data);
%     fclose(PP.u{n});
% end



switch TSP.sections{PP.run_section_line,1}
    case 'tid1' %AP
        % Debug Alex: sonst fehlerhaftes Mehrfachauslsen des ok-Buttons mglich
        set(handles.pb_ok,'Visible','Off');
        % Debug Alex: sonst stndig im Hintergrund sichtbar, hsslich
        set(handles.ed_instruction,'String',TSP.sections{PP.run_section_line,4}{1,2},'Visible','Off');
        
        PP.playlist=[];
        write_to_log('');
        write_to_log(['section ', num2str(PP.run_section_line), ' - ', TSP.sections{PP.run_section_line,2}]);
        write_to_log('--------------------------------------------------------------');
        write_to_log(datestr(clock, 'local'));
        trackanzahl=length(TSP.sections{PP.run_section_line,4}(:,7));
        if TSP.sections{PP.run_section_line,4}{1,4}{1,1}==1 %bei interleaving aller tracks
            PP.playlist=randperm(trackanzahl); %liefert zufllige Abfolge aller vorhandenen Tracks (wobei zufall hier nicht ntig wre)
        else %bei Nutzung der Session/sequence-Funktion
            sessionnr=str2num(TSD{PP.run_number+1,3});
            PP.playlist=TSP.sections{PP.run_section_line,4}{1,4}{sessionnr,2};
        end
        %PP.counter=1; UNNTIG fr AP
        PP.ap_trackdata={}; %alle daten vorhergegangener Tracks lschen
        for i=1:trackanzahl %init
            PP.ap_trackdata{i,1}={};
        end
        %log tracklist
        write_to_log('track playlist:');
        write_to_log(num2str(PP.playlist));
        ap_vp_nafc
    case 'tid2' %RGT
        % Debug Alex: sonst fehlerhaftes Mehrfachauslsen des ok-Buttons mglich
        set(handles.pb_ok,'Visible','Off');
        % Debug Alex: sonst stndig im Hintergrund sichtbar, hsslich
        set(handles.ed_instruction,'String',TSP.sections{PP.run_section_line,5}{1,4},'Visible','Off');
        
        PP.playlist=[];
        write_to_log('');
        write_to_log(['section ', num2str(PP.run_section_line), ' - ', TSP.sections{PP.run_section_line,2}]);
        write_to_log('--------------------------------------------------------------');
        write_to_log(datestr(clock, 'local'));
        if TSP.sections{PP.run_section_line,5}{1,2}{1,1}==1 %bei zuflliger auswahl aus allen triaden
            triadenanzahl=length(TSP.sections{PP.run_section_line,5}{1,1}(:,1));
            PP.playlist=randperm(triadenanzahl); %liefert zufllige Abfolge aller vorhandenen Objekte
        else %bei Nutzung der Session/sequence-Funktion
            sessionnr=str2num(TSD{PP.run_number+1,3});
            templist=TSP.sections{PP.run_section_line,5}{1,2}{sessionnr,2};
            if TSP.sections{PP.run_section_line,5}{1,2}{1,3}==1, PP.playlist=templist; end %as defined
            if TSP.sections{PP.run_section_line,5}{1,2}{1,3}==2, PP.playlist=templist(randperm(length(templist))); end %play defined list random
        end
        TSP.sections{PP.run_section_line,4}{1,5}=[];
        %log playlist
        write_to_log('triad playlist:');
        write_to_log(num2str(PP.playlist));
        PP.counter=1;
        PP.step=1;
        rgt_vp_triad
    case 'tid3' %SD
        % Debug Alex: sonst fehlerhaftes Mehrfachauslsen des ok-Buttons mglich
        set(handles.pb_ok,'Visible','Off');
        % Debug Alex: sonst stndig im Hintergrund sichtbar, hsslich
        set(handles.ed_instruction,'String',TSP.sections{PP.run_section_line,4}{1,8},'Visible','Off');
        
        PP.playlist=[];
        write_to_log('');
        write_to_log(['section ', num2str(PP.run_section_line), ' - ', TSP.sections{PP.run_section_line,2}]);
        write_to_log('--------------------------------------------------------------');
        write_to_log(datestr(clock, 'local'));
        %Objekt-Playlist fr den aktuellen run generieren
        if TSP.sections{PP.run_section_line,4}{1,6}{1,1}==1 %bei zuflliger auswahl aus allen objekten
            objektanzahl=length(TSP.sections{PP.run_section_line,4}{1,1}(:,1));
            PP.playlist=randperm(objektanzahl); %liefert zufllige Abfolge aller vorhandenen Objekte
        else %bei Nutzung der Session/sequence-Funktion
            sessionnr=str2num(TSD{PP.run_number+1,3});
            templist=TSP.sections{PP.run_section_line,4}{1,6}{sessionnr,2};
            if TSP.sections{PP.run_section_line,4}{1,6}{1,3}==1, PP.playlist=templist; end %as defined
            if TSP.sections{PP.run_section_line,4}{1,6}{1,3}==2, PP.playlist=templist(randperm(length(templist))); end %play defined list random
        end
        %log playlist
        write_to_log('object playlist:');
        write_to_log(num2str(PP.playlist));
        PP.counter=1;
        sd_vp
    case 'tid4' % ABX Trial
        % Debug Alex: sonst fehlerhaftes Mehrfachauslsen des ok-Buttons mglich
        set(handles.pb_ok,'Visible','Off');
        % Debug Alex: sonst stndig im Hintergrund sichtbar, hsslich
        set(handles.ed_instruction,'String',TSP.sections{PP.run_section_line,4}{1,2},'Visible','Off');
        
        write_to_log('');
        write_to_log(['section ', num2str(PP.run_section_line), ' - ', TSP.sections{PP.run_section_line,2}]);
        write_to_log('--------------------------------------------------------------');
        write_to_log(datestr(clock, 'local'));
        
        % Generating playlist 
        trialcount=TSP.sections{PP.run_section_line,4}{1,4}{1,1};
        PP.playlist=zeros(str2double(trialcount),2);
        for i=1:str2double(trialcount)
           PP.playlist(i,:)=randperm(2);
        end
        
        % Erzeugung einer Playlist fr je einen randomisierten Stimuli, 
        % der spter per OSC angesprochen werden soll
        % Werte von 1 bis Anzahl Trials
        if  str2double(TSP.sections{PP.run_section_line,4}{1,1}) == 1
            PP.playlist_osc_stimuli=num2cell(randperm(str2double(trialcount)));
            PP.play=0;
            PP.stop=1;
            PP.random_stimuli=1;
        else
            PP.random_stimuli=0;
        end
        
        write_to_log('object playlist:');
        write_to_log(num2str(PP.playlist));
        PP.counter=1;
        abx_vp;
    case 'tid5' % SAQI Trial
        % Debug Alex: sonst fehlerhaftes Mehrfachauslesen des ok-button moeglich
        set(handles.pb_ok,'Visible','Off');
        % Debug Alex: sonst staendig im Hintergrund sichtbar, haesslich
        set(handles.ed_instruction,'String',TSP.sections{PP.run_section_line,4}{1,2},'Visible','Off');
        
        % --- find out how many test conditions we have ---
        num_grp  = TSP.sections{PP.run_section_line,4}{1,3}{14};
        num_test = TSP.sections{PP.run_section_line,4}{1,3}{15};
        num_anch = TSP.sections{PP.run_section_line,4}{1,3}{16};
        num_cond = num_grp*(num_test+num_anch);
        PP.nCond = num_cond;
        
        % --- get randomization modes ---
        rand_grp  = TSP.sections{PP.run_section_line,4}{1,3}{17};
        rand_cond = TSP.sections{PP.run_section_line,4}{1,3}{18};
        
        % --- get cell array with test conditions ---
        for k = 1:num_grp
            m = (k-1)*num_test + (k-1)*num_anch + (k-1);
            cell_cond{m+1} = ['A' num2str(k) ' Reference condition'];
            for l = 1:num_anch
                cell_cond{m+l+1} = [char(65+l) num2str(k) ' Anchor condition'];
            end
            for o = 1:num_test
                cell_cond{m+o+num_anch+1} = [char(65+o+num_anch) num2str(k) ' Test condition'];
            end
        end
        
        % --- write log ---
        write_to_log('');
        write_to_log(['section ', num2str(PP.run_section_line), ' - ', TSP.sections{PP.run_section_line,2}]);
        write_to_log('--------------------------------------------------------------');
        write_to_log(datestr(clock, 'local'));
        
        % ---- Initialize cell array for saving subject data ----
        % write header
        PP.subject_data = cell(size(TSP.sections{PP.run_section_line,4}{1,6},1)+1,30, num_cond);
        for m = 1:num_cond
            PP.subject_data{1,1,m}  = 'Quality ID';
            PP.subject_data{1,2,m}  = 'Quality';
            PP.subject_data{1,3,m}  = 'Category ID';
            PP.subject_data{1,4,m}  = 'Category';
            PP.subject_data{1,5,m}  = 'Item_Included';
            PP.subject_data{1,6,m}  = 'Rated';
            PP.subject_data{1,7,m}  = 'Modification 1';
            PP.subject_data{1,8,m}  = 'Answer 1';
            PP.subject_data{1,9,m}  = 'Modification 2';
            PP.subject_data{1,10,m} = 'Answer 2';
            PP.subject_data{1,11,m} = 'Modification 3';
            PP.subject_data{1,12,m} = 'Answer 3.1';
            PP.subject_data{1,13,m} = 'Answer 3.2';
            PP.subject_data{1,14,m} = 'Answer 3.3';
            PP.subject_data{1,15,m} = 'Rating';
            PP.subject_data{1,16,m} = 'Entities';
            PP.subject_data{1,17,m} = 'Entity 1 Name';
            PP.subject_data{1,18,m} = 'Entity 1';
            PP.subject_data{1,19,m} = 'Entity 2 Name';
            PP.subject_data{1,20,m} = 'Entity 2';
            PP.subject_data{1,21,m} = 'Entity 3 Name';
            PP.subject_data{1,22,m} = 'Entity 3';
            PP.subject_data{1,23,m} = 'Entity 4 Name';
            PP.subject_data{1,24,m} = 'Entity 4';
            PP.subject_data{1,25,m} = 'Entity 5 Name';
            PP.subject_data{1,26,m} = 'Entity 5';
            PP.subject_data{1,27,m} = 'Entity 6 Name';
            PP.subject_data{1,28,m} = 'Entity 6';
            PP.subject_data{1,29,m} = 'Entity 7 Name';
            PP.subject_data{1,30,m} = 'Entity 7';
            PP.subject_data{1,31,m} = 'Test condition';
            PP.subject_data{1,32,m} = 'Scale size';
            PP.subject_data{1,33,m} = 'SAQI version';
        
        
            % write default values
            for n = 2:size(TSP.sections{PP.run_section_line,4}{1,6},1)+1
                PP.subject_data{n,1,m} = n-1;
                
                % check if item is included in the test 
                tmp_included_items = cell2mat(TSP.sections{PP.run_section_line,4}{1,4});
                if find(tmp_included_items == n-1)
                    PP.subject_data {n,5,m} = 1;    % was included
                else
                    PP.subject_data {n,5,m} = 0;    % was not included
                end
                
                % write category of item (timbre, tonalness, etc.)
                PP.subject_data{n,3,m} = TSP.sections{PP.run_section_line,4}{1,6}{n-1,5};
                if PP.subject_data{n,3,m}>0
                    PP.subject_data {n,4,m}= TSP.sections{PP.run_section_line,4}{1,12}{PP.subject_data{n,3,m},2};   % this is the category
                else
                    PP.subject_data {n,4,m}='none';   % items 'overall difference' and 'other' have no categroy
                end
                
                % write item name (tone-color, sharpness, etc.)
                PP.subject_data {n,2,m} = TSP.sections{PP.run_section_line,4}{1,6}{n-1,2};
                PP.subject_data {n,6,m} = NaN; 
                
                % Write modification 1 (constant vs. time varying difference)
                PP.subject_data {n,7,m} = TSP.sections{PP.run_section_line,4}{1,3}{3};
                PP.subject_data {n,8,m} = NaN;
                % Write modification 2 (steady vs. not steady)
                PP.subject_data {n,9,m} = TSP.sections{PP.run_section_line,4}{1,3}{4};
                PP.subject_data {n,10,m} = NaN;
                % Write modification 3 (dependency of differences on intercation)
                PP.subject_data {n,11,m} = TSP.sections{PP.run_section_line,4}{1,3}{5};
                PP.subject_data {n,12,m} = NaN;
                PP.subject_data {n,13,m} = NaN;
                PP.subject_data {n,14,m} = NaN;
                PP.subject_data {n,15,m} = NaN;
                
                % Check if assessment entities are included, and write 1 or 0
                PP.subject_data {n,16,m} = TSP.sections{PP.run_section_line,4}{1,3}{6};
                % get names of used assessment entities
                tmp_entites = cell2mat(TSP.sections{PP.run_section_line,4}{1,10});
                for p = 1:7
                    % write name and leaf space for rating if assessment entity is used
                    if find(tmp_entites == p)
                        PP.subject_data {n,17+2*(p-1),m} = TSP.sections{PP.run_section_line,4}{1,11}{p,2};
                        PP.subject_data {n,18+2*(p-1),m} = NaN;
                    % assessment entity was not used
                    else
                        PP.subject_data {n,17+2*(p-1),m} = NaN;
                        PP.subject_data {n,18+2*(p-1),m} = NaN;
                    end
                end
                
                % write test condition
                p = floor((m-1)/(num_test+num_anch))+m+1;   % current index of test/anchor condition in cell_cond
                q = p - mod(m-1, (num_test+num_anch))-1;    % current index of reference condition in cell_cond
                
                p_stim = TSP.sections{PP.run_section_line,4}{1,5}(p); % current index of test/anchor condition in global stimulus pool
                q_stim = TSP.sections{PP.run_section_line,4}{1,5}(q); % current index of reference condition in global stimulus pool

                % check if we are testing against explicit or inner reference
                if q_stim
                    cond_str = [cell_cond{p} ' (S' num2str(TSP.stimuli{p_stim,1}) ' ' TSP.stimuli{p_stim,2} ') vs. ' ...
                                cell_cond{q} ' (S' num2str(TSP.stimuli{q_stim,1}) ' ' TSP.stimuli{q_stim,2} ')'];
                else
                    cond_str = [cell_cond{p} ' (S' num2str(TSP.stimuli{p_stim,1}) ' ' TSP.stimuli{p_stim,2} ') vs. (inner reference)'];
                    
                end
                PP.subject_data {n,31,m} = cond_str;
                
                % write scale size and SAQI version
                PP.subject_data {n,32,m}= num2str(TSP.sections{PP.run_section_line,4}{1,3}{1,9});
                PP.subject_data {n,33,m}= TSP.sections{PP.run_section_line,4}{1,15}; 
                
            end
        end
        
        % --- initialize random number generator ---
        rng('shuffle');
        
        % --- initialize counter, part 1 ---
        PP.current_id = 0;  % counter for tracking current item
        PP.number_of_items = numel(TSP.sections{PP.run_section_line,4}{1,4});   % number_of_items

       
        % --- find out how many groups and conditions we will have per rating screen ---
        
        % maximum number of conditions allowed per rating screen
        max_cond_per_screen  = eval(TSP.sections{PP.run_section_line,4}{1,3}{19});
        % minimum number of conditions allowed on last rating screen
        min_cond_last_screen = eval(TSP.sections{PP.run_section_line,4}{1,3}{20});
        % minimum number of groups allowed on last reting screens
        min_grp_last_screen  = eval(TSP.sections{PP.run_section_line,4}{1,3}{21});
        % NOTE: above criteria are violated if they are impossible to meet
        %       (look for 'rules for selection' for more information)
        
        % how many groups fit one screen (max_cond_per_screen are allowed)
        grps_per_screen = min(num_grp, max(1, floor(max_cond_per_screen/(num_test+num_anch))));
        max_grps_per_screen = grps_per_screen;
        
        if grps_per_screen == 1
            % how many screens do we need for each group?
            n    = 1;
            while 1
                if ceil(num_test/n)+num_anch <= max_cond_per_screen
                    break
                else
                    n=n+1;
                end
            end
            screens_per_grp    = n;
            min_screns_per_grp = n;
            
            if screens_per_grp == 1
                cond_per_screen = num_test;
                num_cond_last_screen = num_test;
            else
                % find best distribution of conditions across screens
                % (try to avoid only 1 or 2 conditions on the last screen)
                tmp = [];
                for n = 1:min(num_test, max_cond_per_screen-num_anch)
                    actual_screens_per_group = ceil(num_test/n);
                    num_cond_last_screen = num_test - n*(actual_screens_per_group-1);
                    tmp = [tmp; [n actual_screens_per_group num_cond_last_screen]];
                end
                
                % rule for selection:
                % (a) try to distribute conditions evenly or,
                % (b) distribution that has at least min_cond_last_screen
                %     conditions on last screen (test + anchor conditions)
                %     and maximum number on all other screens, or
                % (c) distribution with the least screens per group
                
                select = find(tmp(:,1)==tmp(:,3) & tmp(:,2)==screens_per_grp); % (a)
                if ~isempty(select)
                    tmp = tmp(select,:);
                else
                    select = find(tmp(:,3)>=min_cond_last_screen-num_anch, 1, 'last'); % (b)
                    if ~isempty(select)
                        tmp = tmp(select,:);
                    else
                        tmp = tmp(end,:);   % (c)
                    end
                end

                cond_per_screen      = tmp(1);
                screens_per_grp      = tmp(2);
                num_cond_last_screen = tmp(3);
            end
            
            num_screens = screens_per_grp * num_grp;
            
            % for debugging:
            % disp(['test cond.: ' num2str(num_test) ', (' num2str(grps_per_screen) ' ' ...
            %                                              num2str(screens_per_grp) '/' num2str(min_screns_per_grp) ' '...
            %                                              num2str(cond_per_screen) '/' num2str(num_cond_last_screen) ' ' ...
            %                                              num2str(num_screens) ')'])
            
        else % grps_per_screen > 1
            
            num_screens = ceil(num_grp/grps_per_screen);
            
            % find best distribution of groups across screens
            % (try to avoid only 1 group on the last screen)
            tmp = [];
            for n = 2:grps_per_screen
                actual_num_screens = ceil(num_grp/n);
                num_grps_last_screen = num_grp - (actual_num_screens-1)*n;
                tmp = [tmp; [n actual_num_screens num_grps_last_screen]];
            end
            
            % rule for selection:
            % (a) try to distribute grps evenly or,
            % (b) distribution that has at least min_grp_last_screen
            %     groups on last screen and maximum number on all other
            %     screens, or
            % (c) distribution with the least screens per group
            
            select = find(tmp(:,1)==tmp(:,3) & tmp(:,2)==num_screens); % (a)
            if ~isempty(select)
                tmp = tmp(select,:);
            else
                select = find(tmp(:,3)>=min_grp_last_screen, 1, 'last'); % (b)
                if ~isempty(select)
                    tmp = tmp(select,:);
                else
                    tmp = tmp(end,:);   % (c)
                end
            end
            % NOTE: due to this criterion there are some cases, where
            % more screens per group are needed than neccessary:
            % 21, or 26 test conditions, 1 anchor condition
            grps_per_screen      = tmp(1);
            num_screens          = tmp(2);
            num_grps_last_screen = tmp(3);
            
            cond_per_screen = grps_per_screen * (num_test+num_anch);
            screens_per_grp = 1;
            
            % for debugging:
            % disp(['groups: ' num2str(num_grp) ', (' num2str(grps_per_screen) '/' num2str(num_grps_last_screen) ' ' ...
            %                                         num2str(max_grps_per_screen) ' ' ...
            %                                         num2str(num_screens) ')'])
        end
        
        clear max_grps_per_screen n min_screns_per_grp num_cond_last_screen tmp actual_screens_per_group select actual_num_screens num_grps_last_screen
        
        % --- distribute conditions accros ratings screens ---
        for nItem = 1:PP.number_of_items
            
            cur_grp  = 0;
            
            if rand_grp == 1 & nItem == 1
                % group order remaines as specified by user
                grp_order  = 1:num_grp;
            elseif (rand_grp == 2 & nItem == 1) | rand_grp == 3
                % premutate oder of groups
                grp_order  = randperm(num_grp);
            end
            
            if rand_cond == 1 & nItem == 1
                % write indecees of test conditions as saved in SAQI stimulus pool in
                % user defined order, and according to order of groups
                for nGroup = 1:num_grp
                    test_order(:,nGroup) = (1:num_test)' + grp_order(nGroup)+grp_order(nGroup)*(num_anch)+(grp_order(nGroup)-1)*num_test;
                end
            elseif (rand_cond == 2 & nItem == 1) | rand_cond == 3
                % write indecees of test conditions as saved in SAQI stimulus pool in
                % permutated order, and according to order of groups
                for nGroup = 1:num_grp
                    test_order(:,nGroup) = randperm(num_test) + grp_order(nGroup)+grp_order(nGroup)*(num_anch)+(grp_order(nGroup)-1)*num_test;
                end
            end
            
            for nScreen = 1:num_screens
                if screens_per_grp == 1
                    
                    % empty vector for interleaving test and anchor conditions
                    tmp_cond = zeros((num_test+num_anch)*grps_per_screen,1);
                    tmp_ref  = tmp_cond;
                    
                    for nGroup = 1:grps_per_screen
                        cur_grp = cur_grp + 1;
                        if cur_grp <= num_grp
                            if num_anch
                                % first index is position of first anchor on rating screen, etc.
                                if rand_cond==1 & nItem==1
                                    anch(:,1,cur_grp) = (1:num_anch)';
                                    anch(:,1,cur_grp) = anch(:,1,cur_grp) + (nGroup-1)*(num_test+num_anch);
                                elseif (rand_cond == 2 & nItem == 1) | rand_cond == 3
                                    anch(:,1,cur_grp) = randperm(num_test+num_anch, num_anch)';
                                    anch(:,1,cur_grp) = anch(:,1,cur_grp) + (nGroup-1)*(num_test+num_anch);
                                end
                                % index of anchor in SAQI stimulus pool
                                anch(:,2, cur_grp) = (1:num_anch)' + (grp_order(cur_grp)-1)*(num_test+num_anch)+grp_order(cur_grp);
                                % write anchors to vector
                                tmp_cond(anch(:,1,cur_grp),1) = anch(:,2,cur_grp);
                            end
                            
                            % write test conditions to vector
                            m = 1;
                            for n = (nGroup-1)*(num_test+num_anch)+1:nGroup*(num_test+num_anch)
                                if ~tmp_cond(n)
                                    tmp_cond(n) = test_order(m, cur_grp);
                                    m = m+1;
                                end
                                tmp_ref(n) = (grp_order(cur_grp)-1)*(num_test+num_anch+1)+1;
                            end
                        else
                            % shorten tmp_vector
                            tmp_cond = tmp_cond(1:end-num_test-num_anch);
                            tmp_ref  = tmp_ref (1:end-num_test-num_anch);
                            break
                        end
                    end
                    
                    % write order of conditions to PP for stimulus playback during
                    % SAQI test
                    PP.conditions{nItem,1}{nScreen,1} = tmp_cond;
                    PP.references{nItem,1}{nScreen,1} = tmp_ref;
                    
                else
                    
                    for nGroup = 1:num_grp
                        
                        cur_test = 0;
                        
                        for nSubScreen = 1:screens_per_grp
                            % empty vector for interleaving test and anchor conditions
                            tmp_cond = zeros(min(cond_per_screen+num_anch, num_test+num_anch-cur_test),1);
                            
                            if num_anch
                                % first index is position of first anchor on rating screen, etc.
                                if rand_cond==1 & nItem==1
                                    anch(:,1,nSubScreen) = (1:num_anch)';
                                elseif (rand_cond == 2 & nItem == 1) | rand_cond == 3
                                    anch(:,1,nSubScreen) = randperm(cond_per_screen+num_anch, num_anch)';
                                end
                                % index of anchor in SAQI stimulus pool
                                anch(:,2, nSubScreen) = (1:num_anch)' + (grp_order(nGroup)-1)*(num_test+num_anch)+grp_order(nGroup);
                                % write anchors to vector
                                tmp_cond(anch(:,1,nSubScreen),1) = anch(:,2,nSubScreen);
                            end
                            
                            % write test conditions to vector
                            for n = 1:length(tmp_cond)
                                if ~tmp_cond(n)
                                    cur_test = cur_test+1;
                                    tmp_cond(n) = test_order(cur_test, nGroup);
                                end
                            end
                            
                            % write order of conditions to PP for stimulus playback during
                            % SAQI test
                            PP.conditions{nItem,1}{(nGroup-1)*screens_per_grp+nSubScreen,1} = tmp_cond;
                            PP.references{nItem,1}{(nGroup-1)*screens_per_grp+nSubScreen,1} = ((grp_order(nGroup)-1)*(num_test+num_anch+1)+1)*ones(size(tmp_cond));
                            
                        end
                    end
                end
            end
        end
        
        clear nItem nScreen nGroup grp_order test_order tmp cur_grp cur_test anch n m tmp_cond
        
        
        % --- initialize counter, part 2 ---
        PP.nScreen = 1; % counter for tracking current rating screen (used in SAQIvp_1.m)
        PP.numScreens = num_screens;
        
        % ---- randomize items ----
        if TSP.sections{PP.run_section_line,4}{1,3}{13}
            % collect selected items (column 1) and corresponding
            % categories (column 2)
            for n = 1:numel(TSP.sections{PP.run_section_line,4}{1,4})
               tmp_items(n,1) =  TSP.sections{PP.run_section_line,4}{1,4}{n};
               tmp_items(n,2) =  TSP.sections{PP.run_section_line,4}{1,6}{tmp_items(n,1),5};              
            end
            
            % find catogeries of which items are used
            tmp_included_categories = unique(tmp_items(:,2));
            tmp_included_categories = tmp_included_categories(tmp_included_categories ~= 0);
            
            % randomized order of categories
            order_categories = randperm(numel(tmp_included_categories));
            tmp_included_categories = tmp_included_categories(order_categories);
            
            % re-order tmp_items according to order_categories
            order_id = [];
            for n = 1:numel(tmp_included_categories) 
                order_id = [order_id; find(tmp_items(:,2)==tmp_included_categories(n))];
            end
            order_id = [1; order_id; size(tmp_items, 1)];
            
            tmp_items(:,1) = tmp_items(order_id, 1);
            tmp_items(:,2) = tmp_items(order_id, 2);
            
            % randomize items within categories
            for n = 1:numel(tmp_included_categories)
                cat_id    = find(tmp_items(:,2)==tmp_included_categories(n));
                cat_order = randperm(numel(cat_id));
                
                tmp_items(cat_id,1) = tmp_items(cat_id(cat_order), 1);
                tmp_items(cat_id,2) = tmp_items(cat_id(cat_order), 2);
            end
            % write to TSP
            for n = 1: numel (TSP.sections{PP.run_section_line,4}{1,4})
                TSP.sections{PP.run_section_line,4}{1,4}{n} = tmp_items (n,1);
            end
        end
        
        % --- randomize scale label/poles ---
        % scale poles are switched if rand_scale_label(PP.current_id) == 1
        if TSP.sections{PP.run_section_line,4}{1,3}{10}
            PP.rand_scale_label = round(rand(PP.number_of_items,1));
        else
            PP.rand_scale_label = zeros(PP.number_of_items,1);
        end
        
        % --- randomize test and reference stimuli ---
        % stimuli are switched if rand_stimuli(PP.current_id) == 1 
        for n = 1:PP.number_of_items
            for m = 1:length(PP.conditions{n})
                if TSP.sections{PP.run_section_line,4}{1,3}{12} && ...
                        ~TSP.sections{PP.run_section_line,4}{1,3}{11} % only randomize if we are not comparing to inner reference
                    PP.rand_stimuli{n,1}{m,1} = round(rand(size(PP.conditions{n,1}{m,1})));
                else
                    PP.rand_stimuli{n,1}{m,1} = zeros(size(PP.conditions{n,1}{m,1}));
                end
            end
        end
        
        % --- Field for saving ratings in TSP struct ---
        % Data is saved contrary to Whisper default, because this would
        % result in a very large number of columns per subject
        TSD{1,3+PP.run_section_line}{1} = {['Subject Data (section ' num2str(PP.run_section_line) ')']};
        
        % --- Start SAQI questionaire ---
        if TSP.sections{PP.run_section_line,4}{1,3}{2} % go to first item definition
            saqi_vp_3;
        else  % go to first item rating
            saqi_vp_1; % multiple stimulus SAQI
        end
        
    case 'tid6' % ABCHR & MUSHRA
        % Debug Alex: sonst fehlerhaftes Mehrfachauslesen des ok-button moeglich
        set(handles.pb_ok,'Visible','Off');
        % Debug Alex: sonst staendig im Hintergrund sichtbar, haesslich
        set(handles.ed_instruction,'String',TSP.sections{PP.run_section_line,4}{1,2},'Visible','Off');
        
        % --- find out how many test conditions we have ---
        num_grp  = TSP.sections{PP.run_section_line,4}{1,3}{14};
        num_test = TSP.sections{PP.run_section_line,4}{1,3}{15};
        num_anch = TSP.sections{PP.run_section_line,4}{1,3}{16};
        num_cond = num_grp*(num_test+num_anch);
        PP.nCond = num_cond;
        
        % --- get randomization modes ---
        rand_grp  = TSP.sections{PP.run_section_line,4}{1,3}{17};
        rand_cond = TSP.sections{PP.run_section_line,4}{1,3}{18};
        
        % --- get cell array with test conditions ---
        for k = 1:num_grp
            m = (k-1)*num_test + (k-1)*num_anch + (k-1);
            cell_cond{m+1} = ['A' num2str(k) ' Reference condition'];
            for l = 1:num_anch
                cell_cond{m+l+1} = [char(65+l) num2str(k) ' Anchor condition'];
            end
            for o = 1:num_test
                cell_cond{m+o+num_anch+1} = [char(65+o+num_anch) num2str(k) ' Test condition'];
            end
        end
        
        % --- write log ---
        write_to_log('');
        write_to_log(['section ', num2str(PP.run_section_line), ' - ', TSP.sections{PP.run_section_line,2}]);
        write_to_log('--------------------------------------------------------------');
        write_to_log(datestr(clock, 'local'));
        
        % ---- Initialize cell array for saving subject data ----0
        % write header
        PP.subject_data = cell(2, num_cond);
        for m = 1:num_cond
            % write test condition
            p = floor((m-1)/(num_test+num_anch))+m+1;   % current index of test/anchor condition in cell_cond
            q = p - mod(m-1, (num_test+num_anch))-1;    % current index of reference condition in cell_cond
            
            p_stim = TSP.sections{PP.run_section_line,4}{1,5}(p); % current index of test/anchor condition in global stimulus pool
            q_stim = TSP.sections{PP.run_section_line,4}{1,5}(q); % current index of reference condition in global stimulus pool
            % check if we are testing against explicit or inner reference
            cond_str = [cell_cond{p} ' (S' num2str(TSP.stimuli{p_stim,1}) ' ' TSP.stimuli{p_stim,2} ') vs. ' ...
                cell_cond{q} ' (S' num2str(TSP.stimuli{q_stim,1}) ' ' TSP.stimuli{q_stim,2} ')'];
            
            
            PP.subject_data{1,m} = cond_str;
        end
        
        % --- initialize random number generator ---
        rng('shuffle');
       
        % --- find out how many groups and conditions we will have per rating screen ---
        % maximum number of conditions allowed per rating screen
        max_cond_per_screen  = eval(TSP.sections{PP.run_section_line,4}{1,3}{19});
        % minimum number of conditions allowed on last rating screen
        min_cond_last_screen = eval(TSP.sections{PP.run_section_line,4}{1,3}{20});
        % minimum number of groups allowed on last reting screens
        min_grp_last_screen  = eval(TSP.sections{PP.run_section_line,4}{1,3}{21});
        % NOTE: above criteria are violated if they are impossible to meet
        %       (look for 'rules for selection' for more information)
        
        % how many groups fit one screen (max_cond_per_screen are allowed)
        grps_per_screen = min(num_grp, max(1, floor(max_cond_per_screen/(num_test+num_anch))));
        max_grps_per_screen = grps_per_screen;
        
        if grps_per_screen == 1
            % how many screens do we need for each group?
            n    = 1;
            while 1
                if ceil(num_test/n)+num_anch <= max_cond_per_screen
                    break
                else
                    n=n+1;
                end
            end
            screens_per_grp    = n;
            min_screns_per_grp = n;
            
            if screens_per_grp == 1
                cond_per_screen = num_test;
                num_cond_last_screen = num_test;
            else
                % find best distribution of conditions across screens
                % (try to avoid only 1 or 2 conditions on the last screen)
                tmp = [];
                for n = 1:min(num_test, max_cond_per_screen-num_anch)
                    actual_screens_per_group = ceil(num_test/n);
                    num_cond_last_screen = num_test - n*(actual_screens_per_group-1);
                    tmp = [tmp; [n actual_screens_per_group num_cond_last_screen]];
                end
                
                % rule for selection:
                % (a) try to distribute conditions evenly or,
                % (b) distribution that has at least min_cond_last_screen
                %     conditions on last screen (test + anchor conditions)
                %     and maximum number on all other screens, or
                % (c) distribution with the least screens per group
                
                select = find(tmp(:,1)==tmp(:,3) & tmp(:,2)==screens_per_grp); % (a)
                if ~isempty(select)
                    tmp = tmp(select,:);
                else
                    select = find(tmp(:,3)>=min_cond_last_screen-num_anch, 1, 'last'); % (b)
                    if ~isempty(select)
                        tmp = tmp(select,:);
                    else
                        tmp = tmp(end,:);   % (c)
                    end
                end

                cond_per_screen      = tmp(1);
                screens_per_grp      = tmp(2);
                num_cond_last_screen = tmp(3);
            end
            
            num_screens = screens_per_grp * num_grp;
            
            % for debugging:
            % disp(['test cond.: ' num2str(num_test) ', (' num2str(grps_per_screen) ' ' ...
            %                                              num2str(screens_per_grp) '/' num2str(min_screns_per_grp) ' '...
            %                                              num2str(cond_per_screen) '/' num2str(num_cond_last_screen) ' ' ...
            %                                              num2str(num_screens) ')'])
            
        else % grps_per_screen > 1
            
            num_screens = ceil(num_grp/grps_per_screen);
            
            % find best distribution of groups across screens
            % (try to avoid only 1 group on the last screen)
            tmp = [];
            for n = 2:grps_per_screen
                actual_num_screens = ceil(num_grp/n);
                num_grps_last_screen = num_grp - (actual_num_screens-1)*n;
                tmp = [tmp; [n actual_num_screens num_grps_last_screen]];
            end
            
            % rule for selection:
            % (a) try to distribute grps evenly or,
            % (b) distribution that has at least min_grp_last_screen
            %     groups on last screen and maximum number on all other
            %     screens, or
            % (c) distribution with the least screens per group
            
            select = find(tmp(:,1)==tmp(:,3) & tmp(:,2)==num_screens); % (a)
            if ~isempty(select)
                tmp = tmp(select,:);
            else
                select = find(tmp(:,3)>=min_grp_last_screen, 1, 'last'); % (b)
                if ~isempty(select)
                    tmp = tmp(select,:);
                else
                    tmp = tmp(end,:);   % (c)
                end
            end
            % NOTE: due to this criterion there are some cases, where
            % more screens per group are needed than neccessary:
            % 21, or 26 test conditions, 1 anchor condition
            grps_per_screen      = tmp(1);
            num_screens          = tmp(2);
            num_grps_last_screen = tmp(3);
            
            cond_per_screen = grps_per_screen * (num_test+num_anch);
            screens_per_grp = 1;
            
            % for debugging:
            % disp(['groups: ' num2str(num_grp) ', (' num2str(grps_per_screen) '/' num2str(num_grps_last_screen) ' ' ...
            %                                         num2str(max_grps_per_screen) ' ' ...
            %                                         num2str(num_screens) ')'])
        end
        
        clear max_grps_per_screen n min_screns_per_grp num_cond_last_screen tmp actual_screens_per_group select actual_num_screens num_grps_last_screen
        
        % --- distribute conditions accros ratings screens ---
        for nItem = 1 % in saqi we had up to 48 items...
            
            cur_grp  = 0;
            
            if rand_grp == 1 & nItem == 1
                % group order remaines as specified by user
                grp_order  = 1:num_grp;
            elseif (rand_grp == 2 & nItem == 1) | rand_grp == 3
                % premutate oder of groups
                grp_order  = randperm(num_grp);
            end
            
            if rand_cond == 1 & nItem == 1
                % write indecees of test conditions as saved in SAQI stimulus pool in
                % user defined order, and according to order of groups
                for nGroup = 1:num_grp
                    test_order(:,nGroup) = (1:num_test)' + grp_order(nGroup)+grp_order(nGroup)*(num_anch)+(grp_order(nGroup)-1)*num_test;
                end
            elseif (rand_cond == 2 & nItem == 1) | rand_cond == 3
                % write indecees of test conditions as saved in SAQI stimulus pool in
                % permutated order, and according to order of groups
                for nGroup = 1:num_grp
                    test_order(:,nGroup) = randperm(num_test) + grp_order(nGroup)+grp_order(nGroup)*(num_anch)+(grp_order(nGroup)-1)*num_test;
                end
            end
            
            for nScreen = 1:num_screens
                if screens_per_grp == 1
                    
                    % empty vector for interleaving test and anchor conditions
                    tmp_cond = zeros((num_test+num_anch)*grps_per_screen,1);
                    tmp_ref  = tmp_cond;
                    
                    for nGroup = 1:grps_per_screen
                        cur_grp = cur_grp + 1;
                        if cur_grp <= num_grp
                            if num_anch
                                % first index is position of first anchor on rating screen, etc.
                                if rand_cond==1 & nItem==1
                                    anch(:,1,cur_grp) = (1:num_anch)';
                                    anch(:,1,cur_grp) = anch(:,1,cur_grp) + (nGroup-1)*(num_test+num_anch);
                                elseif (rand_cond == 2 & nItem == 1) | rand_cond == 3
                                    anch(:,1,cur_grp) = randperm(num_test+num_anch, num_anch)';
                                    anch(:,1,cur_grp) = anch(:,1,cur_grp) + (nGroup-1)*(num_test+num_anch);
                                end
                                % index of anchor in SAQI stimulus pool
                                anch(:,2, cur_grp) = (1:num_anch)' + (grp_order(cur_grp)-1)*(num_test+num_anch)+grp_order(cur_grp);
                                % write anchors to vector
                                tmp_cond(anch(:,1,cur_grp),1) = anch(:,2,cur_grp);
                            end
                            
                            % write test conditions to vector
                            m = 1;
                            for n = (nGroup-1)*(num_test+num_anch)+1:nGroup*(num_test+num_anch)
                                if ~tmp_cond(n)
                                    tmp_cond(n) = test_order(m, cur_grp);
                                    m = m+1;
                                end
                                tmp_ref(n) = (grp_order(cur_grp)-1)*(num_test+num_anch+1)+1;
                            end
                        else
                            % shorten tmp_vector
                            tmp_cond = tmp_cond(1:end-num_test-num_anch);
                            tmp_ref  = tmp_ref (1:end-num_test-num_anch);
                            break
                        end
                    end
                    
                    % write order of conditions to PP for stimulus playback during
                    % SAQI test
                    PP.conditions{nItem,1}{nScreen,1} = tmp_cond;
                    PP.references{nItem,1}{nScreen,1} = tmp_ref;
                    
                else
                    
                    for nGroup = 1:num_grp
                        
                        cur_test = 0;
                        
                        for nSubScreen = 1:screens_per_grp
                            % empty vector for interleaving test and anchor conditions
                            tmp_cond = zeros(min(cond_per_screen+num_anch, num_test+num_anch-cur_test),1);
                            
                            if num_anch
                                % first index is position of first anchor on rating screen, etc.
                                if rand_cond==1 & nItem==1
                                    anch(:,1,nSubScreen) = (1:num_anch)';
                                elseif (rand_cond == 2 & nItem == 1) | rand_cond == 3
                                    anch(:,1,nSubScreen) = randperm(cond_per_screen+num_anch, num_anch)';
                                end
                                % index of anchor in SAQI stimulus pool
                                anch(:,2, nSubScreen) = (1:num_anch)' + (grp_order(nGroup)-1)*(num_test+num_anch)+grp_order(nGroup);
                                % write anchors to vector
                                tmp_cond(anch(:,1,nSubScreen),1) = anch(:,2,nSubScreen);
                            end
                            
                            % write test conditions to vector
                            for n = 1:length(tmp_cond)
                                if ~tmp_cond(n)
                                    cur_test = cur_test+1;
                                    tmp_cond(n) = test_order(cur_test, nGroup);
                                end
                            end
                            
                            % write order of conditions to PP for stimulus playback during
                            % SAQI test
                            PP.conditions{nItem,1}{(nGroup-1)*screens_per_grp+nSubScreen,1} = tmp_cond;
                            PP.references{nItem,1}{(nGroup-1)*screens_per_grp+nSubScreen,1} = ((grp_order(nGroup)-1)*(num_test+num_anch+1)+1)*ones(size(tmp_cond));
                            
                        end
                    end
                end
            end
        end
        
        clear nItem nScreen nGroup grp_order test_order tmp cur_grp cur_test anch n m tmp_cond
        
        
        % --- initialize counter, part 2 ---
        PP.nScreen = 1; % counter for tracking current rating screen (used in SAQIvp_1.m)
        PP.numScreens = num_screens;
        
        % --- randomize test and reference stimuli ---
        % stimuli are switched if rand_stimuli(PP.current_id) == 1 
        for n = 1
            for m = 1:length(PP.conditions{n})
                if TSP.sections{PP.run_section_line,4}{1,4} == 1 % only randomize if we are doing abc/hr
                    PP.rand_stimuli{n,1}{m,1} = round(rand(size(PP.conditions{n,1}{m,1})));
                else
                    PP.rand_stimuli{n,1}{m,1} = zeros(size(PP.conditions{n,1}{m,1}));
                end
            end
        end
        
        % --- Field for saving ratings in TSP struct ---
        % Data is saved contrary to Whisper default, because this would
        % result in a very large number of columns per subject
        TSD{1,3+PP.run_section_line}{1} = {['Subject Data (section ' num2str(PP.run_section_line) ')']};
        
        % --- Start test procedure ---
        abchr_mushra_vp
end

function ed_instruction_Callback(hObject, eventdata, handles)
% hObject    handle to ed_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_instruction as text
%        str2double(get(hObject,'String')) returns contents of ed_instruction as a double


% --- Executes during object creation, after setting all properties.
function ed_instruction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_close.
function pb_close_Callback(hObject, eventdata, handles)
% hObject    handle to pb_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
PP.allowed_to_close=1;
close
PP.allowed_to_close=0;
mainmenu


% --- Executes when user attempts to close vp_main.
function vp_main_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to vp_main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP

if PP.allowed_to_close==1
    delete(hObject);
else
    set(handles.ed_break,'Visible','On');
    set(handles.pb_break,'Visible','On');
    set(handles.pb_hide,'Visible','On');
end


function ed_break_Callback(hObject, eventdata, handles)
% hObject    handle to ed_break (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_break as text
%        str2double(get(hObject,'String')) returns contents of ed_break as a double


% --- Executes during object creation, after setting all properties.
function ed_break_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_break (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_break.
function pb_break_Callback(hObject, eventdata, handles)
% hObject    handle to pb_break (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
breakstring=get(handles.ed_break,'String');
if breakstring=='break'
    PP.allowed_to_close=1;
    close all
    PP.allowed_to_close=0;
    mainmenu
end


% --- Executes on button press in pb_hide.
function pb_hide_Callback(hObject, eventdata, handles)
% hObject    handle to pb_hide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.ed_break,'String','');
set(handles.ed_break,'Visible','Off');
set(handles.pb_break,'Visible','Off');
set(handles.pb_hide,'Visible','Off');
