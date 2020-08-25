% =========================================================================
%
% This file has been written as part of WhisPER, a package of interacting
% MATLAB scripts for designing and controlling experiments in the field of
% auditory perceptive measurement and evaluation. The copyright for WhisPER
% is held by its originators Andr? Wlodarski and Simon Ciba and protected
% by the German Copyright Act (? 2 Abs. 2 UrhG).
%
% Copyright (C) 2008, 2009 Andr? Wlodarski and Simon Ciba
%
%
% Note: The use of WhisPER or any of its components is under the complete
% and sole responsibility of the user.
%
% -------------------------------------------------------------------------
%
% This file:
%
% Author :   Andr? Wlodarski, student at FG Audiokommunikation, TU Berlin
% Email  :   awlodarski AT gmx DOT de
% Date   :   15-Nov-2008
%
% =========================================================================


function varargout = ap_vp_nafc(varargin)
% AP_VP_NAFC M-file for ap_vp_nafc.fig
%      AP_VP_NAFC, by itself, creates a new AP_VP_NAFC or raises the existing
%      singleton*.
%
%      H = AP_VP_NAFC returns the handle to a new AP_VP_NAFC or the handle to
%      the existing singleton*.
%
%      AP_VP_NAFC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AP_VP_NAFC.M with the given input arguments.
%
%      AP_VP_NAFC('Property','Value',...) creates a new AP_VP_NAFC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ap_vp_nafc_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ap_vp_nafc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ap_vp_nafc

% Last Modified by GUIDE v2.5 11-Feb-2014 15:43:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ap_vp_nafc_OpeningFcn, ...
    'gui_OutputFcn',  @ap_vp_nafc_OutputFcn, ...
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


% --- Executes just before ap_vp_nafc is made visible.
function ap_vp_nafc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ap_vp_nafc (see VARARGIN)

% Choose default command line output for ap_vp_nafc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ap_vp_nafc wait for user response (see UIRESUME)
% uiwait(handles.fig_ap_vp_nafc);
movegui(hObject,'center')


% --- Outputs from this function are returned to the command line.
function varargout = ap_vp_nafc_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP TSP TSD
%
set(hObject,'Name',TSP.sections{PP.run_section_line,3})
set(handles.txt_short_instruction,'String',TSP.sections{PP.run_section_line,4}{1,3})
set(handles.txt_session,'String',['session: ' num2str(TSD{PP.run_number+1,3})]);
set(handles.txt_subject_id,'String',['subject: ' TSD{PP.run_number+1,2}]);

