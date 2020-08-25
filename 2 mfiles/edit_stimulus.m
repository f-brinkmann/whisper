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


function varargout = edit_stimulus(varargin)
% EDIT_STIMULUS M-file for edit_stimulus.fig
%      EDIT_STIMULUS, by itself, creates a new EDIT_STIMULUS or raises the existing
%      singleton*.
%
%      H = EDIT_STIMULUS returns the handle to a new EDIT_STIMULUS or the handle to
%      the existing singleton*.
%
%      EDIT_STIMULUS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDIT_STIMULUS.M with the given input arguments.
%
%      EDIT_STIMULUS('Property','Value',...) creates a new EDIT_STIMULUS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before edit_stimulus_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to edit_stimulus_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help edit_stimulus

% Last Modified by GUIDE v2.5 16-Oct-2008 02:27:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @edit_stimulus_OpeningFcn, ...
                   'gui_OutputFcn',  @edit_stimulus_OutputFcn, ...
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


% --- Executes just before edit_stimulus is made visible.
function edit_stimulus_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to edit_stimulus (see VARARGIN)

% Choose default command line output for edit_stimulus
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes edit_stimulus wait for user response (see UIRESUME)
% uiwait(handles.fig_edit_stimulus);

movegui(hObject,'center')
global TSP PP;
set(handles.ed_name,'String',TSP.stimuli{PP.edit_stimulus_line,2});
set(handles.ed_ID,'String',['S' num2str(TSP.stimuli{PP.edit_stimulus_line,1})]);
set(handles.ed_duration,'String',TSP.stimuli{PP.edit_stimulus_line,4});
if isempty(TSP.stimuli{PP.edit_stimulus_line,3})==0
    set(handles.ed_file,'String',TSP.stimuli{PP.edit_stimulus_line,3});
    readwavefile(handles,0,0)
end

%server1
set(handles.ed_pause_1,'String',TSP.stimuli{PP.edit_stimulus_line,5}{1,1});
set(handles.ed_path_1,'String',TSP.stimuli{PP.edit_stimulus_line,5}{1,2});
switch TSP.stimuli{PP.edit_stimulus_line,5}{1,3} %standard: string
    case 'i' %int32
        set(handles.pop_type_1,'Value',2);
    case 'f' %float32
        set(handles.pop_type_1,'Value',3);
    case 'T' %True
        set(handles.pop_type_1,'Value',4);
        set(handles.ed_osc1,'Enable','Off');
    case 'F' %False
        set(handles.pop_type_1,'Value',5);
        set(handles.ed_osc1,'Enable','Off');
end
set(handles.ed_osc1,'String',TSP.stimuli{PP.edit_stimulus_line,5}{1,4});

%server2
set(handles.ed_pause_2,'String',TSP.stimuli{PP.edit_stimulus_line,5}{2,1});
set(handles.ed_path_2,'String',TSP.stimuli{PP.edit_stimulus_line,5}{2,2});
switch TSP.stimuli{PP.edit_stimulus_line,5}{2,3}
    case 'i' %int32
        set(handles.pop_type_2,'Value',2);
    case 'f' %float32
        set(handles.pop_type_2,'Value',3);
    case 'T' %True
        set(handles.pop_type_2,'Value',4);
        set(handles.ed_osc2,'Enable','Off');
    case 'F' %False
        set(handles.pop_type_2,'Value',5);
        set(handles.ed_osc2,'Enable','Off');
end
set(handles.ed_osc2,'String',TSP.stimuli{PP.edit_stimulus_line,5}{2,4});

%server3
set(handles.ed_pause_3,'String',TSP.stimuli{PP.edit_stimulus_line,5}{3,1});
set(handles.ed_path_3,'String',TSP.stimuli{PP.edit_stimulus_line,5}{3,2});
switch TSP.stimuli{PP.edit_stimulus_line,5}{3,3}
    case 'i' %int32
        set(handles.pop_type_3,'Value',2);
    case 'f' %float32
        set(handles.pop_type_3,'Value',3);
    case 'T' %True
        set(handles.pop_type_3,'Value',4);
        set(handles.ed_osc3,'Enable','Off');
    case 'F' %False
        set(handles.pop_type_3,'Value',5);
        set(handles.ed_osc3,'Enable','Off');
