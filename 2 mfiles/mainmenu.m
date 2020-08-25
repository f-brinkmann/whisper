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
% Date   :   15-Nov-2008
% Known Bugs: It it not possible, to perform two a/b/x trials successively,
%             without loosing the results from the former trial.
%             Problem is caused by faulty programming of saving the 
%             the results in the TSP.mat. See abx_vp.m line 246ff. 
% Changed:   28-May-1010, M.Herder ( nenehsjj AT mailbox DOT tu-berlin DOT de),
%             added checking for different default presetfiles to load.
%
% =========================================================================


function varargout = mainmenu(varargin)
% MAINMENU M-file for mainmenu.fig
%      MAINMENU, by itself, creates a new MAINMENU or raises the existing
%      singleton*.
%
%      H = MAINMENU returns the handle to a new MAINMENU or the handle to
%      the existing singleton*.
%
%      MAINMENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINMENU.M with the given input arguments.
%
%      MAINMENU('Property','Value',...) creates a new MAINMENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainmenu_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainmenu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to men_question_mark mainmenu

% Last Modified by GUIDE v2.5 14-Jul-2014 12:40:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainmenu_OpeningFcn, ...
                   'gui_OutputFcn',  @mainmenu_OutputFcn, ...
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


% --- Executes just before mainmenu is made visible.
function mainmenu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainmenu (see VARARGIN)

% Choose default command line output for mainmenu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mainmenu wait for user response (see UIRESUME)
% uiwait(handles.fig_mainmenu);

movegui(hObject,'center')
global TSP TSD PC PP PS

load 'PS.mat'

% Laden der PC.mat, und zwar entsprechend der gespeicherten Presetnummer
if PS.selected_preset == 0
    load 'PC.mat'; % disp('Loaded PC.mat')
else
    try 
        load(['PC.' num2str(PS.selected_preset) '.mat']); %disp(['Loaded PC.' num2str(PS.selected_preset) '.mat'])
    catch exception
        PP.whisper_message = ['Previously selected presetfile PC.' num2str(PS.selected_preset) '.mat seems to be missing.Loading default PC.mat.'];
        whisper_message
        pause(3)
        load('PC.mat'); % disp('Loaded PC.mat.')
        PS.selected_preset = 0;
        save('PS.mat','PS');
    end
end

PP.dontopenparent=0; %Init...

%wenn ein Projekt geladen ist, werden alle Funktionen freigeschaltet, die
%nur bei geladenem Projekt Sinn machen
if isfield(TSP,'name')==1
    set(handles.txt_testseries_name,'String',TSP.name);
    set(handles.pb_edit_test_sections,'Enable', 'on');
    set(handles.pb_session_setup,'Enable', 'on');
    set(handles.pb_stimulus_pool,'Enable', 'on');
    set(handles.men_test_sections,'Enable', 'on');
    set(handles.men_session_setup,'Enable', 'on');
    set(handles.men_stimulus_pool,'Enable', 'on');
    if isempty(TSP.sections)==0 %zustzlich Sinn machend, wenn Verfahren angelegt
        set(handles.pb_start_run,'Enable', 'on');
        set(handles.ed_subject_id,'Enable', 'on');
        %session-Box
        for i=1:TSP.number_of_sessions
            sessions_list{i+1}=num2str(i);
        end
        set(handles.pop_session,'String',sessions_list);
        set(handles.pop_session,'Enable', 'on');
        nextrun=size(TSD,1);
        lastrun=nextrun-1;
        if nextrun==0
            nextrun=1;
            lastrun='';
        end
        if nextrun>1
            set(handles.men_empirical_data,'Enable','On');
            set(handles.men_export_empirical_data,'Enable','On');
            set(handles.pb_stimulus_pool,'Enable','Off');
            set(handles.pb_session_setup,'Enable','Off');
            set(handles.pb_edit_test_sections,'Enable','Off');
        else
            set(handles.men_empirical_data,'Enable','Off');
            set(handles.men_export_empirical_data,'Enable','Off');
            set(handles.pb_stimulus_pool,'Enable','On');
            set(handles.pb_session_setup,'Enable','On');
            set(handles.pb_edit_test_sections,'Enable','On');
        end
        set(handles.ed_run_01,'String', nextrun);
        set(handles.ed_run_02,'String', lastrun);
    end
end


% --- Outputs from this function are returned to the command line.
function varargout = mainmenu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP
if isfield(TSP,'name')==1
    save_testseries_info
end
% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function men_open_Callback(hObject, eventdata, handles)

% hObject    handle to men_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% open_test_series-GUI aufrufen, mainmenu bleibt offen
  open_test_series
  
  