trackanzahl=size(PP.playlist,2);
if trackanzahl>0 %so lange also noch nicht-abgearbeitete Tracks vorhanden sind
    PP.chosen_track=PP.playlist(round(rand*(trackanzahl-1))+1); %einen Track aus allen noch vorhandenen zuf?llig ausw?hlen
    %!else kommt erst gaanz unten
    % setting parameter zum mehrfachen anh?ren der stimuli vor entscheidung
    multi_listening=TSP.sections{PP.run_section_line,4}{1,8}{1,3};
    %Anzahl der Intervalle beim nAFC
    n=TSP.sections{PP.run_section_line,4}{1,8}{1,1};
    abstand=450/n;
    for i=1:n
        x_position(i)=abstand*i-abstand/2+60;
        set(eval(['handles.pb_' num2str(i)]), 'Position',[x_position(i) 120 80 80]  ,'Visible','on')
        if multi_listening==1
            set(eval(['handles.pb_play' num2str(i)]), 'Position',[x_position(i)-10 230 100 100],'Visible','on')
        end
    end
    if multi_listening==1
        set(eval(['handles.pb_stop']), 'Position', [(x_position(1)+10) 340 ((x_position(n)-x_position(1)+80)-20) 39],'Visible','on')
    set(eval(['handles.pb_submit_choice']), 'Position', [(x_position(1)+100) 50 ((x_position(n)-x_position(1)+80)-200) 50],'Visible','on')

    end
    
    %Mechanismus feststellen 1=staircase, 2=PEST, 3x=ML/Bayes: 31=ZEST,
    %32=QUEST, 33=ML/Bayes manuell
    PP.chosen_track_type=TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{2,1};
    
    switch PP.chosen_track_type
        
        case 1 %staircase
            %falls erster stimulus des track -> init mit startwert
            if size(PP.ap_trackdata{PP.chosen_track,1})==0
                if (TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,2}{1,3}==0) %falls kein startwert zugewiesen, weil User die GUI gar nicht bedient hat, setze auf Max
                    TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,2}{1,3}=TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,1}(1,1); % initial level=range
                end
                PP.ap_trackdata{PP.chosen_track,1}=TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,2}{1,3};
            end
            
        case 2 %PEST
            %falls erster stimulus des track -> init mit startwert
            if size(PP.ap_trackdata{PP.chosen_track,1})==0
                if TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,3}{1,1}==0 %falls kein startwert zugewiesen, weil User die GUI gar nicht bedient hat, setze auf Max
                    TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,3}{1,1}=TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,1}(1,1); % initial level=range
                end
                if TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,3}{1,2}==-1 %falls kein initial stepsize vorhanden, weil User GUI nicht bedient hat
                    i=0;
                    while 2^i<TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,1}(1,1); % while<range
                        i=i+1;
                    end
                    stepsize_range_2pot=i-1; %gr??te enthaltene Zweierpotenz
                    TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,3}{1,2} = stepsize_range_2pot-1; %Setze initial stepsize
                end
                if TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,3}{1,8}==-1 %falls keine maximum stepsize vorhanden, weil User GUI nicht bedient hat
                    TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,3}{1,8} = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,3}{1,2};
                end
                PP.ap_trackdata{PP.chosen_track,1}=TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,3}{1,1};
            end
            
        case {31,32,33} %ML/Bayes
            %falls erster stimulus des track -> init mit startwert, dazu muss
            %in dem Fall die Funktion hier schon einmal aufgerufen werden
            if size(PP.ap_trackdata{PP.chosen_track,1})==0
                r_hist      = [];
                x_hist      = [];
                psyfunctype = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,15};
                range       = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,1}(1,1);
                beta        = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,1};
                lambda      = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,3};
                n_or_gamma  = TSP.sections{PP.run_section_line,4}{1,8}{1,1}; %hier n, da nAFC-Paradigma
                epsilon     = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,16};
                priortype   = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,5};
                mu          = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,6};
                sigma       = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,7};
                A           = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,18};
                B           = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,19};
                t           = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,20};
                C           = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,21};
                averagetype = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,8};
                exclude     = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,4};
                termtype    = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,10};
                if TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,9}==2
                    termtype=0; %wenn nach Konfidenz-Intervall terminiert wird
                end
                ConCoeff    = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,12};
                CI_max      = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,11};
                %Bayes-Funktion aufrufen
                [x_next, x_est, finalLike]=MLBayes(x_hist, r_hist, range, psyfunctype, beta, lambda, n_or_gamma, epsilon, priortype, mu, sigma, A, B, t, C, averagetype, exclude, termtype, ConCoeff, CI_max);
                %ersten Stimulus in hist schreiben
                PP.ap_trackdata{PP.chosen_track,1}=x_next;
            end
    end
    
    x_next=PP.ap_trackdata{PP.chosen_track,1}(numel(PP.ap_trackdata{PP.chosen_track,1})); %x_next ist immer das letzte Element der Track_hist
    target_id=TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,1}(x_next,2);
    ref_id=TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,1}(1,3);
    %Zuordnung von target und referenz(en) zu den Kn?pfen
    stim(1)=target_id;
    for i=2:n
        stim(i)=ref_id;
    end
    %bis jetzt war Target noch in stim(1), also Knopf A, nun mischen
    stim=stim(randperm(n));
    %jetzt wird neue Target-Position gesucht
    for i=1:n
        if stim(i)==target_id
            PP.ap_target_place=i;
        end
    end
    
    
    
    % Stimuli mehrfach abspielbar oder nur einmal in Folge abspielen
    
    if multi_listening==1
        PP.actual_1 = stim(1);
        PP.actual_2 = stim(2);
        if n>2
            PP.actual_3 = stim(3);
        end
        if n>3
            PP.actual_4 = stim(4);
        end
        %Pause vor dem ersten Simulus
        pause(str2num(TSP.sections{PP.run_section_line,4}{1,1}));
        %Abspielen
    end
    
    %Buttons enablen
    if multi_listening==1
        set(handles.pb_play1,'Enable', 'On');
        set(handles.pb_play2,'Enable', 'On');
        set(handles.pb_play3,'Enable', 'On');
        set(handles.pb_play4,'Enable', 'On');
        set(handles.pb_stop,'Enable', 'On');
        
        set(handles.pb_1,'Enable', 'Off');
        set(handles.pb_2,'Enable', 'Off');
        set(handles.pb_3,'Enable', 'Off');
        set(handles.pb_4,'Enable', 'Off');
        
        PP.played=[0 0 0 0];
        PP.submit=[];
    else
        
        for i=1:n
            set(eval(['handles.pb_' num2str(i)]), 'BackgroundColor', [1 0.4 0.4]);
            present_stimulus(stim(i));
            indexes = cat(1,TSP.stimuli{:,1});
            index = find(indexes==stim(i));
            idx=index;
            pause(str2num(TSP.stimuli{index,4})); %L?nge des Stimulus
            set(eval(['handles.pb_' num2str(i)]), 'BackgroundColor', [0.941 0.941 0.941])
            if i~=n %definierte Zwischen-Intervall-Pause, au?er nach dem letzten Intervall
                pause(TSP.sections{PP.run_section_line,4}{1,8}{1,2});
            end
        end
        
        set(handles.pb_1,'Enable', 'On');
        set(handles.pb_2,'Enable', 'On');
        set(handles.pb_3,'Enable', 'On');
        set(handles.pb_4,'Enable', 'On');
    end
    
    
    % Get default command line output from handles structure
    varargout{1} = handles.output;
    
