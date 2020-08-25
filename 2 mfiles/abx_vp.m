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
% Author :   Andreas Rotter, student at FG Audiokommunikation, TU Berlin
% Email  :   andreas.rotter.kontakt AT googlemail DOT com
% Date   :   18-Sep-2009
% Updated:
% Known Bugs: It it not possible, to perform two a/b/x trials successively,
%             without loosing the results from the former trial.
%             Problem is caused by faulty programming of saving the 
%             the results in the TSP.mat. See abx_vp.m line 246ff. 
% =========================================================================


function varargout = abx_vp(varargin)
% ABX_VP M-file for abx_vp.fig
%      ABX_VP, by itself, creates a new ABX_VP or raises the existing
%      singleton*.
%
%      H = ABX_VP returns the handle to a new ABX_VP or the handle to
%      the existing singleton*.
%
%      ABX_VP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ABX_VP.M with the given input arguments.
%
%      ABX_VP('Property','Value',...) creates a new ABX_VP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before abx_vp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to abx_vp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help abx_vp

% Last Modified by GUIDE v2.5 25-Feb-2015 11:25:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @abx_vp_OpeningFcn, ...
                   'gui_OutputFcn',  @abx_vp_OutputFcn, ...
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


% --- Executes just before abx_vp is made visible.
function abx_vp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to abx_vp (see VARARGIN)

% Choose default command line output for abx_vp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Center GUI
movegui(hObject,'center');

% UIWAIT makes abx_vp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = abx_vp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP TSP TSD

set(hObject,'Name',TSP.sections{PP.run_section_line,3})
set(handles.txt_short_instruction,'String',TSP.sections{PP.run_section_line,4}{1,3})
set(handles.txt_session,'String',['session: ' num2str(TSD{PP.run_number+1,3})]);
set(handles.txt_subject_id,'String',['subject: ' TSD{PP.run_number+1,2}]);

PP.trialcount=size(PP.playlist,1);

%set(handles.txt_stimuli,'String',['stimuli to go: ' size(PP.playlist,1)]);

PP.stimuli_eins_id=TSP.sections{PP.run_section_line,4}{1,5}(1,1);
PP.stimuli_zwei_id=TSP.sections{PP.run_section_line,4}{1,5}(1,2);


    % Solange noch Reihenfolgen in der Playlist gespeichert sind
    if PP.trialcount > 0

        PP.trialcount;   
        %Kombination aus der Playlist laden
            
        PP.current_plays=PP.playlist(PP.trialcount,:);
        % current_osc_stimuli=PP.playlist_osc_stimuli(PP.trialcount);
        %if isempty(TSP.stimuli{1,3}) 
        %  PP.curr_osc_message=struct( 'path', PP.oscpath, 'tt', PP.oscdatatype, 'data', { PP.playlist_osc_stimuli(PP.trialcount) } );
        %end
 
        % und unter den Playbutton verteilen
        if PP.current_plays(1,1) == 1
            PP.actual_a = PP.stimuli_eins_id;
            PP.actual_b = PP.stimuli_zwei_id;
            temp=randperm(2);
            if temp(1,1) == 1
                PP.actual_x = PP.stimuli_eins_id;
            else
                PP.actual_x = PP.stimuli_zwei_id;
            end
        else
            PP.actual_a = PP.stimuli_zwei_id;
            PP.actual_b = PP.stimuli_eins_id;
            temp=randperm(2);
            if temp(1,1) == 1
                PP.actual_x = PP.stimuli_eins_id;
            else
                PP.actual_x = PP.stimuli_zwei_id;
            end
        end
        
        %Buttons anschalten
        set(handles.pb_play_a,'Enable', 'On');
        set(handles.pb_play_b,'Enable', 'On');
        set(handles.pb_play_x,'Enable', 'On');
        set(handles.pb_stop,'Enable', 'On');
        set(handles.pb_answer_a,'Enable', 'Off');
        set(handles.pb_answer_b,'Enable', 'Off');
        PP.played_A=0;
        PP.played_B=0;
        PP.played_X=0;
        
        set(handles.pb_weiter,'Enable', 'Off');

        %PP.counter=PP.counter+1;
        % Get default command line output from handles structure
        varargout{1} = handles.output;

    else
        PP.allowed_to_close=1;
        close
        PP.allowed_to_close=0;
        PP.run_section_line=PP.run_section_line+1;
        vp_main
    end
    

% --- Executes on button press in pb_play_a.
function pb_play_a_Callback(hObject, eventdata, handles)
% hObject    handle to pb_play_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP
PP.played_A=1;
present_stimulus(PP.actual_a);
if PP.random_stimuli == 1 && PP.stop == 1
    %osc_send( PP.osc_address, PP.curr_osc_message);
    PP.stop=0; PP.play = 1;
    %osc_free_address(PP.osc_address);
