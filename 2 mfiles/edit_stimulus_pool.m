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
% Author :   Andr? Wlodarski, student at FG Audiokommunikation, TU Berlin
% Email  :   awlodarski AT gmx DOT de
% Date   :   15-Nov-2008
%
% =========================================================================


function varargout = edit_stimulus_pool(varargin)
% EDIT_STIMULUS_POOL M-file for edit_stimulus_pool.fig
%      EDIT_STIMULUS_POOL, by itself, creates a new EDIT_STIMULUS_POOL or raises the existing
%      singleton*.
%
%      H = EDIT_STIMULUS_POOL returns the handle to a new EDIT_STIMULUS_POOL or the handle to
%      the existing singleton*.
%
%      EDIT_STIMULUS_POOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDIT_STIMULUS_POOL.M with the given input arguments.
%
%      EDIT_STIMULUS_POOL('Property','Value',...) creates a new EDIT_STIMULUS_POOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before edit_stimulus_pool_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to edit_stimulus_pool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help edit_stimulus_pool

% Last Modified by GUIDE v2.5 21-May-2010 18:13:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @edit_stimulus_pool_OpeningFcn, ...
                   'gui_OutputFcn',  @edit_stimulus_pool_OutputFcn, ...
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


% --- Executes just before edit_stimulus_pool is made visible.
function edit_stimulus_pool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to edit_stimulus_pool (see VARARGIN)

% Choose default command line output for edit_stimulus_pool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes edit_stimulus_pool wait for user response (see UIRESUME)
% uiwait(handles.fig_edit_stimulus_pool);

movegui(hObject,'center')
global TSP PP
load ([PP.path filesep 'TSP.mat']);
set(handles.txt_testseries_name,'String',TSP.name);
if isfield(PP,'edit_stimulus_line')==0
    PP.edit_stimulus_line=1;
end
fill_list(handles); %Funktion zum F?llen/Aktualisieren der Stimulus-Liste aufrufen (befindet sich ebenfalls in dieser m-Datei)


function fill_list(handles)
% Inhalt der Liste lb_stimuli wird generiert.
% Mit Hilfe der Funktion str_to_len.m werden die Inhalte in die richtige
% L?nge gebracht f?r die tabellarisch korrekte Darstellung, jeder
% Schleifendurchlauf generiert dabei eine Zeile der Liste.
global TSP PP

for i=1:length(TSP.stimuli(:,1))
   stimuli_list{i,1}=['S' str_to_len(num2str(TSP.stimuli{i,1}), 5) ...%Spalte: ID 
                      str_to_len(TSP.stimuli{i,2}, 25) ' '...%Spalte: Name
                      str_to_len(TSP.stimuli{i,3}, 16) ' '...%Spalte: Dateiname
                      str_to_len(TSP.stimuli{i,5}{1,4}, 6) ' '... %Spalte: osc1 (bei osc wird nur die erste Zeile/
                      str_to_len(TSP.stimuli{i,5}{2,4}, 6) ' '... %Spalte: osc2  der erste Befehl angezeigt)
                      str_to_len(TSP.stimuli{i,5}{3,4}, 6) ' '... %Spalte: osc3
                      str_to_len(TSP.stimuli{i,5}{4,4}, 6) ' '... %Spalte: osc4
                      str_to_len(TSP.stimuli{i,5}{5,4}, 6) ' '... %Spalte: osc5
                      str_to_len(TSP.stimuli{i,5}{6,4}, 6)];      %Spalte: osc6
end
set(handles.lb_stimuli,'String', stimuli_list);
if PP.edit_stimulus_line>length(stimuli_list)
    PP.edit_stimulus_line=length(stimuli_list);
end
set(handles.lb_stimuli,'Value', PP.edit_stimulus_line);


% --- Outputs from this function are returned to the command line.
function varargout = edit_stimulus_pool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in lb_stimuli.
function lb_stimuli_Callback(hObject, eventdata, handles)
% hObject    handle to lb_stimuli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lb_stimuli contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_stimuli


% --- Executes during object creation, after setting all properties.
function lb_stimuli_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_stimuli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_edit.
function pb_edit_Callback(hObject, eventdata, handles)
% hObject    handle to pb_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP
PP.edit_stimulus_line=get(handles.lb_stimuli,'Value');
PP.dontopenparent=1; %verhindern, dass beim schlie?en die ?bergeordnete GUI ge?ffnet wird
pb_save_Callback(hObject, eventdata, handles) %Speichern und schlie?en
edit_stimulus


