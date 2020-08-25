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


function varargout = ap_edit_pest_settings(varargin)
% AP_EDIT_PEST_SETTINGS M-file for ap_edit_pest_settings.fig
%      AP_EDIT_PEST_SETTINGS, by itself, creates a new AP_EDIT_PEST_SETTINGS or raises the existing
%      singleton*.
%
%      H = AP_EDIT_PEST_SETTINGS returns the handle to a new AP_EDIT_PEST_SETTINGS or the handle to
%      the existing singleton*.
%
%      AP_EDIT_PEST_SETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AP_EDIT_PEST_SETTINGS.M with the given input arguments.
%
%      AP_EDIT_PEST_SETTINGS('Property','Value',...) creates a new AP_EDIT_PEST_SETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ap_edit_pest_settings_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ap_edit_pest_settings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ap_edit_pest_settings

% Last Modified by GUIDE v2.5 26-Oct-2008 22:56:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ap_edit_pest_settings_OpeningFcn, ...
                   'gui_OutputFcn',  @ap_edit_pest_settings_OutputFcn, ...
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


% --- Executes just before ap_edit_pest_settings is made visible.
function ap_edit_pest_settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ap_edit_pest_settings (see VARARGIN)

% Choose default command line output for ap_edit_pest_settings
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ap_edit_pest_settings wait for user response (see UIRESUME)
% uiwait(handles.fig_edit_pest_settings);

movegui(hObject,'center')
global TSP PP
load ([PP.path filesep 'TSP.mat']);

%Auffüllen der GUI mit den gepeicherten Werten
set(hObject,'Name',['AP - edit PEST settings (' TSP.sections{PP.edit_section_line,2} '; Track: ' TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,6} ')']);
%stimulus domain
%initial-level-Box auffüllen, maximaler Wert ist range
range=TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(1,1);
set(handles.pop_initial_level, 'String', [1:range]);
initial_level=TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,1};
if (initial_level==0) || (initial_level>range) %falls noch nicht zugewiesen oder zu groß (falls der range verkleinert wurde)
    initial_level=range;
end
set(handles.pop_initial_level, 'Value', initial_level); 

%initial/maximum-stepsize-Boxen aufbereiten, maximaler Wert ist die größte im
%Range enthaltene 2er-Potenz (stepsize_range_2pot ist die dazugehörige
%Potenz)
i=0;
while 2^i<=range
    i=i+1;
end
stepsize_range_2pot=i-1;
%werte bis zur höchsten ermittelten Potenz 2"hoch" werte in Boxen schreiben
set(handles.pop_initial_stepsize, 'String', 2.^[0:stepsize_range_2pot]);
set(handles.pop_maximum_stepsize, 'String', 2.^[0:stepsize_range_2pot]);
%vorauswahl abfragen und wenn vorhanden übernehmen, sonst zweitgrößten
%Eintrag bei initial und maximum übernehmen
initial_stepzize_2pot=TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,2};
maximum_stepzize_2pot=TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,8};
if (initial_stepzize_2pot<0) || (2^initial_stepzize_2pot>range) %falls noch nicht zugewiesen oder zu groß (falls der range verkleinert wurde)
    initial_stepzize_2pot=stepsize_range_2pot-1;
end
set(handles.pop_initial_stepsize, 'Value', initial_stepzize_2pot+1); %2er-Potenzen fangen bei 0 an, Values bei 1 
if (maximum_stepzize_2pot<0) || (2^maximum_stepzize_2pot>range) %falls noch nicht zugewiesen oder zu groß (falls der range verkleinert wurde)
    maximum_stepzize_2pot=stepsize_range_2pot-1;
end
set(handles.pop_maximum_stepsize, 'Value', maximum_stepzize_2pot+1); %2er-Potenzen fangen bei 0 an, Values bei 1 

% PEST version
if TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,3}==2 %GUI-Voreinstellung 1 (original)
    set(handles.rad_more_virulent,'Value', 1);
    set(handles.ed_M,'Enable', 'on');
    set(handles.ed_W,'Enable', 'off');