% --------------------------------------------------------------------
function men_test_series_Callback(hObject, eventdata, handles)
% hObject    handle to men_test_series (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_edit_test_sections.
function pb_edit_test_sections_Callback(hObject, eventdata, handles)
 
% hObject    handle to pb_edit_test_sections (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 close
 edit_procedures


% --------------------------------------------------------------------
function men_duplicate_Callback(hObject, eventdata, handles)
% hObject    handle to men_duplicate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function men_exit_programm_Callback(hObject, eventdata, handles)
% hObject    handle to men_exit_programm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close

% --------------------------------------------------------------------
function men_new_Callback(hObject, eventdata, handles)
  
% hObject    handle to men_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% GUI fr neue Testreihe ffnen, main menu bleibt offen
new_test_series

% --------------------------------------------------------------------
function men_program_setup_Callback(hObject, eventdata, handles)
% hObject    handle to men_program_setup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function men_audio_Callback(hObject, eventdata, handles)
% hObject    handle to men_audio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function men_edit_Callback(hObject, eventdata, handles)
% hObject    handle to men_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function men_stimulus_pool_Callback(hObject, eventdata, handles)
  
% hObject    handle to Stimuli_men_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  close 
  edit_stimulus_pool
  
% --------------------------------------------------------------------
function men_test_sections_Callback(hObject, eventdata, handles)
  
% hObject    handle to Testverfahren_men_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  close
  edit_procedures
  
% --------------------------------------------------------------------
function men_question_mark_Callback(hObject, eventdata, handles)
% hObject    handle to men_question_mark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function men_help_Callback(hObject, eventdata, handles)
% hObject    handle to men_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP
if exist (['whisper-userdoc.pdf'])
        open(['whisper-userdoc.pdf']);
elseif exist (['..\3 doc' filesep 'whisper-userdoc.pdf'])
        open(['..\3 doc' filesep 'whisper-userdoc.pdf']);
elseif exist (['..\3 doc' filesep 'user_documentation' filesep 'whisper-userdoc.pdf'])
        open(['..\3 doc' filesep 'user_documentation' filesep 'whisper-userdoc.pdf']);
else
    PP.whisper_message='File "whisper-userdoc.pdf" was not found!';
    whisper_message
end

% --------------------------------------------------------------------
function men_about_Callback(hObject, eventdata, handles)
% hObject    handle to men_about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

show_about


% --- Executes on button press in pb_stimulus_pool.
function pb_stimulus_pool_Callback(hObject, eventdata, handles)
  
% hObject    handle to pb_stimulus_pool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  close
  edit_stimulus_pool
  
  
% --- Executes on button press in pb_start_run.
function pb_start_run_Callback(hObject, eventdata, handles)
% hObject    handle to pb_start_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP TSD PC TSP

subject_id = get(handles.ed_subject_id,'String');
session    = get(handles.pop_session,'Value')-1;
if isempty(subject_id)==0 && session>0
    PP.run_number = str2num(get(handles.ed_run_01,'String'));
    %in TSD wird immer zeile+1 als index benutzt, da in der ersten ziele die
    %Spaltenberschriften stehen
    TSD{PP.run_number+1,1}=PP.run_number;
    TSD{PP.run_number+1,2}=subject_id;
    TSD{PP.run_number+1,3}=num2str(session);
    %berschriftennamen fr die allgemeinen Sachen
    TSD{1,1}='run';
    TSD{1,2}='subject';
    TSD{1,3}='session';
    
    PP.run_section_line=1;
    close
    vp_main
end


% --- Executes on button press in pb_view_data.
function pb_view_data_Callback(hObject, eventdata, handles)
% hObject    handle to pb_view_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function men_network_Callback(hObject, eventdata, handles)
% hObject    handle to men_network (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
setup_network


% --------------------------------------------------------------------
function men_empirical_data_Callback(hObject, eventdata, handles)
% hObject    handle to men_empirical_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  
  edit_empirical_data

  
% --------------------------------------------------------------------
function men_export_format_Callback(hObject, eventdata, handles)
% hObject    handle to men_export_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function men_export_empirical_data_Callback(hObject, eventdata, handles)
% hObject    handle to men_export_empirical_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP

%XML/GRD:
save_GridExport
    
%CSV:
for i=1:length(TSP.sections(:,1))
    save_export_file(i);
end


function ed_subject_id_Callback(hObject, eventdata, handles)
% hObject    handle to ed_subject_id (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_subject_id as text
%        str2double(get(hObject,'String')) returns contents of ed_subject_id as a double


% --- Executes during object creation, after setting all properties.
function ed_subject_id_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_subject_id (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_session_Callback(hObject, eventdata, handles)
% hObject    handle to ed_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_session as text
%        str2double(get(hObject,'String')) returns contents of ed_session as a double


% --- Executes during object creation, after setting all properties.
function ed_session_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_run_01_Callback(hObject, eventdata, handles)
% hObject    handle to ed_run_01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_run_01 as text
%        str2double(get(hObject,'String')) returns contents of ed_run_01 as a double


% --- Executes during object creation, after setting all properties.
function ed_run_01_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_run_01 (see GCBO)
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

  close
  edit_sections
  

% --------------------------------------------------------------------
function men_new_from_format_Callback(hObject, eventdata, handles)
  
% hObject    handle to men_new_from_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close
new_test_series_format


function ed_run_02_Callback(hObject, eventdata, handles)
% hObject    handle to ed_run_02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_run_02 as text
%        str2double(get(hObject,'String')) returns contents of ed_run_02 as a double


% --- Executes during object creation, after setting all properties.
function ed_run_02_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_run_02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function men_session_setup_Callback(hObject, eventdata, handles)
% hObject    handle to men_session_setup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close
setup_sessions


% --- Executes on button press in pb_session_setup.
function pb_session_setup_Callback(hObject, eventdata, handles)
% hObject    handle to pb_session_setup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close
setup_sessions


% --- Executes when user attempts to close fig_mainmenu.
function fig_mainmenu_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_mainmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --------------------------------------------------------------------
function men_close_Callback(hObject, eventdata, handles)
% hObject    handle to men_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close all
clear global TSP TSD PP
mainmenu


% --------------------------------------------------------------------
function men_plotting_Callback(hObject, eventdata, handles)
% hObject    handle to men_plotting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close
setup_plotting


% --- Executes on selection change in pop_session.
function pop_session_Callback(hObject, eventdata, handles)
% hObject    handle to pop_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_session contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_session


% --- Executes during object creation, after setting all properties.
function pop_session_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function men_conf_proc_defaults_Callback(hObject, eventdata, handles)
% hObject    handle to men_conf_proc_defaults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

configure_procedures_defaults
