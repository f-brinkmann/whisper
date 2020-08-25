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
% Author :   André Wlodarski, student at FG Audiokommunikation, TU Berlin
% Email  :   awlodarski AT gmx DOT de
% Date   :   15-Nov-2008
%
% =========================================================================


function varargout = open_test_series(varargin)
% OPEN_TEST_SERIES M-file for open_test_series.fig
%      OPEN_TEST_SERIES, by itself, creates a new OPEN_TEST_SERIES or raises the existing
%      singleton*.
%
%      H = OPEN_TEST_SERIES returns the handle to a new OPEN_TEST_SERIES or the handle to
%      the existing singleton*.
%
%      OPEN_TEST_SERIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPEN_TEST_SERIES.M with the given input arguments.
%
%      OPEN_TEST_SERIES('Property','Value',...) creates a new OPEN_TEST_SERIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before open_test_series_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to open_test_series_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help open_test_series

% Last Modified by GUIDE v2.5 30-Jul-2008 00:07:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @open_test_series_OpeningFcn, ...
                   'gui_OutputFcn',  @open_test_series_OutputFcn, ...
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


% --- Executes just before open_test_series is made visible.
function open_test_series_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  % opennewtestseriespath  Pfad zum Ordner der zu öffnenden Testreihe
% varargin   command line arguments to open_test_series (see VARARGIN)

% Choose default command line output for open_test_series
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes open_test_series wait for user response (see UIRESUME)
% uiwait(handles.fig_open_test_series);

movegui(hObject,'center')


% --- Outputs from this function are returned to the command line.
function varargout = open_test_series_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_open.
function pb_open_Callback(hObject, eventdata, handles)
% hObject    handle to pb_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

opentestseriespath=get(handles.ed_opentestseriespath,'String');
load_test_series(opentestseriespath);

% --- Executes on button press in pb_cancel.
function pb_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close


function ed_opentestseriespath_Callback(hObject, eventdata, handles)
% hObject    handle to ed_opentestseriespath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_opentestseriespath as text
%        str2double(get(hObject,'String')) returns contents of ed_opentestseriespath as a double


% --- Executes during object creation, after setting all properties.
function ed_opentestseriespath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_opentestseriespath (see GCBO)
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

% Abfrage des zu öffnenden Ordners, uigetdir liefert bei abbruch 0, in
% diesem Fall wird der komplette Block nicht ausgeführt
opentestseriespath_temp=uigetdir;
if opentestseriespath_temp ~= 0
   opentestseriespath=opentestseriespath_temp;
   % Darstellung in der Pfad-Zeile 
   set(handles.ed_opentestseriespath,'String', opentestseriespath);
   % Pfadname des zu suchenden Infofiles (testseries.info) erzeugen
   opentestseries_infofile=[opentestseriespath filesep 'testseries.info'];
   % testen ob eine testseries.info in dem zu öffnenden Ordner existiert
   % dadurch geschieht die Identifikation des gewählten Ordners als
   % gültiger Projektordner
   infofileabfrage=dir(opentestseries_infofile);
   if length(infofileabfrage)==1 %wenn ja, dann anzeigen und open-Knopf aktivieren
     fid = fopen(opentestseries_infofile);
     zeile=1;
     while 1
         zeilentext = fgetl(fid);
         if ~ischar(zeilentext),   break,   end
         text_komplett{zeile}=zeilentext;
         zeile=zeile+1;
     end
     set(handles.txt_testseries_info,'String', text_komplett);
     set(handles.pb_open,'Enable', 'on');
     fclose(fid);
   else
     set(handles.txt_testseries_info,'String', 'the chosen folder does not contain a testseries');  
     set(handles.pb_open,'Enable', 'off');
   end
end