end
 
set(handles.ed_W, 'String', num2str(TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,4}))
set(handles.ed_M, 'String', num2str(TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,5}))
set(handles.ed_Pt, 'String', num2str(TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,6}))
set(handles.ed_termination_trials, 'String', num2str(TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,7}))
set(handles.cb_secondary_termination, 'Value', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,9});
if get(handles.cb_secondary_termination,'Value')==1
    set(handles.ed_termination_trials, 'Enable','On')
end

% --- Outputs from this function are returned to the command line.
function varargout = ap_edit_pest_settings_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function ed_M_Callback(hObject, eventdata, handles)
% hObject    handle to ed_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_M as text
%        str2double(get(hObject,'String')) returns contents of ed_M as a double

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function ed_M_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_W_Callback(hObject, eventdata, handles)
% hObject    handle to ed_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_W as text
%        str2double(get(hObject,'String')) returns contents of ed_W as a double

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function ed_W_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_initial_stepsize.
function pop_initial_stepsize_Callback(hObject, eventdata, handles)
% hObject    handle to pop_initial_stepsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_initial_stepsize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_initial_stepsize

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function pop_initial_stepsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_initial_stepsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_Pt_Callback(hObject, eventdata, handles)
% hObject    handle to ed_Pt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_Pt as text
%        str2double(get(hObject,'String')) returns contents of ed_Pt as a double

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function ed_Pt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_Pt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_initial_level.
function pop_initial_level_Callback(hObject, eventdata, handles)
% hObject    handle to pop_initial_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_initial_level contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_initial_level

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function pop_initial_level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_initial_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_termination_trials_Callback(hObject, eventdata, handles)
% hObject    handle to ed_termination_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_termination_trials as text
%        str2double(get(hObject,'String')) returns contents of ed_termination_trials as a double

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function ed_termination_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_termination_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,1}=get(handles.pop_initial_level,'Value');
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,2}=get(handles.pop_initial_stepsize,'Value')-1;
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,8}=get(handles.pop_maximum_stepsize,'Value')-1;
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,4}=str2num(get(handles.ed_W,'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,5}=str2num(get(handles.ed_M,'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,6}=str2num(get(handles.ed_Pt,'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,7}=str2num(get(handles.ed_termination_trials,'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,9}=get(handles.cb_secondary_termination,'Value');
save ([PP.path filesep 'TSP.mat'],'TSP');
close


% --- Executes when user attempts to close fig_edit_pest_settings.
function fig_edit_pest_settings_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_edit_pest_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
if PP.dontopenparent~=1
    ap_edit_track_settings
end
PP.dontopenparent=0;

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in rad_original.
function rad_original_Callback(hObject, eventdata, handles)
% hObject    handle to rad_original (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_original

global TSP PP
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,3}=1;
set(handles.rad_original,'Value', 1);
    set(handles.ed_M,'Enable', 'off');
    set(handles.ed_W,'Enable', 'on');
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in rad_more_virulent.
function rad_more_virulent_Callback(hObject, eventdata, handles)
% hObject    handle to rad_more_virulent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_more_virulent

global TSP PP
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,3}{1,3}=2;
set(handles.rad_more_virulent,'Value', 1);
    set(handles.ed_M,'Enable', 'on');
    set(handles.ed_W,'Enable', 'off');
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on selection change in pop_maximum_stepsize.
function pop_maximum_stepsize_Callback(hObject, eventdata, handles)
% hObject    handle to pop_maximum_stepsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_maximum_stepsize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_maximum_stepsize


% --- Executes during object creation, after setting all properties.
function pop_maximum_stepsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_maximum_stepsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cb_secondary_termination.
function cb_secondary_termination_Callback(hObject, eventdata, handles)
% hObject    handle to cb_secondary_termination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_secondary_termination

state=get(handles.cb_secondary_termination,'Value');
switch state
    case 0
        set(handles.ed_termination_trials,'Enable', 'Off');
    case 1
        set(handles.ed_termination_trials,'Enable', 'On');
end

