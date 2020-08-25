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


function varargout = new_test_series(varargin)
% NEW_TEST_SERIES M-file for new_test_series.fig
%      NEW_TEST_SERIES, by itself, creates a new NEW_TEST_SERIES or raises the existing
%      singleton*.
%
%      H = NEW_TEST_SERIES returns the handle to a new NEW_TEST_SERIES or the handle to
%      the existing singleton*.
%
%      NEW_TEST_SERIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEW_TEST_SERIES.M with the given input arguments.
%
%      NEW_TEST_SERIES('Property','Value',...) creates a new NEW_TEST_SERIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before new_test_series_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to new_test_series_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help new_test_series

% Last Modified by GUIDE v2.5 21-Oct-2016 10:31:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @new_test_series_OpeningFcn, ...
                   'gui_OutputFcn',  @new_test_series_OutputFcn, ...
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


% --- Executes just before new_test_series is made visible.
function new_test_series_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to new_test_series (see VARARGIN)

% Choose default command line output for new_test_series
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes new_test_series wait for user response (see UIRESUME)
% uiwait(handles.fig_new_test_series);

movegui(hObject,'center')


% --- Outputs from this function are returned to the command line.
function varargout = new_test_series_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_create.
function pb_create_Callback(hObject, eventdata, handles)
% hObject    handle to pb_create (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Ordner f?r neue Testreihe wird angelegt
newtestseries_location=get(handles.ed_newtestseries_location,'String');
newtestseries_name=get(handles.ed_newtestseries_name,'String');
mkdir(newtestseries_location, newtestseries_name);
mkdir([newtestseries_location filesep newtestseries_name], 'audiofiles');
mkdir([newtestseries_location filesep newtestseries_name], 'plots');
mkdir([newtestseries_location filesep newtestseries_name], 'export');
mkdir([newtestseries_location filesep newtestseries_name], 'logfiles');
% testseries.info f?r neues Projekt wird angelegt
% diese Datei dient sp?ter zur Identifizierung des Ordners als g?ltigen
% Projektordner
fid = fopen([newtestseries_location filesep newtestseries_name filesep 'testseries.info'], 'w');
fwrite(fid, ['name of test series: ' newtestseries_name]);
fclose(fid);
% Variablen des evtl. ge?ffneten Projektes werden aus dem Speicher
% entfernt, neu angelegt, und als mat-files gespeichert
clear global TSP TSD PP
global TSP TSD PC
TSP.name = newtestseries_name; %name speichern
% erster stimulus-Datensatz wird erzeugt als Dummy. Dieser wird sp?ter vom
% User mit den tats?chlichen Daten ?berschrieben.
TSP.stimuli= {1, ...              %ID
              PC.emptydata_stimulus{1,1}, ...    %Name
              '', ...               %Dateiname
              '', ...               %Dauer
              {''}};                %osc-feld
TSP.stimuli{1,5}=PC.emptydata_stimulus_osc; %osc leere Datenstruktur einf?gen
TSP.sections={}; %wird sp?ter mit den gew?hlten testverfahren aufgef?llt
TSP.number_of_sessions=1;

save ([newtestseries_location filesep newtestseries_name filesep 'TSP'],'TSP');
save ([newtestseries_location filesep newtestseries_name filesep 'TSD'],'TSD');
% ab hier regul?res Laden des gerade erzeugten Projektes
load_test_series([newtestseries_location filesep newtestseries_name]);

  
% --- Executes on button press in pb_cancel.
function pb_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close new


function ed_newtestseries_location_Callback(hObject, eventdata, handles)
% hObject    handle to ed_newtestseries_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_newtestseries_location as text
%        str2double(get(hObject,'String')) returns contents of ed_newtestseries_location as a double


% --- Executes during object creation, after setting all properties.
function ed_newtestseries_location_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_newtestseries_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_browse.
function pb_browse_Callback(hObject, eventdata, handles)
% hObject    handle to pb_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Speicherort f?r die neue Testreihe abfragen
% uigetdir liefert bei abbruch 0, in diesem Fall wird kein Pfad ?bernommen
newtestseries_location_temp=uigetdir;
if newtestseries_location_temp ~= 0
   newtestseries_location=newtestseries_location_temp;
   % Darstellung in der Pfad-Zeile 
   set(handles.ed_newtestseries_location,'String', newtestseries_location);
end


function ed_newtestseries_name_Callback(hObject, eventdata, handles)
% hObject    handle to ed_newtestseries_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_newtestseries_name as text
%        str2double(get(hObject,'String')) returns contents of ed_newtestseries_name as a double

if ~isempty(get(handles.ed_newtestseries_location, 'String')) ...
    && ~isempty(get(handles.ed_newtestseries_name, 'String'))
    pb_create_Callback(hObject, eventdata, handles)
end


% --- Executes during object creation, after setting all properties.
function ed_newtestseries_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_newtestseries_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