else %wenn kein track mehr vorhanden, beende die section
    PP.allowed_to_close=1;
    close
    PP.allowed_to_close=0;
    %und gehe zur n?chsten
    PP.run_section_line=PP.run_section_line+1;
    vp_main
end


% --- Executes on button press in pb_1.
function pb_1_Callback(hObject, eventdata, handles)
% hObject    handle to pb_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
if TSP.sections{PP.run_section_line,4}{1,8}{1,3}==0 %ohne multiple listening
check_answer(1);
else
    set(hObject,'FontSize', 34);
    set(handles.pb_2,'FontSize', 16);
    set(handles.pb_3,'FontSize', 16);
    set(handles.pb_4,'FontSize', 16);
    set(handles.pb_submit_choice,'Enable', 'On');
    PP.submit=1;
end

% --- Executes on button press in pb_2.
function pb_2_Callback(hObject, eventdata, handles)
% hObject    handle to pb_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
if TSP.sections{PP.run_section_line,4}{1,8}{1,3}==0 %ohne multiple listening
check_answer(2);
else
    set(hObject,'FontSize', 34);
    set(handles.pb_1,'FontSize', 16);
    set(handles.pb_3,'FontSize', 16);
    set(handles.pb_4,'FontSize', 16);
    set(handles.pb_submit_choice,'Enable', 'On');
    PP.submit=2;
end
% --- Executes on button press in pb_3.
function pb_3_Callback(hObject, eventdata, handles)
% hObject    handle to pb_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
if TSP.sections{PP.run_section_line,4}{1,8}{1,3}==0 %ohne multiple listening
check_answer(3);
else
    set(hObject,'FontSize', 34);
    set(handles.pb_1,'FontSize', 16);
    set(handles.pb_2,'FontSize', 16);
    set(handles.pb_4,'FontSize', 16);
    set(handles.pb_submit_choice,'Enable', 'On');
    PP.submit=3;
end
% --- Executes on button press in pb_4.
function pb_4_Callback(hObject, eventdata, handles)
% hObject    handle to pb_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
if TSP.sections{PP.run_section_line,4}{1,8}{1,3}==0 %ohne multiple listening
check_answer(4);
else
    set(hObject,'FontSize', 34);
    set(handles.pb_1,'FontSize', 16);
    set(handles.pb_2,'FontSize', 16);
    set(handles.pb_3,'FontSize', 16);
    set(handles.pb_submit_choice,'Enable', 'On');
    PP.submit=4;
end


function check_answer(answer)
%?berpr?ft ob antwort korrekt ist und unternimmt alle weiteren Schritte die
%Anntwort wird als Int ?bergeben: 1 f?r A, 2 f?r B, ...
global PP TSP TSD PS
if PP.ap_target_place==answer %wenn target erkannt/gefunden/geraten
    PP.ap_trackdata{PP.chosen_track,2}(1,(numel(PP.ap_trackdata{PP.chosen_track,1})))=1; %Antwort zum Run positiv
else %wenn nicht gefunden
    PP.ap_trackdata{PP.chosen_track,2}(1,(numel(PP.ap_trackdata{PP.chosen_track,1})))=-1;
end