end
set(handles.ed_osc3,'String',TSP.stimuli{PP.edit_stimulus_line,5}{3,4});

%server4
set(handles.ed_pause_4,'String',TSP.stimuli{PP.edit_stimulus_line,5}{4,1});
set(handles.ed_path_4,'String',TSP.stimuli{PP.edit_stimulus_line,5}{4,2});
switch TSP.stimuli{PP.edit_stimulus_line,5}{4,3}
    case 'i' %int32
        set(handles.pop_type_4,'Value',2);
    case 'f' %float32
        set(handles.pop_type_4,'Value',3);
    case 'T' %True
        set(handles.pop_type_4,'Value',4);
        set(handles.ed_osc4,'Enable','Off');
    case 'F' %False
        set(handles.pop_type_4,'Value',5);
        set(handles.ed_osc4,'Enable','Off');
end
set(handles.ed_osc4,'String',TSP.stimuli{PP.edit_stimulus_line,5}{4,4});

%server5
set(handles.ed_pause_5,'String',TSP.stimuli{PP.edit_stimulus_line,5}{5,1});
set(handles.ed_path_5,'String',TSP.stimuli{PP.edit_stimulus_line,5}{5,2});
switch TSP.stimuli{PP.edit_stimulus_line,5}{5,3}
    case 'i' %int32
        set(handles.pop_type_5,'Value',2);
    case 'f' %float32
        set(handles.pop_type_5,'Value',3);
    case 'T' %True
        set(handles.pop_type_5,'Value',4);
        set(handles.ed_osc5,'Enable','Off');
    case 'F' %False
        set(handles.pop_type_5,'Value',5);
        set(handles.ed_osc5,'Enable','Off');
end
set(handles.ed_osc5,'String',TSP.stimuli{PP.edit_stimulus_line,5}{5,4});

%server6
set(handles.ed_pause_6,'String',TSP.stimuli{PP.edit_stimulus_line,5}{6,1});
set(handles.ed_path_6,'String',TSP.stimuli{PP.edit_stimulus_line,5}{6,2});
switch TSP.stimuli{PP.edit_stimulus_line,5}{6,3}
    case 'i' %int32
        set(handles.pop_type_6,'Value',2);
    case 'f' %float32
        set(handles.pop_type_6,'Value',3);
    case 'T' %True
        set(handles.pop_type_6,'Value',4);
        set(handles.ed_osc6,'Enable','Off');
    case 'F' %False
        set(handles.pop_type_6,'Value',5);
        set(handles.ed_osc6,'Enable','Off');
end
set(handles.ed_osc6,'String',TSP.stimuli{PP.edit_stimulus_line,5}{6,4});


% --- Outputs from this function are returned to the command line.
function varargout = edit_stimulus_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function ed_osc1_Callback(hObject, eventdata, handles)
% hObject    handle to ed_osc1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_osc1 as text
%        str2double(get(hObject,'String')) returns contents of ed_osc1 as a double


% --- Executes during object creation, after setting all properties.
function ed_osc1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_osc1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_duration_Callback(hObject, eventdata, handles)
% hObject    handle to ed_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_duration as text
%        str2double(get(hObject,'String')) returns contents of ed_duration as a double


% --- Executes during object creation, after setting all properties.
function ed_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_file_Callback(hObject, eventdata, handles)
% hObject    handle to ed_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_file as text
%        str2double(get(hObject,'String')) returns contents of ed_file as a double


% --- Executes during object creation, after setting all properties.
function ed_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_name_Callback(hObject, eventdata, handles)
% hObject    handle to ed_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_name as text
%        str2double(get(hObject,'String')) returns contents of ed_name as a double


% --- Executes during object creation, after setting all properties.
function ed_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_name (see GCBO)
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
global PP

browser_startpath=''; %zuletzt ge?ffneter Pfad wird ?bernommen, wenn vorhanden
if isfield (PP, 'newwavefilepath')
    browser_startpath=PP.newwavefilepath;