% --- Executes on button press in pb_new_stimulus.
function pb_new_stimulus_Callback(hObject, eventdata, handles)
% hObject    handle to pb_new_stimulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PC PP
% neuer Stimulus wird am Ende der Liste erzeugt, fortlaufende ID, restliche
% Werte sind leer, werden aber als '' oder {''} vorinitialisiert, um sp?ter die
% richtige Dimension zu besitzen.
lastline=length(TSP.stimuli(:,1)); %letzte Zeile im Array ermitteln
newID=max(cat(1,TSP.stimuli{:,1}))+1;   %neue ID ist Nachfolger von h?chster ID (!muss nicht zwangsl?ufig auch gleich dem letzten Array-Index sein!)
newline=lastline+1;                %neuer Zeilenindex im Array, muss nicht gleich der neuen ID sein (kann kleiner sein, wenn zwischendrin Eintr?ge gel?scht wurden)
TSP.stimuli{newline,1}=newID;
TSP.stimuli{newline,2}=PC.emptydata_stimulus{1,1};
TSP.stimuli{newline,3}='';
TSP.stimuli{newline,4}='';
TSP.stimuli{newline,5}=PC.emptydata_stimulus_osc;
PP.edit_stimulus_line=newline;
fill_list(handles); %Funktion zum F?llen/Aktualisieren der Stimulus-Liste aufrufen (befindet sich ebenfalls in dieser m-Datei)
%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der User m?glicherweise R?ckg?ngig machen will
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
save ([PP.path filesep 'TSP.mat'],'TSP');
close


% --- Executes on button press in pb_delete_stimulus.
function pb_delete_stimulus_Callback(hObject, eventdata, handles)
% hObject    handle to pb_delete_stimulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP
if length(TSP.stimuli(:,1))==1
    PP.whisper_message='First stimulus can''t be deleted.';
    whisper_message %Warnmeldung ausgeben, wenn der User versucht, den letzten ?brigen Stimulus zu l?schen
else
    %deleteline=length(TSP.stimuli(:,1));
    deleteline=get(handles.lb_stimuli,'Value');
    set(handles.lb_stimuli,'Value', deleteline-1);
    PP.edit_stimulus_line=max(1,deleteline-1);
    TSP.stimuli(deleteline,:)=[];
    fill_list(handles);
    %Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der User m?glicherweise R?ckg?ngig machen will
    set(handles.pb_cancel,'Enable', 'on');
end


% --- Executes when user attempts to close fig_edit_stimulus_pool.
function fig_edit_stimulus_pool_CloseRequestFcn(hObject, eventdata, handles)

% hObject    handle to fig_edit_stimulus_pool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
if PP.dontopenparent~=1
    mainmenu
end
PP.dontopenparent=0;

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in pb_test_stimulus.
function pb_test_stimulus_Callback(hObject, eventdata, handles)
% hObject    handle to pb_test_stimulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
ID=get(handles.lb_stimuli,'Value');
present_stimulus(ID);


% --- Executes on button press in pb_move_up.
function pb_move_up_Callback(hObject, eventdata, handles)
% hObject    handle to pb_move_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP TSP
PP.edit_stimulus_line=get(handles.lb_stimuli,'Value');
if ~(PP.edit_stimulus_line==1) % ist der erste selektiert, machen wir gar nix
   TSP.stimuli(PP.edit_stimulus_line-1:PP.edit_stimulus_line,:)=TSP.stimuli(PP.edit_stimulus_line:-1:PP.edit_stimulus_line-1,:);
   PP.edit_stimulus_line=PP.edit_stimulus_line-1;
   fill_list(handles)
end
%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der User m?glicherweise R?ckg?ngig machen will
    set(handles.pb_cancel,'Enable', 'on');
    
% --- Executes on button press in pb_move_down.
function pb_move_down_Callback(hObject, eventdata, handles)
% hObject    handle to pb_move_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP TSP
PP.edit_stimulus_line=get(handles.lb_stimuli,'Value');
if ~(PP.edit_stimulus_line==length(TSP.stimuli(:,1))) % ist der letzte selektiert, machen wir gar nix
   TSP.stimuli(PP.edit_stimulus_line:PP.edit_stimulus_line+1,:)=TSP.stimuli(PP.edit_stimulus_line+1:-1:PP.edit_stimulus_line,:);
   PP.edit_stimulus_line=PP.edit_stimulus_line+1;
   fill_list(handles)
end
%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der User m?glicherweise R?ckg?ngig machen will
    set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in pb_multi_new_stimuli.
function pb_multi_new_stimuli_Callback(hObject, eventdata, handles)
% hObject    handle to pb_multi_new_stimuli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP PC TSP 