end

if PP.played_A == 1 && PP.played_B == 1 && PP.played_X == 1
    set(handles.pb_answer_a,'Enable', 'On');
    set(handles.pb_answer_b,'Enable', 'On');
end

% --- Executes on button press in pb_play_b.
function pb_play_b_Callback(hObject, eventdata, handles)
% hObject    handle to pb_play_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP
PP.played_B=1;
present_stimulus(PP.actual_b);
if PP.random_stimuli == 1 && PP.stop == 1
    %osc_send( PP.osc_address, PP.curr_osc_message);
    PP.stop=0; PP.play = 1;
    %osc_free_address(PP.osc_address);
end

if PP.played_A == 1 && PP.played_B == 1 && PP.played_X == 1
    set(handles.pb_answer_a,'Enable', 'On');
    set(handles.pb_answer_b,'Enable', 'On');
end

% --- Executes on button press in pb_play_x.
function pb_play_x_Callback(hObject, eventdata, handles)
% hObject    handle to pb_play_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP
present_stimulus(PP.actual_x);
PP.played_X=1;
if PP.random_stimuli == 1 && PP.stop == 1
    %osc_send( PP.osc_address, PP.curr_osc_message);
    PP.stop=0; PP.play = 1;
    %osc_free_address(PP.osc_address);
end

if PP.played_A == 1 && PP.played_B == 1 && PP.played_X == 1
    set(handles.pb_answer_a,'Enable', 'On');
    set(handles.pb_answer_b,'Enable', 'On');
end

% --- Executes on button press in pb_stop.
function pb_stop_Callback(hObject, eventdata, handles)
% hObject    handle to pb_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player PP
%if PP.random_stimuli == 0 
%    stop(player);

if ~isempty(player)
    stop(player);
else
    PP.stop = 1;
    PP.play = 0;    
end

% global PP 
% for n = 1:numel(PP.u)
% 	fopen(PP.u{n});
% 	oscsend(PP.u{n},PP.osc_stop_path,PP.osc_stop_type,PP.osc_stop_data);
%  	fclose(PP.u{n});
% end



% --- Executes on button press in pb_answer_a.
function pb_answer_a_Callback(hObject, eventdata, handles)
% hObject    handle to pb_answer_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
check_answer(1);
set(handles.pb_weiter,'Enable', 'On');


% --- Executes on button press in pb_answer_b.
function pb_answer_b_Callback(hObject, eventdata, handles)
% hObject    handle to pb_answer_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
check_answer(2);
set(handles.pb_weiter,'Enable', 'On');



function check_answer(id)

global PP TSP TSD PS
    
    if id == 1 && PP.actual_a == PP.actual_x
        PP.abx_trackdata{PP.trialcount}=1;
    elseif id == 2 && PP.actual_x == PP.actual_b
        PP.abx_trackdata{PP.trialcount}=1;    
    else
        PP.abx_trackdata{PP.trialcount}=-1;
    end
    
    
    
    if PP.trialcount == 1
             
       %Ueberschrift in TSD schreiben
       TSD{1,3+PP.run_section_line}{1,1}={(['correct answers ' TSP.sections{PP.run_section_line,3}])};
       
       %Entscheidungen auszaehlen 
       decisions=cell2mat(PP.abx_trackdata);
       if size(decisions,1) > size(decisions,2)
           decisions=rot90(decisions);
       end
       correct=find(decisions > 0);
       numcorr=size(correct,2);
       
       %Entscheidungen auszaehlen und in TSD schreibe
       TSD{PP.run_number+1,3+PP.run_section_line}{1,1}={numcorr};
       % Number of trials
       save ([PP.path filesep 'TSD'],'TSD'); 
    end
    
    
    
% --- Executes when user attempts to close fig_abx_vp.
function fig_abx_vp_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_abx_vp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
if PP.allowed_to_close==1
    delete(hObject);
end


% --- Executes on button press in pb_weiter.
function pb_weiter_Callback(hObject, eventdata, handles)
% hObject    handle to pb_weiter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP player

if PP.random_stimuli == 0
    if ~isempty(player)
        stop(player);
    end
else
   %osc_send( PP.osc_address, PP.osc_stop );
end

actualsize=size(PP.playlist,1);
% Streichen der zuletzt verwendeten Playlist
PP.playlist(actualsize,:)=[];
PP.counter=PP.counter+1;
PP.stop=1;
PP.play=0;

PP.allowed_to_close=1;
close
PP.allowed_to_close=0;
abx_vp


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hint: delete(hObject) closes the figure
global PP
if PP.allowed_to_close==1
    delete(hObject);
end


% --- Executes during object creation, after setting all properties.
function txt_short_instruction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_short_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