end
[newwavefilename_temp,newwavefilepath_temp]=uigetfile('*.wav','select wavefile', browser_startpath);
if newwavefilename_temp ~= 0
   PP.newwavefilename=newwavefilename_temp;
   PP.newwavefilepath=newwavefilepath_temp;
   newwave=[PP.newwavefilepath PP.newwavefilename];
   % Darstellung in der Pfad-Zeile 
   set(handles.ed_file,'String', newwave);
   %Aufruf der Funktion zum Einlesen der Datei und vervollst?ndigen der
   %Bitrate und Fs, 2. Argument hier 0, da File jetzt nicht abgespielt
   %werden soll; 3. Argument 1, da die Dauer ?bernommen werden soll
   readwavefile(handles, 0,1);   
end


function readwavefile(handles, listen, change_duration)

global PP
wavepath=get(handles.ed_file,'String');
if isempty(regexpi(wavepath, filesep))==1 %wenn der Pfad keinen "\" (oder "/" unter Unix) enh?lt, muss sie aus dem Projektpfad geladen werden, welcher hier erg?nzt wird.
    wavepath=[PP.path filesep 'audiofiles' filesep wavepath];
end
[y, Fs] = audioread(wavepath,'native');
nbits   = audioinfo(wavepath);
nbits   = nbits.BitsPerSample;
set(handles.ed_rate,'String',Fs);
set(handles.ed_bit_depth,'String',nbits);
% Den Stimulusnamen automatisch aus dem Dateinamen generieren, falls dieser
% nicht vom Standard abweicht (= vom User bearbeitet wurde)
if strcmp(get(handles.ed_name,'String'),'- no name -')
    [pth,name]=fileparts(wavepath); % previous [pth,name,ext,vers]=fileparts(wavepath);
    set(handles.ed_name,'String',name);
end
if change_duration==1
    set(handles.ed_duration,'String',ceil(length(y)/Fs*1000)/1000)
end
if listen == 1
% pa_wavplay(y, Fs);
    global player 
    player = audioplayer(y, Fs);
    play(player)
end


% --- Executes on button press in pb_ok.
function pb_ok_Callback(hObject, eventdata, handles)
% hObject    handle to pb_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
TSP.stimuli{PP.edit_stimulus_line,2}=get(handles.ed_name,'String');
wavefilename=get(handles.ed_file,'String');
if isempty(wavefilename)==0 %wenn ein wavefile angegeben ist..
    if isempty(regexpi(wavefilename, filesep ))==0 %wenn der Pfad "\" (oder "/" unter Unix) enth?lt, 
        %also gerade neu hinzugef?gt wird, dann kopieren in Projektordner
        copyfile(wavefilename, [PP.path filesep 'audiofiles' filesep PP.newwavefilename]);
        wavefilename=PP.newwavefilename;
    end
    TSP.stimuli{PP.edit_stimulus_line,3}=wavefilename;
end
TSP.stimuli{PP.edit_stimulus_line,4}=get(handles.ed_duration,'String');

%server1
TSP.stimuli{PP.edit_stimulus_line,5}{1,1}=str2num(get(handles.ed_pause_1,'String'));
TSP.stimuli{PP.edit_stimulus_line,5}{1,2}=get(handles.ed_path_1,'String');
switch get(handles.pop_type_1,'Value')
    case 1 %string
        TSP.stimuli{PP.edit_stimulus_line,5}{1,3}='s';
    case 2 %int32
        TSP.stimuli{PP.edit_stimulus_line,5}{1,3}='i';
    case 3 %float32
        TSP.stimuli{PP.edit_stimulus_line,5}{1,3}='f';
    case 4 %True
        TSP.stimuli{PP.edit_stimulus_line,5}{1,3}='T';
    case 5 %False
        TSP.stimuli{PP.edit_stimulus_line,5}{1,3}='F';
end
TSP.stimuli{PP.edit_stimulus_line,5}{1,4}=get(handles.ed_osc1,'String');

%server2
TSP.stimuli{PP.edit_stimulus_line,5}{2,1}=str2num(get(handles.ed_pause_2,'String'));
TSP.stimuli{PP.edit_stimulus_line,5}{2,2}=get(handles.ed_path_2,'String');
switch get(handles.pop_type_2,'Value')
    case 1 %string
        TSP.stimuli{PP.edit_stimulus_line,5}{2,3}='s';
    case 2 %int32
        TSP.stimuli{PP.edit_stimulus_line,5}{2,3}='i';
    case 3 %float32
        TSP.stimuli{PP.edit_stimulus_line,5}{2,3}='f';
    case 4 %True
        TSP.stimuli{PP.edit_stimulus_line,5}{2,3}='T';
    case 5 %False
        TSP.stimuli{PP.edit_stimulus_line,5}{2,3}='F';