sec_term=0;
x_hist=PP.ap_trackdata{PP.chosen_track,1};
r_hist=PP.ap_trackdata{PP.chosen_track,2};
range =TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,1}(1,1);
switch PP.chosen_track_type
    case 1 %staircase
        nrmax =TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,2}{1,5};
        halvings=TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,2}{1,2};
        numlastr=TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,2}{1,7};
        %staircase-Funktion abh?ngig von der Adaptionsregel aufrufen
        switch TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,2}{1,4}
            case 1
                [x_next, x_est]=staircase1d1u(x_hist, r_hist, range, nrmax, halvings, numlastr);
            case 2
                [x_next, x_est]=staircase2d1u(x_hist, r_hist, range, nrmax, halvings, numlastr);
            case 3
                [x_next, x_est]=staircase3d1u(x_hist, r_hist, range, nrmax, halvings, numlastr);
        end
        %sekund?res abbruchkriterium pr?fen
        if length(PP.ap_trackdata{PP.chosen_track,2})==TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,2}{1,6} && TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,2}{1,8}==1
            sec_term=1;
        end
    case 2 %PEST
        dx_ini =2^TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,3}{1,2};
        dx_max=2^TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,3}{1,8};
        P_t=TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,3}{1,6};
        W=TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,3}{1,4};
        M=TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,3}{1,5};
        %staircase-Funktion abh?ngig von der Adaptionsregel aufrufen
        switch TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,3}{1,3}
            case 1
                [x_next, x_est]=PEST(x_hist, r_hist, range, dx_ini, dx_max, P_t, W);
            case 2
                [x_next, x_est]=mvPEST(x_hist, r_hist, range, dx_ini, dx_max, P_t, M);
        end
        %sekund?res abbruchkriterium pr?fen
        if length(PP.ap_trackdata{PP.chosen_track,2})==TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,3}{1,7} && TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,3}{1,9}==1
            sec_term=1;
        end
    case {31,32,33} %ML/Bayes
        psyfunctype = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,15};
        beta        = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,1};
        lambda      = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,3};
        n_or_gamma  = TSP.sections{PP.run_section_line,4}{1,8}{1,1}; %hier n, da nAFC-Paradigma
        epsilon     = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,16};
        priortype   = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,5};
        mu          = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,6};
        sigma       = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,7};
        A           = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,18};
        B           = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,19};
        t           = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,20};
        C           = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,21};
        averagetype = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,8};
        exclude     = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,4};
        termtype    = TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,10};
        if TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,9}==2
            termtype=0; %wenn nach Konfidenz-Intervall terminiert wird
        end
        ConCoeff=TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,12};
        CI_max=TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,11};
        %Bayes-Funktion aufrufen
        [x_next, x_est, finalLike]=MLBayes(x_hist, r_hist, range, psyfunctype, beta, lambda, n_or_gamma, epsilon, priortype, mu, sigma, A, B, t, C, averagetype, exclude, termtype, ConCoeff, CI_max);
        %sekund?res abbruchkriterium pr?fen
        if length(PP.ap_trackdata{PP.chosen_track,2})==TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,14} && TSP.sections{PP.run_section_line,4}{PP.chosen_track,7}{1,4}{1,13}==1
            sec_term=1;
        end
end