%zuletzt ge?ffneter Pfad wird ?bernommen, wenn vorhanden
browser_startpath=''; 
if isfield (PP, 'newwavefilepath')
    browser_startpath=PP.newwavefilepath;
end
[newwavefilenames_temp,newwavefilepath_temp]=uigetfile('*.wav','please select wavefiles', browser_startpath, 'MultiSelect', 'on');

files_are_selected_flag = 1;
if iscell(newwavefilenames_temp)
    num_new_stimuli = length(newwavefilenames_temp);
elseif newwavefilenames_temp == 0 % d.h. der User hat im Dateidialog nichts ausgew?hlt oder/und "Cancel" gedr?ckt
    files_are_selected_flag = 0;
else    
    num_new_stimuli = 1;
end
% neue Stimuli werden am Ende der Liste erzeugt, fortlaufende ID
% Ausnahme: Der erste Stimulus ist der nichteditierte, nichtver?nderte
% (nicht-l?schbare!) Standartstimulus

defaultflag = (length(TSP.stimuli(:,1)) == 1) ...
    && (TSP.stimuli{1,1} == 1) ...
    && strcmp(TSP.stimuli{1,2},PC.emptydata_stimulus{1,1}) ... % funktioniert das?
    && isempty(TSP.stimuli{1,3}) ...
    && isempty(TSP.stimuli{1,5}{1,2}) ...
    && isempty(TSP.stimuli{1,5}{1,4}) ...
    && isempty(TSP.stimuli{1,5}{2,2}) ...
    && isempty(TSP.stimuli{1,5}{2,4}) ...
    && isempty(TSP.stimuli{1,5}{3,2}) ...
    && isempty(TSP.stimuli{1,5}{3,4}) ...
    && isempty(TSP.stimuli{1,5}{4,2}) ...
    && isempty(TSP.stimuli{1,5}{4,4}) ...
    && isempty(TSP.stimuli{1,5}{5,2}) ...
    && isempty(TSP.stimuli{1,5}{5,4}) ...
    && isempty(TSP.stimuli{1,5}{6,2}) ...
    && isempty(TSP.stimuli{1,5}{6,4});


if files_are_selected_flag
    for i = 1:num_new_stimuli    
        if num_new_stimuli > 1
            PP.newwavefilename=newwavefilenames_temp{i};
        else
            PP.newwavefilename=newwavefilenames_temp;
        end
        PP.newwavefilepath=newwavefilepath_temp;
        lastline=length(TSP.stimuli(:,1)); %letzte Zeile im Array ermitteln
        if ~defaultflag
            newID=max(cat(1,TSP.stimuli{:,1}))+1;   %neue ID ist Nachfolger von h?chster ID (!muss nicht zwangsl?ufig auch gleich dem letzten Array-Index sein!)
            newline=lastline+1;                %neuer Zeilenindex im Array, muss nicht gleich der neuen ID sein (kann kleiner sein, wenn zwischendrin Eintr?ge gel?scht wurden)
        elseif defaultflag % d.h. der erste, bestehende Stimulus wird mitaufgef?llt.
            newID=1;
            newline=1;
            defaultflag = 0; % defaultflag zur?cksetzen
        else
            disp('Serious programming error - this case simply shouldn''t pop up at all.');
        end
        wavefilefullpath = [PP.newwavefilepath PP.newwavefilename];
        [name, ext, dur] = readwavefile(wavefilefullpath);

        TSP.stimuli{newline,1}=newID;
        TSP.stimuli{newline,2}=name;
        TSP.stimuli{newline,3}=[name ext];
        TSP.stimuli{newline,4}=num2str(dur);
        TSP.stimuli{newline,5}=PC.emptydata_stimulus_osc;
        PP.edit_stimulus_line=newline;
        copyfile(wavefilefullpath, [PP.path filesep 'audiofiles' filesep PP.newwavefilename]);
    end
end
    fill_list(handles); %Funktion zum F?llen/Aktualisieren der Stimulus-Liste aufrufen (befindet sich ebenfalls in dieser m-Datei)
    %Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der User m?glicherweise R?ckg?ngig machen will
    set(handles.pb_cancel,'Enable', 'on');


function [name, ext, dur] = readwavefile(wavefilefullpath)

[y, Fs] = audioread(wavefilefullpath, 'native');

% Den Stimulusnamen automatisch aus dem Dateinamen generieren
[pth,name,ext]=fileparts(wavefilefullpath);
% Dauer berechnen
dur = ceil(length(y)/Fs*1000)/1000;