end
TSP.stimuli{PP.edit_stimulus_line,5}{2,4}=get(handles.ed_osc2,'String');

%server3
TSP.stimuli{PP.edit_stimulus_line,5}{3,1}=str2num(get(handles.ed_pause_3,'String'));
TSP.stimuli{PP.edit_stimulus_line,5}{3,2}=get(handles.ed_path_3,'String');
switch get(handles.pop_type_3,'Value')
    case 1 %string
        TSP.stimuli{PP.edit_stimulus_line,5}{3,3}='s';
    case 2 %int32
        TSP.stimuli{PP.edit_stimulus_line,5}{3,3}='i';
    case 3 %float32
        TSP.stimuli{PP.edit_stimulus_line,5}{3,3}='f';
    case 4 %True
        TSP.stimuli{PP.edit_stimulus_line,5}{3,3}='T';
    case 5 %False
        TSP.stimuli{PP.edit_stimulus_line,5}{3,3}='F';
end
TSP.stimuli{PP.edit_stimulus_line,5}{3,4}=get(handles.ed_osc3,'String');

%server4
TSP.stimuli{PP.edit_stimulus_line,5}{4,1}=str2num(get(handles.ed_pause_4,'String'));
TSP.stimuli{PP.edit_stimulus_line,5}{4,2}=get(handles.ed_path_4,'String');
switch get(handles.pop_type_4,'Value')
    case 1 %string
        TSP.stimuli{PP.edit_stimulus_line,5}{4,3}='s';
    case 2 %int32
        TSP.stimuli{PP.edit_stimulus_line,5}{4,3}='i';
    case 3 %float32
        TSP.stimuli{PP.edit_stimulus_line,5}{4,3}='f';
    case 4 %True
        TSP.stimuli{PP.edit_stimulus_line,5}{4,3}='T';
    case 5 %False
        TSP.stimuli{PP.edit_stimulus_line,5}{4,3}='F';
end
TSP.stimuli{PP.edit_stimulus_line,5}{4,4}=get(handles.ed_osc4,'String');

%server5
TSP.stimuli{PP.edit_stimulus_line,5}{5,1}=str2num(get(handles.ed_pause_5,'String'));
TSP.stimuli{PP.edit_stimulus_line,5}{5,2}=get(handles.ed_path_5,'String');
switch get(handles.pop_type_5,'Value')
    case 1 %string
        TSP.stimuli{PP.edit_stimulus_line,5}{5,3}='s';
    case 2 %int32
        TSP.stimuli{PP.edit_stimulus_line,5}{5,3}='i';
    case 3 %float32
        TSP.stimuli{PP.edit_stimulus_line,5}{5,3}='f';
    case 4 %True
        TSP.stimuli{PP.edit_stimulus_line,5}{5,3}='T';
    case 5 %False
        TSP.stimuli{PP.edit_stimulus_line,5}{5,3}='F';
end
TSP.stimuli{PP.edit_stimulus_line,5}{5,4}=get(handles.ed_osc5,'String');

%server6
TSP.stimuli{PP.edit_stimulus_line,5}{6,1}=str2num(get(handles.ed_pause_6,'String'));
TSP.stimuli{PP.edit_stimulus_line,5}{6,2}=get(handles.ed_path_6,'String');
switch get(handles.pop_type_6,'Value')
    case 1 %string
        TSP.stimuli{PP.edit_stimulus_line,5}{6,3}='s';
    case 2 %int32
        TSP.stimuli{PP.edit_stimulus_line,5}{6,3}='i';
    case 3 %float32
        TSP.stimuli{PP.edit_stimulus_line,5}{6,3}='f';
    case 4 %True
        TSP.stimuli{PP.edit_stimulus_line,5}{6,3}='T';
    case 5 %False
        TSP.stimuli{PP.edit_stimulus_line,5}{6,3}='F';
end
TSP.stimuli{PP.edit_stimulus_line,5}{6,4}=get(handles.ed_osc6,'String');

save ([PP.path filesep 'TSP.mat'],'TSP');