if x_est~=0 || sec_term==1 %wenn Ergebnis vorliegt oder secondary termination greift
    %noch letzten vorgeschlagenen Stimulus abspeichern, der aber nicht mehr
    %beantwortet wurde
    PP.ap_trackdata{PP.chosen_track,1}(1,(numel(PP.ap_trackdata{PP.chosen_track,1}))+1)=x_next;
    %?berschrift in TSD schreiben
    TSD{1,3+PP.run_section_line}{1,PP.chosen_track}{1,1}=['thresh_track' num2str(PP.chosen_track)];
    %Threshold in TSD schreiben
    TSD{PP.run_number+1,3+PP.run_section_line}{1,PP.chosen_track}{1,1}=num2str(x_est);
    
    %plotting
    Ntrials=length(PP.ap_trackdata{PP.chosen_track,1});
    trial_pos = find(r_hist+1);
    x_pos = PP.ap_trackdata{PP.chosen_track,1}(trial_pos); % zugeh?rige Reizst?rkenwerte
    trial_neg = find(1-r_hist);
    x_neg = PP.ap_trackdata{PP.chosen_track,1}(trial_neg);
    
    h=figure(2);
    set(h,'Visible','Off');
    plot(1:Ntrials, PP.ap_trackdata{PP.chosen_track,1}, '-', 'Color', 'k', 'LineWidth', 1.25);
    
    subject_id=TSD{PP.run_number+1,2};
    session=TSD{PP.run_number+1,3};
    title_text=['run: ' num2str(PP.run_number) ', subject ID: ', subject_id, ', session: ', session, ', section: ', num2str(PP.run_section_line), ', track: ' num2str(PP.chosen_track)];
    title(title_text);
    hold on
    posh = plot(trial_pos, x_pos, 'square', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k');
    negh = plot(trial_neg, x_neg, 'o', 'MarkerEdgeColor', 'k');
    axis ([0 (Ntrials) 1 range]);
    set(gca,'XTick',0:1:Ntrials)
    xlabel('Trial Number');
    ylabel('Stimulus Level');
    grid on
    
    h2=legend( [posh, negh], 'positive response', 'negative resonse', 'Location','NorthEast');
    legend('boxon');
    set(h2, 'FontSize', 10);
    hold off
    
    set(h, 'Units', 'normalized', 'Position', [0.1 0.5 0.8 0.4]);
    text(Ntrials*0.4, -0.4*range, ['Threshold Estimate: ', num2str(x_est)]);
    
    %Dateiname (ohne Endung) generieren
    filename=[PP.path filesep 'plots' filesep 'run' num2str(PP.run_number) '_subjectID', subject_id, '_session', session, '_section', num2str(PP.run_section_line), '_track' num2str(PP.chosen_track)];
    %abh?ngig von Einstellung Plot in gew?nschten Formaten speichern
    if PS.plotting{1,1}(1,4)==1 %pdf
        print('-f2', '-dpdf', filename);
    end
    if PS.plotting{1,1}(1,3)==1 %png
        print('-f2', '-dpng', filename);
    end
    if PS.plotting{1,1}(1,2)==1 %eps
        print('-f2', '-deps', filename);
    end
    if PS.plotting{1,1}(1,1)==1 %fig
        set(h,'Visible','On');
        saveas(h,[filename '.fig']);
        set(h,'Visible','Off');
    end
    %track aus playlist l?schen
    for i=1:numel(PP.playlist)
        if PP.chosen_track==PP.playlist(i)
            track_to_delete=i;
        end
    end
    PP.playlist(track_to_delete)=[];
    save ([PP.path filesep 'TSD'],'TSD');
    save_export_file(PP.run_section_line)
else
    PP.ap_trackdata{PP.chosen_track,1}(1,(numel(PP.ap_trackdata{PP.chosen_track,1}))+1)=x_next;
end
PP.allowed_to_close=1;
close
PP.allowed_to_close=0;
ap_vp_nafc


% --- Executes on button press in playA.
function pb_play1_Callback(hObject, eventdata, handles)
% hObject    handle to playA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP TSP
set(eval(['handles.pb_' num2str(1)]), 'BackgroundColor', [1 0.4 0.4]);
set(eval(['handles.pb_' num2str(2)]), 'BackgroundColor', [0.941 0.941 0.941]);
set(eval(['handles.pb_' num2str(3)]), 'BackgroundColor', [0.941 0.941 0.941]);
set(eval(['handles.pb_' num2str(4)]), 'BackgroundColor', [0.941 0.941 0.941]);
present_stimulus(PP.actual_1);
PP.played(1)=1;

if sum(PP.played)/TSP.sections{PP.run_section_line,4}{1,8}{1,1}==1
    set(handles.pb_1,'Enable', 'On');
    set(handles.pb_2,'Enable', 'On');
    set(handles.pb_3,'Enable', 'On');
    set(handles.pb_4,'Enable', 'On');
end

% --- Executes on button press in playB.
function pb_play2_Callback(hObject, eventdata, handles)
% hObject    handle to playB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP TSP
set(eval(['handles.pb_' num2str(1)]), 'BackgroundColor', [0.941 0.941 0.941]);
set(eval(['handles.pb_' num2str(2)]), 'BackgroundColor', [1 0.4 0.4]);
set(eval(['handles.pb_' num2str(3)]), 'BackgroundColor', [0.941 0.941 0.941]);
set(eval(['handles.pb_' num2str(4)]), 'BackgroundColor', [0.941 0.941 0.941]);
present_stimulus(PP.actual_2);
PP.played(2)=1;

if sum(PP.played)/TSP.sections{PP.run_section_line,4}{1,8}{1,1}==1
    set(handles.pb_1,'Enable', 'On');
    set(handles.pb_2,'Enable', 'On');
    set(handles.pb_3,'Enable', 'On');
    set(handles.pb_4,'Enable', 'On');
end
% --- Executes on button press in playC.
function pb_play3_Callback(hObject, eventdata, handles)
% hObject    handle to playC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP TSP
set(eval(['handles.pb_' num2str(1)]), 'BackgroundColor', [0.941 0.941 0.941]);
set(eval(['handles.pb_' num2str(2)]), 'BackgroundColor', [0.941 0.941 0.941]);
set(eval(['handles.pb_' num2str(3)]), 'BackgroundColor', [1 0.4 0.4]);
set(eval(['handles.pb_' num2str(4)]), 'BackgroundColor', [0.941 0.941 0.941]);
present_stimulus(PP.actual_3);
PP.played(3)=1;

if sum(PP.played)/TSP.sections{PP.run_section_line,4}{1,8}{1,1}==1
    set(handles.pb_1,'Enable', 'On');
    set(handles.pb_2,'Enable', 'On');
    set(handles.pb_3,'Enable', 'On');
    set(handles.pb_4,'Enable', 'On');
end
% --- Executes on button press in playD.
function pb_play4_Callback(hObject, eventdata, handles)
% hObject    handle to playD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP TSP
set(eval(['handles.pb_' num2str(1)]), 'BackgroundColor', [0.941 0.941 0.941]);
set(eval(['handles.pb_' num2str(2)]), 'BackgroundColor', [0.941 0.941 0.941]);
set(eval(['handles.pb_' num2str(3)]), 'BackgroundColor', [0.941 0.941 0.941]);
set(eval(['handles.pb_' num2str(4)]), 'BackgroundColor', [1 0.4 0.4]);
present_stimulus(PP.actual_4);
PP.played(4)=1;

if sum(PP.played)/TSP.sections{PP.run_section_line,4}{1,8}{1,1}==1
    set(handles.pb_1,'Enable', 'On');
    set(handles.pb_2,'Enable', 'On');
    set(handles.pb_3,'Enable', 'On');
    set(handles.pb_4,'Enable', 'On');
end
% --- Executes on button press in pb_stop.
function pb_stop_Callback(hObject, eventdata, handles)
% hObject    handle to pb_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player PP TSP PS
set(eval(['handles.pb_' num2str(1)]), 'BackgroundColor', [0.941 0.941 0.941]);
set(eval(['handles.pb_' num2str(2)]), 'BackgroundColor', [0.941 0.941 0.941]);
set(eval(['handles.pb_' num2str(3)]), 'BackgroundColor', [0.941 0.941 0.941]);
set(eval(['handles.pb_' num2str(4)]), 'BackgroundColor', [0.941 0.941 0.941]);

if ~isempty(player) %wenn Simulus wave enth?lt...
    stop(player);
end

for i=1:6
    if ~isempty(PS.network{1,1}{i,1})
        host     = PS.network{1,1}{i,1};
        port     = str2num(PS.network{1,1}{i,2});
        osc_path = '/stop';
        type     = 'i';
        data     = 0;
        %start changes alex:
        clc % echoing
        %struct( 'path', osc_path, 'type', type, 'data', data )
        
        u = udp(host, port);
        fopen(u);
        oscsend(u,osc_path,type,data);
        fclose(u);
        %end changes alex        
    end
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
    set(hObject,'BackgroundColor','grey');
end


% --- Executes when user attempts to close fig_ap_vp_nafc.
function fig_ap_vp_nafc_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_ap_vp_nafc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
if PP.allowed_to_close==1
    delete(hObject);
end


% --- Executes on button press in pb_submit_choice.
function pb_submit_choice_Callback(hObject, eventdata, handles)
% hObject    handle to pb_submit_choice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player PP PS
if ~isempty(player) %wenn Simulus wave enth?lt...
    stop(player);
end


for i=1:6
    if ~isempty(PS.network{1,1}{i,1})
        host     = PS.network{1,1}{i,1};
        port     = str2num(PS.network{1,1}{i,2});
        osc_path = '/stop';
        type     = 'i';
        data     = 0;
        %start changes alex:
        clc % echoing
        %struct( 'path', osc_path, 'type', type, 'data', data )
        
        u = udp(host, port);
        fopen(u);
        oscsend(u,osc_path,type,data);
        fclose(u);
        %end changes alex        
    end
end

check_answer(PP.submit);


% --- Executes during object creation, after setting all properties.
function pb_play1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pb_play1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