close


% --- Executes on button press in pb_cancel.
function pb_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close


function ed_ID_Callback(hObject, eventdata, handles)
% hObject    handle to ed_ID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_ID as text
%        str2double(get(hObject,'String')) returns contents of ed_ID as a double


% --- Executes during object creation, after setting all properties.
function ed_ID_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_ID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_osc2_Callback(hObject, eventdata, handles)
% hObject    handle to ed_osc2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_osc2 as text
%        str2double(get(hObject,'String')) returns contents of ed_osc2 as a double


% --- Executes during object creation, after setting all properties.
function ed_osc2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_osc2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_osc3_Callback(hObject, eventdata, handles)
% hObject    handle to ed_osc3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_osc3 as text
%        str2double(get(hObject,'String')) returns contents of ed_osc3 as a double


% --- Executes during object creation, after setting all properties.
function ed_osc3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_osc3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_osc4_Callback(hObject, eventdata, handles)
% hObject    handle to ed_osc4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_osc4 as text
%        str2double(get(hObject,'String')) returns contents of ed_osc4 as a double


% --- Executes during object creation, after setting all properties.
function ed_osc4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_osc4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_osc5_Callback(hObject, eventdata, handles)
% hObject    handle to ed_osc5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_osc5 as text
%        str2double(get(hObject,'String')) returns contents of ed_osc5 as a double


% --- Executes during object creation, after setting all properties.
function ed_osc5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_osc5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_osc6_Callback(hObject, eventdata, handles)
% hObject    handle to ed_osc6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_osc6 as text
%        str2double(get(hObject,'String')) returns contents of ed_osc6 as a double


% --- Executes during object creation, after setting all properties.
function ed_osc6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_osc6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_get_from_file.
function pb_get_from_file_Callback(hObject, eventdata, handles)
% hObject    handle to pb_get_from_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

readwavefile(handles,0,1)


% --- Executes on button press in pb_listen.
function pb_listen_Callback(hObject, eventdata, handles)
% hObject    handle to pb_listen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

readwavefile(handles,1,0);


function ed_bit_depth_Callback(hObject, eventdata, handles)
% hObject    handle to ed_bit_depth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_bit_depth as text
%        str2double(get(hObject,'String')) returns contents of ed_bit_depth as a double


% --- Executes during object creation, after setting all properties.
function ed_bit_depth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_bit_depth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_rate_Callback(hObject, eventdata, handles)
% hObject    handle to ed_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_rate as text
%        str2double(get(hObject,'String')) returns contents of ed_rate as a double


% --- Executes during object creation, after setting all properties.
function ed_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close fig_edit_stimulus.
function fig_edit_stimulus_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_edit_stimulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

edit_stimulus_pool

% Hint: delete(hObject) closes the figure
delete(hObject);


function ed_path_4_Callback(hObject, eventdata, handles)
% hObject    handle to ed_path_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_path_4 as text
%        str2double(get(hObject,'String')) returns contents of ed_path_4 as a double


% --- Executes during object creation, after setting all properties.
function ed_path_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_path_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_type_4.
function pop_type_4_Callback(hObject, eventdata, handles)
% hObject    handle to pop_type_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_type_4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_type_4

test=get(handles.pop_type_4,'Value');
if test==4 || test==5
    set(handles.ed_osc4,'Enable','Off')
else
    set(handles.ed_osc4,'Enable','On')
end


% --- Executes during object creation, after setting all properties.
function pop_type_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_type_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_pause_4_Callback(hObject, eventdata, handles)
% hObject    handle to ed_pause_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_pause_4 as text
%        str2double(get(hObject,'String')) returns contents of ed_pause_4 as a double


% --- Executes during object creation, after setting all properties.
function ed_pause_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_pause_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_path_5_Callback(hObject, eventdata, handles)
% hObject    handle to ed_path_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_path_5 as text
%        str2double(get(hObject,'String')) returns contents of ed_path_5 as a double


% --- Executes during object creation, after setting all properties.
function ed_path_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_path_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_type_5.
function pop_type_5_Callback(hObject, eventdata, handles)
% hObject    handle to pop_type_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_type_5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_type_5

test=get(handles.pop_type_5,'Value');
if test==4 || test==5
    set(handles.ed_osc5,'Enable','Off')
else
    set(handles.ed_osc5,'Enable','On')
end


% --- Executes during object creation, after setting all properties.
function pop_type_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_type_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_pause_5_Callback(hObject, eventdata, handles)
% hObject    handle to ed_pause_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_pause_5 as text
%        str2double(get(hObject,'String')) returns contents of ed_pause_5 as a double


% --- Executes during object creation, after setting all properties.
function ed_pause_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_pause_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_path_6_Callback(hObject, eventdata, handles)
% hObject    handle to ed_path_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_path_6 as text
%        str2double(get(hObject,'String')) returns contents of ed_path_6 as a double


% --- Executes during object creation, after setting all properties.
function ed_path_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_path_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_type_6.
function pop_type_6_Callback(hObject, eventdata, handles)
% hObject    handle to pop_type_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_type_6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_type_6

test=get(handles.pop_type_6,'Value');
if test==4 || test==5
    set(handles.ed_osc6,'Enable','Off')
else
    set(handles.ed_osc6,'Enable','On')
end


% --- Executes during object creation, after setting all properties.
function pop_type_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_type_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_pause_6_Callback(hObject, eventdata, handles)
% hObject    handle to ed_pause_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_pause_6 as text
%        str2double(get(hObject,'String')) returns contents of ed_pause_6 as a double


% --- Executes during object creation, after setting all properties.
function ed_pause_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_pause_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_path_3_Callback(hObject, eventdata, handles)
% hObject    handle to ed_path_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_path_3 as text
%        str2double(get(hObject,'String')) returns contents of ed_path_3 as a double


% --- Executes during object creation, after setting all properties.
function ed_path_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_path_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_type_3.
function pop_type_3_Callback(hObject, eventdata, handles)
% hObject    handle to pop_type_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_type_3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_type_3

test=get(handles.pop_type_3,'Value');
if test==4 || test==5
    set(handles.ed_osc3,'Enable','Off')
else
    set(handles.ed_osc3,'Enable','On')
end


% --- Executes during object creation, after setting all properties.
function pop_type_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_type_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_pause_3_Callback(hObject, eventdata, handles)
% hObject    handle to ed_pause_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_pause_3 as text
%        str2double(get(hObject,'String')) returns contents of ed_pause_3 as a double


% --- Executes during object creation, after setting all properties.
function ed_pause_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_pause_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_path_2_Callback(hObject, eventdata, handles)
% hObject    handle to ed_path_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_path_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_path_2 as a double


% --- Executes during object creation, after setting all properties.
function ed_path_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_path_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_type_2.
function pop_type_2_Callback(hObject, eventdata, handles)
% hObject    handle to pop_type_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_type_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_type_2

test=get(handles.pop_type_2,'Value');
if test==4 || test==5
    set(handles.ed_osc2,'Enable','Off')
else
    set(handles.ed_osc2,'Enable','On')
end


% --- Executes during object creation, after setting all properties.
function pop_type_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_type_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_pause_2_Callback(hObject, eventdata, handles)
% hObject    handle to ed_pause_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_pause_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_pause_2 as a double


% --- Executes during object creation, after setting all properties.
function ed_pause_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_pause_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_path_1_Callback(hObject, eventdata, handles)
% hObject    handle to ed_path_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_path_1 as text
%        str2double(get(hObject,'String')) returns contents of ed_path_1 as a double


% --- Executes during object creation, after setting all properties.
function ed_path_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_path_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_type_1.
function pop_type_1_Callback(hObject, eventdata, handles)
% hObject    handle to pop_type_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_type_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_type_1

test=get(handles.pop_type_1,'Value');
if test==4 || test==5
    set(handles.ed_osc1,'Enable','Off')
else
    set(handles.ed_osc1,'Enable','On')
end

% --- Executes during object creation, after setting all properties.
function pop_type_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_type_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_pause_1_Callback(hObject, eventdata, handles)
% hObject    handle to ed_pause_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_pause_1 as text
%        str2double(get(hObject,'String')) returns contents of ed_pause_1 as a double


% --- Executes during object creation, after setting all properties.
function ed_pause_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_pause_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_stop.
function pb_stop_Callback(hObject, eventdata, handles)
% hObject    handle to pb_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global player;
stop(player);

