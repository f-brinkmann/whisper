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
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to configure_procedures_defaults_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help configure_procedures_defaults

% Last Modified by GUIDE v2.5 29-May-2010 17:55:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @configure_procedures_defaults_OpeningFcn, ...
                   'gui_OutputFcn',  @configure_procedures_defaults_OutputFcn, ...
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


% --- Executes just before configure_procedures_defaults is made visible.
function configure_procedures_defaults_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to configure_procedures_defaults (see VARARGIN)


% Choose default command line output for configure_procedures_defaults
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes configure_procedures_defaults wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global PP PC PS

% Standard-PC.mat laden, um später wissen zu können, ob Veränderungen
% vorlagen
global defaultPC
defaultPC = load('PC.mat');

% Aktivieren des gespeicherten Presets
if PS.selected_preset == 0
    selected_preset = 1;
else
    selected_preset = PS.selected_preset;
end

active_preset=['handles.tb_preset' num2str(selected_preset)];
presets = [1 2 3 4];
nonactive_presets = find(presets ~= selected_preset);

set( eval(active_preset),'Value', 1);
set( eval(active_preset),'ForegroundColor','black');
set( eval(active_preset),'BackgroundColor',[0.841 0.841 0.841]);

for i = 1: length(nonactive_presets)
    nonactive_preset = ['handles.tb_preset' num2str(nonactive_presets(i))];
    set( eval(nonactive_preset),'Value', 0);
    set( eval(nonactive_preset),'ForegroundColor',[0.941 0.941 0.941]);
    set( eval(nonactive_preset),'BackgroundColor',[0.702 0.702 0.702]);
end

% Felder auffüllen
fill_all_fields_with_saved_data(handles);
% Cancel und Write-Pushbuttons abschalten, is' schliesslich noch nix
% passiert
set(handles.pb_cancel,  'Enable', 'off'); set(handles.pb_save,  'Enable', 'off'); 
% Reset-Pushbutton nur ausschalten, wenn das aktualiter im Speicher
% befindliche PC-Preset dem unveränderten default entspricht (kann auch der
% Fall sein bei von PC.X.mat geladener PC!)
if isequal(defaultPC.PC, PC)
    set(handles.pb_reset,  'Enable', 'off');
end

PP.previous_selected_preset = selected_preset;







% --- Outputs from this function are returned to the command line.
function varargout = configure_procedures_defaults_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function ed_brk_btwn_trials_Callback(hObject, eventdata, handles)
% hObject    handle to ed_brk_btwn_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_brk_btwn_trials as text
%        str2double(get(hObject,'String')) returns contents of ed_brk_btwn_trials as a double

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


function ed_brk_btwn_trials_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');





% --- Executes during object creation, after setting all properties.
function ed_brk_btwn_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_brk_btwn_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ed_initial_instructions.
function ed_initial_instructions_Callback(hObject, eventdata, handles)
% hObject    handle to ed_initial_instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ed_initial_instructions contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ed_initial_instructions


% --- Executes during object creation, after setting all properties.
function ed_initial_instructions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_initial_instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ed_short_instructions.
function ed_short_instructions_Callback(hObject, eventdata, handles)
% hObject    handle to ed_short_instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ed_short_instructions contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ed_short_instructions


% --- Executes during object creation, after setting all properties.
function ed_short_instructions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_short_instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% % --- Executes on button press in cb_use_multisession.
% function cb_use_multisession_Callback(hObject, eventdata, handles)
% % hObject    handle to cb_use_multisession (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of cb_use_multisession
% 
%  %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
%  %User möglicherweise Rückgängig machen will
%  
% set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes on selection change in pop_paradigm_selection.
function pop_paradigm_selection_Callback(hObject, eventdata, handles)
% hObject    handle to pop_paradigm_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_paradigm_selection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_paradigm_selection

 %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function pop_paradigm_selection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_paradigm_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_adaptive_mechanism.
function pop_adaptive_mechanism_Callback(hObject, eventdata, handles)
% hObject    handle to pop_adaptive_mechanism (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_adaptive_mechanism contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_adaptive_mechanism

 %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function pop_adaptive_mechanism_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_adaptive_mechanism (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_nAFC_num_intervals_Callback(hObject, eventdata, handles)
% hObject    handle to ed_nAFC_num_intervals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_nAFC_num_intervals as text
%        str2double(get(hObject,'String')) returns contents of ed_nAFC_num_intervals as a double

function ed_nAFC_num_intervals_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');




% --- Executes during object creation, after setting all properties.
function ed_nAFC_num_intervals_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_nAFC_num_intervals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_nAFC_brk_btwn_trials_Callback(hObject, eventdata, handles)
% hObject    handle to ed_nAFC_brk_btwn_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_nAFC_brk_btwn_trials as text
%        str2double(get(hObject,'String')) returns contents of ed_nAFC_brk_btwn_trials as a double

function ed_nAFC_brk_btwn_trials_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');




% --- Executes during object creation, after setting all properties.
function ed_nAFC_brk_btwn_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_nAFC_brk_btwn_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_psyfun.
function pop_psyfun_Callback(hObject, eventdata, handles)
% hObject    handle to pop_psyfun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_psyfun contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_psyfun

 %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function pop_psyfun_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_psyfun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_beta_Callback(hObject, eventdata, handles)
% hObject    handle to ed_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_beta as text
%        str2double(get(hObject,'String')) returns contents of ed_beta as a double

function ed_beta_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_gamma_Callback(hObject, eventdata, handles)
% hObject    handle to ed_gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_gamma as text
%        str2double(get(hObject,'String')) returns contents of ed_gamma as a double

function ed_gamma_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_lambda_Callback(hObject, eventdata, handles)
% hObject    handle to ed_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_lambda as text
%        str2double(get(hObject,'String')) returns contents of ed_lambda as a double

function ed_lambda_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_lambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_epsilon_Callback(hObject, eventdata, handles)
% hObject    handle to ed_epsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_epsilon as text
%        str2double(get(hObject,'String')) returns contents of ed_epsilon as a double

function ed_epsilon_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_epsilon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_epsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_pdftyp.
function pop_pdftyp_Callback(hObject, eventdata, handles)
% hObject    handle to pop_pdftyp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_pdftyp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_pdftyp

 %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function pop_pdftyp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_pdftyp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cb_exclude_prior.
function cb_exclude_prior_Callback(hObject, eventdata, handles)
% hObject    handle to cb_exclude_prior (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_exclude_prior



function ed_mean_Callback(hObject, eventdata, handles)
% hObject    handle to ed_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_mean as text
%        str2double(get(hObject,'String')) returns contents of ed_mean as a double

function ed_mean_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_mean_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stddev_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stddev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stddev as text
%        str2double(get(hObject,'String')) returns contents of ed_stddev as a double

function ed_stddev_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_stddev_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stddev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_A_Callback(hObject, eventdata, handles)
% hObject    handle to ed_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_A as text
%        str2double(get(hObject,'String')) returns contents of ed_A as a double

function ed_A_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_t_Callback(hObject, eventdata, handles)
% hObject    handle to ed_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_t as text
%        str2double(get(hObject,'String')) returns contents of ed_t as a double

function ed_t_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_t_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_B_Callback(hObject, eventdata, handles)
% hObject    handle to ed_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_B as text
%        str2double(get(hObject,'String')) returns contents of ed_B as a double

function ed_B_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_B_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_C_Callback(hObject, eventdata, handles)
% hObject    handle to ed_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_C as text
%        str2double(get(hObject,'String')) returns contents of ed_C as a double

function ed_C_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_C_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_meas_centr_tendency.
function pop_meas_centr_tendency_Callback(hObject, eventdata, handles)
% hObject    handle to pop_meas_centr_tendency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_meas_centr_tendency contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_meas_centr_tendency

 %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function pop_meas_centr_tendency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_meas_centr_tendency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_termination.
function pop_termination_Callback(hObject, eventdata, handles)
% hObject    handle to pop_termination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_termination contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_termination

 %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function pop_termination_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_termination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_num_trials_Callback(hObject, eventdata, handles)
% hObject    handle to ed_num_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_num_trials as text
%        str2double(get(hObject,'String')) returns contents of ed_num_trials as a double

function ed_num_trials_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_num_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_num_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_conf_max_width_Callback(hObject, eventdata, handles)
% hObject    handle to ed_conf_max_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_conf_max_width as text
%        str2double(get(hObject,'String')) returns contents of ed_conf_max_width as a double

function ed_conf_max_width_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_conf_max_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_conf_max_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_conf_level_Callback(hObject, eventdata, handles)
% hObject    handle to ed_conf_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_conf_level as text
%        str2double(get(hObject,'String')) returns contents of ed_conf_level as a double

function ed_conf_level_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_conf_level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_conf_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cb_mlbayes_sec_termination.
function cb_mlbayes_sec_termination_Callback(hObject, eventdata, handles)
% hObject    handle to cb_mlbayes_sec_termination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_mlbayes_sec_termination

set(handles.pb_cancel,  'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



function ed_mlbayes_jumpout_after_Callback(hObject, eventdata, handles)
% hObject    handle to ed_mlbayes_jumpout_after (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_mlbayes_jumpout_after as text
%        str2double(get(hObject,'String')) returns contents of ed_mlbayes_jumpout_after as a double

function ed_mlbayes_jumpout_after_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_mlbayes_jumpout_after_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_mlbayes_jumpout_after (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_initial_level_Callback(hObject, eventdata, handles)
% hObject    handle to ed_initial_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_initial_level as text
%        str2double(get(hObject,'String')) returns contents of ed_initial_level as a double

function ed_initial_level_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_initial_level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_initial_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_initial_stepsize_Callback(hObject, eventdata, handles)
% hObject    handle to ed_initial_stepsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_initial_stepsize as text
%        str2double(get(hObject,'String')) returns contents of ed_initial_stepsize as a double

function ed_initial_stepsize_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_initial_stepsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_initial_stepsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_pest_version.
function pop_pest_version_Callback(hObject, eventdata, handles)
% hObject    handle to pop_pest_version (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_pest_version contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_pest_version

 %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function pop_pest_version_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_pest_version (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
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

function ed_W_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



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



function ed_M_Callback(hObject, eventdata, handles)
% hObject    handle to ed_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_M as text
%        str2double(get(hObject,'String')) returns contents of ed_M as a double

function ed_M_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



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



function ed_target_proba_Callback(hObject, eventdata, handles)
% hObject    handle to ed_target_proba (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_target_proba as text
%        str2double(get(hObject,'String')) returns contents of ed_target_proba as a double

function ed_target_proba_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_target_proba_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_target_proba (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_pest_jumpout_after_Callback(hObject, eventdata, handles)
% hObject    handle to ed_pest_jumpout_after (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_pest_jumpout_after as text
%        str2double(get(hObject,'String')) returns contents of ed_pest_jumpout_after as a double

function ed_pest_jumpout_after_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_pest_jumpout_after_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_pest_jumpout_after (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_max_stepsize_Callback(hObject, eventdata, handles)
% hObject    handle to ed_max_stepsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_max_stepsize as text
%        str2double(get(hObject,'String')) returns contents of ed_max_stepsize as a double

function ed_max_stepsize_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_max_stepsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_max_stepsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cb_pest_sec_termination.
function cb_pest_sec_termination_Callback(hObject, eventdata, handles)
% hObject    handle to cb_pest_sec_termination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_pest_sec_termination

 %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes on button press in cb_halve_stepsize.
function cb_halve_stepsize_Callback(hObject, eventdata, handles)
% hObject    handle to cb_halve_stepsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_halve_stepsize

 %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');




function ed_yUP1DOWN_Callback(hObject, eventdata, handles)
% hObject    handle to ed_yUP1DOWN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_yUP1DOWN as text
%        str2double(get(hObject,'String')) returns contents of ed_yUP1DOWN as a double

function ed_yUP1DOWN_KeyPressFcn(hObject, eventdata, handles)
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');

% --- Executes during object creation, after setting all properties.
function ed_yUP1DOWN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_yUP1DOWN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_num_reversals_Callback(hObject, eventdata, handles)
% hObject    handle to ed_num_reversals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_num_reversals as text
%        str2double(get(hObject,'String')) returns contents of ed_num_reversals as a double

function ed_num_reversals_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_num_reversals_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_num_reversals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_jumpout_after_Callback(hObject, eventdata, handles)
% hObject    handle to ed_jumpout_after (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_jumpout_after as text
%        str2double(get(hObject,'String')) returns contents of ed_jumpout_after as a double

function ed_jumpout_after_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_jumpout_after_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_jumpout_after (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_avrge_reversals_Callback(hObject, eventdata, handles)
% hObject    handle to ed_avrge_reversals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_avrge_reversals as text
%        str2double(get(hObject,'String')) returns contents of ed_avrge_reversals as a double

function ed_avrge_reversals_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function ed_avrge_reversals_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_avrge_reversals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cb_sec_term.
function cb_sec_term_Callback(hObject, eventdata, handles)
% hObject    handle to cb_sec_term (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_sec_term

 %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on');  set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on button press in pb_save.
function pb_save_Callback(hObject, eventdata, handles)
% hObject    handle to pb_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP

selected_preset = 1*get(handles.tb_preset1, 'Value') ...
                + 2*get(handles.tb_preset2, 'Value') ...
                + 3*get(handles.tb_preset3, 'Value') ...
                + 4*get(handles.tb_preset4, 'Value');
            
PP.previous_selected_preset = selected_preset;
write_all_data_to_preset(handles)

set(handles.pb_cancel,'Enable', 'off');
set(handles.pb_save,  'Enable', 'off');





% --- Executes on button press in pb_cancel.
function pb_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close

% --- Executes during object creation, after setting all properties.
function pb_cancel_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in pb_reset.
function pb_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pb_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 % reset der geladenen PC
clear global PC
global PC PP

% Laden der Standard-PC
load 'PC.mat';

% Wird auch automatisch gespeichert -> sonst undefiniertes bzw. inkonsistentes
% Verhalten bei Reset und Schließen und Wiederöffnen des Konfigdialogs im 
% zu der dann geladenen Einstellung nach Programmneustart!
selected_preset = 1*get(handles.tb_preset1, 'Value') ...
                + 2*get(handles.tb_preset2, 'Value') ...
                + 3*get(handles.tb_preset3, 'Value') ...
                + 4*get(handles.tb_preset4, 'Value');
            
PP.previous_selected_preset = selected_preset;
write_all_data_to_preset(handles)

% schliesslich: Laden der Werte in die Felder...
fill_all_fields_with_saved_data(handles)

set(handles.pb_cancel,'Enable', 'off'); set(handles.pb_save,'Enable', 'off'); set(handles.pb_reset,'Enable', 'off');




function ed_nAFC_range_Callback(hObject, eventdata, handles)
% hObject    handle to ed_nAFC_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_nAFC_range as text
%        str2double(get(hObject,'String')) returns contents of ed_nAFC_range as a double


function ed_nAFC_range_KeyPressFcn(hObject, eventdata, handles)
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der
 %User möglicherweise Rückgängig machen will
 
set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function ed_nAFC_range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_nAFC_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fill_all_fields_with_saved_data(handles)

global PC

set(handles.ed_brk_btwn_trials,        'String', PC.testing_procedures{1,3}{1,1});
set(handles.ed_initial_instructions,   'String', PC.testing_procedures{1,3}{1,2});
set(handles.ed_short_instructions,     'String', PC.testing_procedures{1,3}{1,3});
    use_multisession = PC.testing_procedures{1,3}{1,4}{1,1} - 1; % da 2=ja, 1=nein.
set(handles.rad_use_multisession,      'Value',  use_multisession); 
set(handles.rad_interleave,            'Value',  ~use_multisession);
set(handles.pop_paradigm_selection,    'Value',  PC.testing_procedures{1,3}{1,5});
    adaptive_mechanisms = [1 2 31 32 33];
set(handles.pop_adaptive_mechanism,    'Value',  find(adaptive_mechanisms==PC.testing_procedures{1,3}{1,7}{2,1}));
set(handles.ed_nAFC_num_intervals,     'String', PC.testing_procedures{1,3}{1,8}{1,1});
set(handles.ed_nAFC_brk_btwn_trials,   'String', PC.testing_procedures{1,3}{1,8}{1,2});
set(handles.ed_nAFC_range,             'String', PC.testing_procedures{1,3}{1,7}{1,1}(1,1));
set(handles.pop_psyfun,                'Value',  PC.testing_procedures{1,3}{1,7}{1,4}{1,15});
set(handles.ed_beta,                   'String', PC.testing_procedures{1,3}{1,7}{1,4}{1,1});
set(handles.ed_gamma,                  'String', PC.testing_procedures{1,3}{1,7}{1,4}{1,2});
set(handles.ed_lambda,                 'String', PC.testing_procedures{1,3}{1,7}{1,4}{1,3});
set(handles.ed_epsilon,                'String', PC.testing_procedures{1,3}{1,7}{1,4}{1,16});
    pdf_types = [1 2 4 3];   % muss man hier so machen, da die mod.hyp.pdf auch im GUI an 3. Stelle kommt, aus Kompatibilitätsgründen aber den 4. Index hat.
set(handles.pop_pdftyp,                'Value',  find(pdf_types==PC.testing_procedures{1,3}{1,7}{1,4}{1,5}));
set(handles.cb_exclude_prior,          'Value',  PC.testing_procedures{1,3}{1,7}{1,4}{1,4});
set(handles.ed_mean,                   'String', PC.testing_procedures{1,3}{1,7}{1,4}{1,6});
set(handles.ed_stddev,                 'String', PC.testing_procedures{1,3}{1,7}{1,4}{1,7});
set(handles.ed_A,                      'String', PC.testing_procedures{1,3}{1,7}{1,4}{1,18});
set(handles.ed_t,                      'String', PC.testing_procedures{1,3}{1,7}{1,4}{1,20});
set(handles.ed_B,                      'String', PC.testing_procedures{1,3}{1,7}{1,4}{1,19});
set(handles.ed_C,                      'String', PC.testing_procedures{1,3}{1,7}{1,4}{1,21});
set(handles.pop_meas_centr_tendency,   'Value',  PC.testing_procedures{1,3}{1,7}{1,4}{1,8});
set(handles.pop_termination,           'Value',  PC.testing_procedures{1,3}{1,7}{1,4}{1,9});
set(handles.ed_num_trials,             'String', PC.testing_procedures{1,3}{1,7}{1,4}{1,10});
set(handles.ed_conf_max_width,         'String', PC.testing_procedures{1,3}{1,7}{1,4}{1,11});
set(handles.ed_conf_level,             'String', PC.testing_procedures{1,3}{1,7}{1,4}{1,12});
set(handles.cb_mlbayes_sec_termination,'Value',  PC.testing_procedures{1,3}{1,7}{1,4}{1,13});
set(handles.ed_mlbayes_jumpout_after,  'String', PC.testing_procedures{1,3}{1,7}{1,4}{1,14});
set(handles.ed_pest_initial_level,     'String', PC.testing_procedures{1,3}{1,7}{1,3}{1,1});
set(handles.ed_initial_stepsize,       'String', PC.testing_procedures{1,3}{1,7}{1,3}{1,2});
set(handles.pop_pest_version,          'Value',  PC.testing_procedures{1,3}{1,7}{1,3}{1,3});
set(handles.ed_W,                      'String', PC.testing_procedures{1,3}{1,7}{1,3}{1,4});
set(handles.ed_M,                      'String', PC.testing_procedures{1,3}{1,7}{1,3}{1,5});
set(handles.ed_target_proba,           'String', PC.testing_procedures{1,3}{1,7}{1,3}{1,6});
set(handles.ed_pest_jumpout_after,     'String', PC.testing_procedures{1,3}{1,7}{1,3}{1,7});
set(handles.ed_max_stepsize,           'String', PC.testing_procedures{1,3}{1,7}{1,3}{1,8});
set(handles.cb_pest_sec_termination,   'Value',  PC.testing_procedures{1,3}{1,7}{1,3}{1,9});
set(handles.cb_halve_stepsize,         'Value',  PC.testing_procedures{1,3}{1,7}{1,2}{1,1});
set(handles.ed_initial_level,          'String', PC.testing_procedures{1,3}{1,7}{1,2}{1,3});
set(handles.ed_yUP1DOWN,               'String', PC.testing_procedures{1,3}{1,7}{1,2}{1,4});
set(handles.ed_num_reversals,          'String', PC.testing_procedures{1,3}{1,7}{1,2}{1,5});
set(handles.ed_jumpout_after,          'String', PC.testing_procedures{1,3}{1,7}{1,2}{1,6});
set(handles.ed_avrge_reversals,        'String', PC.testing_procedures{1,3}{1,7}{1,2}{1,7});
set(handles.cb_sec_term,               'Value',  PC.testing_procedures{1,3}{1,7}{1,2}{1,8});

    triads_multisession = PC.testing_procedures{2,4}{1,2}{1,1} - 1; % da 2=ja, 1= nein
set(handles.cb_all_triads,             'Value',  ~triads_multisession);
set(handles.cb_manually_selected_triads,'Value',  PC.testing_procedures{2,4}{1,2}{1,3} - 1);
set(handles.pop_maxnum_constructs,     'Value',  PC.testing_procedures{2,4}{1,3});
set(handles.ed_rgt1_init_instructions, 'String', PC.testing_procedures{2,4}{1,4});
set(handles.ed_rgt1_short_instructions,'String', PC.testing_procedures{2,4}{1,5});
    elements_multisession = PC.testing_procedures{2,3}{1,6}{1,1} - 1; % da 2=ja, 1= nein
set(handles.cb_rgt2_all_elements,      'Value',  ~elements_multisession);
set(handles.cb_rgt2_selected_elements, 'Value',  PC.testing_procedures{2,3}{1,6}{1,3} - 1);
set(handles.ed_rgt2_brk_between_trials,'String', PC.testing_procedures{2,3}{1,7});
set(handles.ed_rgt2_init_instructions, 'String', PC.testing_procedures{2,3}{1,8});
set(handles.ed_rgt2_short_instructions,'String', PC.testing_procedures{2,3}{1,9});
    objects_multisession = PC.testing_procedures{3,3}{1,6}{1,1} - 1; % da 2=ja, 1= nein
set(handles.cb_sd_all_objects,         'Value',  ~objects_multisession);
set(handles.cb_sd_selected_objects,    'Value',  PC.testing_procedures{3,3}{1,6}{1,3} - 1);
set(handles.ed_sd_brk_between_trials,  'String', PC.testing_procedures{3,3}{1,7});
set(handles.ed_sd_init_instructions,   'String', PC.testing_procedures{3,3}{1,8});
set(handles.ed_sd_short_instructions,  'String', PC.testing_procedures{3,3}{1,9});

set(handles.ed_abx_init_instructions,  'String', PC.testing_procedures{4,3}{1,2});
set(handles.ed_abx_short_instructions, 'String', PC.testing_procedures{4,3}{1,3});
set(handles.ed_abx_num_trials,         'String', PC.testing_procedures{4,3}{1,4}{1,1});
set(handles.ed_abx_num_correct_answers,'String', PC.testing_procedures{4,3}{1,4}{1,2});
set(handles.ed_abx_sig_level,          'String', PC.testing_procedures{4,3}{1,4}{1,3});
set(handles.ed_abx_risk_beta,          'String', PC.testing_procedures{4,3}{1,4}{1,4}); % Vorläufig
set(handles.ed_abx_effect_size,        'String', PC.testing_procedures{4,3}{1,4}{1,6}); % Vorläufig
set(handles.cb_abx_randomize,          'Value',  str2num(PC.testing_procedures{4,3}{1,1}));

set(handles.ed_stimulus_default_name,           'String', PC.emptydata_stimulus{1,1});
set(handles.ed_stimulus_server1_presend_pause,  'String', PC.emptydata_stimulus_osc{1,1});
set(handles.ed_stimulus_server1_oscpath,        'String', PC.emptydata_stimulus_osc{1,2});
    datatypes = ['s' 'i' 'f' 'T' 'F'];
set(handles.pop_stimulus_server1_datatype,      'Value',  findstr(PC.emptydata_stimulus_osc{1,3}, datatypes));
set(handles.ed_stimulus_server1_oscdata,        'String', PC.emptydata_stimulus_osc{1,4});

set(handles.ed_stimulus_server2_presend_pause,  'String', PC.emptydata_stimulus_osc{2,1});
set(handles.ed_stimulus_server2_oscpath,        'String', PC.emptydata_stimulus_osc{2,2});
set(handles.pop_stimulus_server2_datatype,      'Value',  findstr(PC.emptydata_stimulus_osc{2,3}, datatypes));
set(handles.ed_stimulus_server2_oscdata,        'String', PC.emptydata_stimulus_osc{2,4});

set(handles.ed_stimulus_server3_presend_pause,  'String', PC.emptydata_stimulus_osc{3,1});
set(handles.ed_stimulus_server3_oscpath,        'String', PC.emptydata_stimulus_osc{3,2});
set(handles.pop_stimulus_server3_datatype,      'Value',  findstr(PC.emptydata_stimulus_osc{3,3}, datatypes));
set(handles.ed_stimulus_server3_oscdata,        'String', PC.emptydata_stimulus_osc{3,4});

set(handles.ed_stimulus_server4_presend_pause,  'String', PC.emptydata_stimulus_osc{4,1});
set(handles.ed_stimulus_server4_oscpath,        'String', PC.emptydata_stimulus_osc{4,2});
set(handles.pop_stimulus_server4_datatype,      'Value',  findstr(PC.emptydata_stimulus_osc{4,3}, datatypes));
set(handles.ed_stimulus_server4_oscdata,        'String', PC.emptydata_stimulus_osc{4,4});

set(handles.ed_stimulus_server5_presend_pause,  'String', PC.emptydata_stimulus_osc{5,1});
set(handles.ed_stimulus_server5_oscpath,        'String', PC.emptydata_stimulus_osc{5,2});
set(handles.pop_stimulus_server5_datatype,      'Value',  findstr(PC.emptydata_stimulus_osc{5,3}, datatypes));
set(handles.ed_stimulus_server5_oscdata,        'String', PC.emptydata_stimulus_osc{5,4});

set(handles.ed_stimulus_server6_presend_pause,  'String', PC.emptydata_stimulus_osc{6,1});
set(handles.ed_stimulus_server6_oscpath,        'String', PC.emptydata_stimulus_osc{6,2});
set(handles.pop_stimulus_server6_datatype,      'Value',  findstr(PC.emptydata_stimulus_osc{6,3}, datatypes));
set(handles.ed_stimulus_server6_oscdata,        'String', PC.emptydata_stimulus_osc{6,4});


% --- Executes on key press with focus on ed_pest_initial_level and none of its controls.
function ed_pest_initial_level_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_pest_initial_level (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_short_instructions and none of its controls.
function ed_short_instructions_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_short_instructions (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_initial_instructions and none of its controls.
function ed_initial_instructions_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_initial_instructions (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


function write_all_data_to_preset(handles)

global PC PP defaultPC


if isequal(get(handles.pb_cancel, 'Enable'),'on'); % was nur nach Veränderungen der Fall ist 
    % disp(['setting and writing to ' num2str(PP.previous_selected_preset)])
    PC.testing_procedures{1,3}{1,1}           =             str2num(get(handles.ed_brk_btwn_trials,        'String'));
    PC.testing_procedures{1,3}{1,2}           =             cellstr(get(handles.ed_initial_instructions,   'String'));
    PC.testing_procedures{1,3}{1,3}           =             cellstr(get(handles.ed_short_instructions,     'String'));
        multisession_use = 2*get(handles.rad_use_multisession, 'Value') + 1* get(handles.rad_interleave, 'Value'); % da 2=ja, 1=nein
    PC.testing_procedures{1,3}{1,4}{1,1}      =             multisession_use;
    PC.testing_procedures{1,3}{1,5}           =                     get(handles.pop_paradigm_selection,    'Value');
        adaptive_mechanisms = [1 2 31 32 33];
    PC.testing_procedures{1,3}{1,7}{2,1}      = adaptive_mechanisms(get(handles.pop_adaptive_mechanism,    'Value'));
    PC.testing_procedures{1,3}{1,8}{1,1}      =             str2num(get(handles.ed_nAFC_num_intervals,     'String'));
    PC.testing_procedures{1,3}{1,8}{1,2}      =             str2num(get(handles.ed_nAFC_brk_btwn_trials,   'String'));
    PC.testing_procedures{1,3}{1,7}{1,1}(1,1) =             str2num(get(handles.ed_nAFC_range,             'String'));
    PC.testing_procedures{1,3}{1,7}{1,4}{1,15}=                     get(handles.pop_psyfun,                'Value');
    PC.testing_procedures{1,3}{1,7}{1,4}{1,1} =             str2num(get(handles.ed_beta,                   'String'));
    PC.testing_procedures{1,3}{1,7}{1,4}{1,2} =             str2num(get(handles.ed_gamma,                  'String'));
    PC.testing_procedures{1,3}{1,7}{1,4}{1,3} =             str2num(get(handles.ed_lambda,                 'String'));
    PC.testing_procedures{1,3}{1,7}{1,4}{1,16}=             str2num(get(handles.ed_epsilon,                'String'));
        pdf_types = [1 2 4 3];   % muss man hier so machen, da die mod.hyp.pdf auch im GUI an 3. Stelle kommt, aus Kompatibilitätsgründen aber den 4. Index hat.
    PC.testing_procedures{1,3}{1,7}{1,4}{1,5} =           pdf_types(get(handles.pop_pdftyp,                'Value'));
    PC.testing_procedures{1,3}{1,7}{1,4}{1,4} =                     get(handles.cb_exclude_prior,          'Value');
    PC.testing_procedures{1,3}{1,7}{1,4}{1,6} =             str2num(get(handles.ed_mean,                   'String'));
    PC.testing_procedures{1,3}{1,7}{1,4}{1,7} =             str2num(get(handles.ed_stddev,                 'String'));
    PC.testing_procedures{1,3}{1,7}{1,4}{1,18}=             str2num(get(handles.ed_A,                      'String'));
    PC.testing_procedures{1,3}{1,7}{1,4}{1,20}=             str2num(get(handles.ed_t,                      'String'));
    PC.testing_procedures{1,3}{1,7}{1,4}{1,19}=             str2num(get(handles.ed_B,                      'String'));
    PC.testing_procedures{1,3}{1,7}{1,4}{1,21}=             str2num(get(handles.ed_C,                      'String'));
    PC.testing_procedures{1,3}{1,7}{1,4}{1,8} =                     get(handles.pop_meas_centr_tendency,   'Value');
    PC.testing_procedures{1,3}{1,7}{1,4}{1,9} =                     get(handles.pop_termination,           'Value');
    PC.testing_procedures{1,3}{1,7}{1,4}{1,10}=             str2num(get(handles.ed_num_trials,             'String'));
    PC.testing_procedures{1,3}{1,7}{1,4}{1,11}=       round(str2num(get(handles.ed_conf_max_width,         'String')));
    PC.testing_procedures{1,3}{1,7}{1,4}{1,12}=             str2num(get(handles.ed_conf_level,             'String'));
    PC.testing_procedures{1,3}{1,7}{1,4}{1,13}=                     get(handles.cb_mlbayes_sec_termination,'Value');
    PC.testing_procedures{1,3}{1,7}{1,4}{1,14}=             str2num(get(handles.ed_mlbayes_jumpout_after,  'String'));
    PC.testing_procedures{1,3}{1,7}{1,3}{1,1} =             str2num(get(handles.ed_pest_initial_level,     'String'));
    PC.testing_procedures{1,3}{1,7}{1,3}{1,2} =             str2num(get(handles.ed_initial_stepsize,       'String'));
    PC.testing_procedures{1,3}{1,7}{1,3}{1,3} =                     get(handles.pop_pest_version,          'Value');
    PC.testing_procedures{1,3}{1,7}{1,3}{1,4} =             str2num(get(handles.ed_W,                      'String'));
    PC.testing_procedures{1,3}{1,7}{1,3}{1,5} =             str2num(get(handles.ed_M,                      'String'));
    PC.testing_procedures{1,3}{1,7}{1,3}{1,6} =             str2num(get(handles.ed_target_proba,           'String'));
    PC.testing_procedures{1,3}{1,7}{1,3}{1,7} =             str2num(get(handles.ed_pest_jumpout_after,     'String'));
    PC.testing_procedures{1,3}{1,7}{1,3}{1,8} =             str2num(get(handles.ed_max_stepsize,           'String'));
    PC.testing_procedures{1,3}{1,7}{1,3}{1,9} =                     get(handles.cb_pest_sec_termination,   'Value');
    PC.testing_procedures{1,3}{1,7}{1,2}{1,1} =                     get(handles.cb_halve_stepsize,         'Value');
    PC.testing_procedures{1,3}{1,7}{1,2}{1,3} =             str2num(get(handles.ed_initial_level,          'String'));
    PC.testing_procedures{1,3}{1,7}{1,2}{1,4} =             str2num(get(handles.ed_yUP1DOWN,               'String'));
    PC.testing_procedures{1,3}{1,7}{1,2}{1,5} =             str2num(get(handles.ed_num_reversals,          'String'));
    PC.testing_procedures{1,3}{1,7}{1,2}{1,6} =             str2num(get(handles.ed_jumpout_after,          'String'));
    PC.testing_procedures{1,3}{1,7}{1,2}{1,7} =             str2num(get(handles.ed_avrge_reversals,        'String'));
    PC.testing_procedures{1,3}{1,7}{1,2}{1,8} =                     get(handles.cb_sec_term,               'Value');

       multisession_triads =                                      ~(get(handles.cb_all_triads,              'Value')) + 1; % da 2=ja, 1= nein
    PC.testing_procedures{2,4}{1,2}{1,1}      =          multisession_triads;
    PC.testing_procedures{2,4}{1,2}{1,3}      =                     get(handles.cb_manually_selected_triads,'Value') + 1;
    PC.testing_procedures{2,4}{1,3}           =                     get(handles.pop_maxnum_constructs,     'Value');
    PC.testing_procedures{2,4}{1,4}           =             cellstr(get(handles.ed_rgt1_init_instructions, 'String'));
    PC.testing_procedures{2,4}{1,5}           =             cellstr(get(handles.ed_rgt1_short_instructions,'String'));
        multisession_elements =                                   ~(get(handles.cb_rgt2_all_elements,      'Value')) + 1; % da 2=ja, 1= nein
    PC.testing_procedures{2,3}{1,6}{1,1}      =          multisession_elements;
    PC.testing_procedures{2,3}{1,6}{1,3}      =                     get(handles.cb_rgt2_selected_elements, 'Value') + 1;
    PC.testing_procedures{2,3}{1,7}           =             str2num(get(handles.ed_rgt2_brk_between_trials,'String'));
    PC.testing_procedures{2,3}{1,8}           =             cellstr(get(handles.ed_rgt2_init_instructions, 'String'));
    PC.testing_procedures{2,3}{1,9}           =             cellstr(get(handles.ed_rgt2_short_instructions,'String'));
        multisession_objects                  =                   ~(get(handles.cb_sd_all_objects,         'Value')) + 1; % da 2=ja, 1= nein
    PC.testing_procedures{3,3}{1,6}{1,1}      =          multisession_objects;
    PC.testing_procedures{3,3}{1,6}{1,3}      =                     get(handles.cb_sd_selected_objects,    'Value') + 1;
    PC.testing_procedures{3,3}{1,7}           =             str2num(get(handles.ed_sd_brk_between_trials,  'String'));
    PC.testing_procedures{3,3}{1,8}           =             cellstr(get(handles.ed_sd_init_instructions,   'String'));
    PC.testing_procedures{3,3}{1,9}           =             cellstr(get(handles.ed_sd_short_instructions,  'String'));

    PC.testing_procedures{4,3}{1,2}           =             cellstr(get(handles.ed_abx_init_instructions,  'String'));
    PC.testing_procedures{4,3}{1,3}           =             cellstr(get(handles.ed_abx_short_instructions, 'String'));
    PC.testing_procedures{4,3}{1,4}{1,1}      =             str2num(get(handles.ed_abx_num_trials,         'String'));
    PC.testing_procedures{4,3}{1,4}{1,2}      =             str2num(get(handles.ed_abx_num_correct_answers,'String'));
    PC.testing_procedures{4,3}{1,4}{1,3}      =             str2num(get(handles.ed_abx_sig_level,          'String'));
    PC.testing_procedures{4,3}{1,4}{1,4}      =             str2num(get(handles.ed_abx_risk_beta,          'String')); % Vorläufig
    PC.testing_procedures{4,3}{1,4}{1,6}      =             str2num(get(handles.ed_abx_effect_size,        'String')); % Vorläufig
    PC.testing_procedures{4,3}{1,1}           =             num2str(get(handles.cb_abx_randomize,          'Value'));

    PC.emptydata_stimulus{1,1}                    =                     get(handles.ed_stimulus_default_name,          'String');
    PC.emptydata_stimulus_osc{1,1}                =             str2num(get(handles.ed_stimulus_server1_presend_pause, 'String'));
    PC.emptydata_stimulus_osc{1,2}                =                     get(handles.ed_stimulus_server1_oscpath,       'String');
        datatypes = ['s' 'i' 'f' 'T' 'F'];
    PC.emptydata_stimulus_osc{1,3}                =           datatypes(get(handles.pop_stimulus_server1_datatype,    'Value'));
    PC.emptydata_stimulus_osc{1,4}                =                     get(handles.ed_stimulus_server1_oscdata,      'String');

    PC.emptydata_stimulus_osc{2,1}                =             str2num(get(handles.ed_stimulus_server2_presend_pause, 'String'));
    PC.emptydata_stimulus_osc{2,2}                =                     get(handles.ed_stimulus_server2_oscpath,       'String');
    PC.emptydata_stimulus_osc{2,3}                =           datatypes(get(handles.pop_stimulus_server2_datatype,    'Value'));
    PC.emptydata_stimulus_osc{2,4}                =                     get(handles.ed_stimulus_server2_oscdata,      'String');

    PC.emptydata_stimulus_osc{3,1}                =             str2num(get(handles.ed_stimulus_server3_presend_pause, 'String'));
    PC.emptydata_stimulus_osc{3,2}                =                     get(handles.ed_stimulus_server3_oscpath,       'String');
    PC.emptydata_stimulus_osc{3,3}                =           datatypes(get(handles.pop_stimulus_server3_datatype,    'Value'));
    PC.emptydata_stimulus_osc{3,4}                =                     get(handles.ed_stimulus_server3_oscdata,      'String');

    PC.emptydata_stimulus_osc{4,1}                =             str2num(get(handles.ed_stimulus_server4_presend_pause, 'String'));
    PC.emptydata_stimulus_osc{4,2}                =                     get(handles.ed_stimulus_server4_oscpath,       'String');
    PC.emptydata_stimulus_osc{4,3}                =           datatypes(get(handles.pop_stimulus_server4_datatype,    'Value'));
    PC.emptydata_stimulus_osc{4,4}                =                     get(handles.ed_stimulus_server4_oscdata,      'String');

    PC.emptydata_stimulus_osc{5,1}                =             str2num(get(handles.ed_stimulus_server5_presend_pause, 'String'));
    PC.emptydata_stimulus_osc{5,2}                =                     get(handles.ed_stimulus_server5_oscpath,       'String');
    PC.emptydata_stimulus_osc{5,3}                =           datatypes(get(handles.pop_stimulus_server5_datatype,    'Value'));
    PC.emptydata_stimulus_osc{5,4}                =                     get(handles.ed_stimulus_server5_oscdata,      'String');

    PC.emptydata_stimulus_osc{6,1}                =             str2num(get(handles.ed_stimulus_server6_presend_pause, 'String'));
    PC.emptydata_stimulus_osc{6,2}                =                     get(handles.ed_stimulus_server6_oscpath,       'String');
    PC.emptydata_stimulus_osc{6,3}                =           datatypes(get(handles.pop_stimulus_server6_datatype,    'Value'));
    PC.emptydata_stimulus_osc{6,4}                =                     get(handles.ed_stimulus_server6_oscdata,      'String');
else
    % disp('writing from unchanged memory')
end

preset_to_write = PP.previous_selected_preset;
            
PCpresetfile = ['PC.'  num2str(preset_to_write) '.mat'];

save( PCpresetfile, 'PC'); % disp(['Saved ' PCpresetfile]);


% --- Executes when selected object is changed in bg_preset_pushbuttons.
function bg_preset_pushbuttons_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in bg_preset_pushbuttons 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

global PC PP PS defaultPC

% Speichern der Konfiguration des vorher selektierten Presets

write_all_data_to_preset(handles)

% reset der geladenen PC
clear global PC
global PC

% Laden der neu selektierten preset-PC
% Da dank Buttongroup immer nur einer selektiert sein kann und die max-Werte
% mit 1, 2, 3 und 4 gesetzt wurden:
selected_preset = 1*get(handles.tb_preset1, 'Value') ...
                + 2*get(handles.tb_preset2, 'Value') ...
                + 3*get(handles.tb_preset3, 'Value') ...
                + 4*get(handles.tb_preset4, 'Value');
            
PP.previous_selected_preset = selected_preset;
            
PCpresetfile = ['PC.'  num2str(selected_preset) '.mat'];
if exist( PCpresetfile, 'file') 
    load( PCpresetfile); %disp(['Loaded ' PCpresetfile]);
else % besagtes Preset wurde noch nicht angelegt bzw. abgespeichert.
    load 'PC.mat';       %disp(['Loaded ' 'PC.mat']);
end
PS.selected_preset = selected_preset;
save('PS.mat','PS');


% schliesslich: Laden der Werte in die Felder...
fill_all_fields_with_saved_data(handles)

% ... und highlighten des Presetnamens, die anderen ausgrauen
active_preset=['handles.tb_preset' num2str(selected_preset)];
set( eval(active_preset),'ForegroundColor','black');
set( eval(active_preset),'BackgroundColor',[0.841 0.841 0.841]);
presets = [1 2 3 4];
nonactive_presets = find(presets ~= selected_preset);
for i = 1: length(nonactive_presets)
    nonactive_preset = ['handles.tb_preset' num2str(nonactive_presets(i))];
    set( eval(nonactive_preset),'ForegroundColor',[0.941 0.941 0.941]);
    set( eval(nonactive_preset),'BackgroundColor',[0.702 0.702 0.702]);
end

% Diese Funktion ist nicht rückgängig zu machen
set(handles.pb_cancel,'Enable', 'off'); set(handles.pb_save,'Enable', 'off'); 

resetoptions = {'on', 'off'};
resetoption = resetoptions{isequal(defaultPC.PC, PC) + 1}; % 'off' wenn Preset default entspricht, ansonsten 'on'
set(handles.pb_reset,'Enable', resetoption);


% --- Executes when selected object is changed in bg_use_multisession.
function bg_use_multisession_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in bg_use_multisession 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes on button press in cb_sd_all_objects.
function cb_sd_all_objects_Callback(hObject, eventdata, handles)
% hObject    handle to cb_sd_all_objects (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_sd_all_objects


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


function ed_sd_brk_between_trials_Callback(hObject, eventdata, handles)
% hObject    handle to ed_sd_brk_between_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_sd_brk_between_trials as text
%        str2double(get(hObject,'String')) returns contents of ed_sd_brk_between_trials as a double


% --- Executes during object creation, after setting all properties.
function ed_sd_brk_between_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_sd_brk_between_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_sd_resolution.
function pop_sd_resolution_Callback(hObject, eventdata, handles)
% hObject    handle to pop_sd_resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_sd_resolution contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_sd_resolution


% --- Executes during object creation, after setting all properties.
function pop_sd_resolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_sd_resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function txt_rgt2_all_elements_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_rgt2_all_elements (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in cb_rgt2_all_elements.
function cb_rgt2_all_elements_Callback(hObject, eventdata, handles)
% hObject    handle to cb_rgt2_all_elements (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_rgt2_all_elements


% --- Executes on button press in cb_rgt2_selected_elements.
function cb_rgt2_selected_elements_Callback(hObject, eventdata, handles)
% hObject    handle to cb_rgt2_selected_elements (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_rgt2_selected_elements



function ed_rgt2_brk_between_trials_Callback(hObject, eventdata, handles)
% hObject    handle to ed_rgt2_brk_between_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_rgt2_brk_between_trials as text
%        str2double(get(hObject,'String')) returns contents of ed_rgt2_brk_between_trials as a double


% --- Executes during object creation, after setting all properties.
function txt_rgt2_value_selection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_rgt2_value_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function txt_rgt2_resolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_rgt2_resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in pop_rgt2_resolution.
function pop_rgt2_resolution_Callback(hObject, eventdata, handles)
% hObject    handle to pop_rgt2_resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_rgt2_resolution contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_rgt2_resolution


% --- Executes on button press in cb_all_triads.
function cb_all_triads_Callback(hObject, eventdata, handles)
% hObject    handle to cb_all_triads (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_all_triads

set(handles.pb_cancel,  'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on button press in cb_manually_selected_triads.
function cb_manually_selected_triads_Callback(hObject, eventdata, handles)
% hObject    handle to cb_manually_selected_triads (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_manually_selected_triads

set(handles.pb_cancel,  'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on selection change in pop_maxnum_constructs.
function pop_maxnum_constructs_Callback(hObject, eventdata, handles)
% hObject    handle to pop_maxnum_constructs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_maxnum_constructs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_maxnum_constructs

set(handles.pb_cancel,  'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');



% --- Executes during object creation, after setting all properties.
function rad_sd_discrete_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rad_sd_discrete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when selected object is changed in bg_rgt2_value_selection.
function bg_rgt2_value_selection_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in bg_rgt2_value_selection 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in pan_sd_value_selection.
function pan_sd_value_selection_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in pan_sd_value_selection 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_ok.
function pb_ok_Callback(hObject, eventdata, handles)
% hObject    handle to pb_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP PS

selected_preset = 1*get(handles.tb_preset1, 'Value') ...
                + 2*get(handles.tb_preset2, 'Value') ...
                + 3*get(handles.tb_preset3, 'Value') ...
                + 4*get(handles.tb_preset4, 'Value');
            
PP.previous_selected_preset = selected_preset;

write_all_data_to_preset(handles)

PS.selected_preset = selected_preset;
save('PS.mat', 'PS');
close


function ed_stimulus_default_name_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_default_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_default_name as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_default_name as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_default_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_default_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_abx_num_trials_Callback(hObject, eventdata, handles)
% hObject    handle to ed_abx_num_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_abx_num_trials as text
%        str2double(get(hObject,'String')) returns contents of ed_abx_num_trials as a double


% --- Executes during object creation, after setting all properties.
function ed_abx_num_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_abx_num_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_abx_num_correct_answers_Callback(hObject, eventdata, handles)
% hObject    handle to ed_abx_num_correct_answers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_abx_num_correct_answers as text
%        str2double(get(hObject,'String')) returns contents of ed_abx_num_correct_answers as a double


% --- Executes during object creation, after setting all properties.
function ed_abx_num_correct_answers_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_abx_num_correct_answers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_abx_sig_level_Callback(hObject, eventdata, handles)
% hObject    handle to ed_abx_sig_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_abx_sig_level as text
%        str2double(get(hObject,'String')) returns contents of ed_abx_sig_level as a double


% --- Executes during object creation, after setting all properties.
function ed_abx_sig_level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_abx_sig_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_abx_risk_beta_Callback(hObject, eventdata, handles)
% hObject    handle to ed_abx_risk_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_abx_risk_beta as text
%        str2double(get(hObject,'String')) returns contents of ed_abx_risk_beta as a double


% --- Executes during object creation, after setting all properties.
function ed_abx_risk_beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_abx_risk_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_abx_effect_size_Callback(hObject, eventdata, handles)
% hObject    handle to ed_abx_effect_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_abx_effect_size as text
%        str2double(get(hObject,'String')) returns contents of ed_abx_effect_size as a double


% --- Executes during object creation, after setting all properties.
function ed_abx_effect_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_abx_effect_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cb_abx_randomize.
function cb_abx_randomize_Callback(hObject, eventdata, handles)
% hObject    handle to cb_abx_randomize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_abx_randomize



function ed_stimulus_server6_presend_pause_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server6_presend_pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server6_presend_pause as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server6_presend_pause as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server6_presend_pause_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server6_presend_pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stimulus_server6_oscpath_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server6_oscpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server6_oscpath as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server6_oscpath as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server6_oscpath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server6_oscpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_stimulus_server6_datatype.
function pop_stimulus_server6_datatype_Callback(hObject, eventdata, handles)
% hObject    handle to pop_stimulus_server6_datatype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_stimulus_server6_datatype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_stimulus_server6_datatype

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function pop_stimulus_server6_datatype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_stimulus_server6_datatype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stimulus_server6_oscdata_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server6_oscdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server6_oscdata as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server6_oscdata as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server6_oscdata_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server6_oscdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stimulus_server3_presend_pause_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server3_presend_pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server3_presend_pause as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server3_presend_pause as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server3_presend_pause_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server3_presend_pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stimulus_server3_oscpath_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server3_oscpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server3_oscpath as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server3_oscpath as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server3_oscpath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server3_oscpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_stimulus_server3_datatype.
function pop_stimulus_server3_datatype_Callback(hObject, eventdata, handles)
% hObject    handle to pop_stimulus_server3_datatype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_stimulus_server3_datatype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_stimulus_server3_datatype

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function pop_stimulus_server3_datatype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_stimulus_server3_datatype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stimulus_server3_oscdata_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server3_oscdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server3_oscdata as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server3_oscdata as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server3_oscdata_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server3_oscdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stimulus_server5_presend_pause_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server5_presend_pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server5_presend_pause as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server5_presend_pause as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server5_presend_pause_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server5_presend_pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stimulus_server5_oscpath_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server5_oscpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server5_oscpath as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server5_oscpath as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server5_oscpath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server5_oscpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_stimulus_server5_datatype.
function pop_stimulus_server5_datatype_Callback(hObject, eventdata, handles)
% hObject    handle to pop_stimulus_server5_datatype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_stimulus_server5_datatype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_stimulus_server5_datatype

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function pop_stimulus_server5_datatype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_stimulus_server5_datatype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stimulus_server5_oscdata_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server5_oscdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server5_oscdata as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server5_oscdata as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server5_oscdata_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server5_oscdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stimulus_server2_presend_pause_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server2_presend_pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server2_presend_pause as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server2_presend_pause as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server2_presend_pause_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server2_presend_pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stimulus_server2_oscpath_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server2_oscpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server2_oscpath as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server2_oscpath as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server2_oscpath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server2_oscpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_stimulus_server2_datatype.
function pop_stimulus_server2_datatype_Callback(hObject, eventdata, handles)
% hObject    handle to pop_stimulus_server2_datatype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_stimulus_server2_datatype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_stimulus_server2_datatype

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function pop_stimulus_server2_datatype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_stimulus_server2_datatype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stimulus_server2_oscdata_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server2_oscdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server2_oscdata as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server2_oscdata as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server2_oscdata_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server2_oscdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stimulus_server4_presend_pause_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server4_presend_pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server4_presend_pause as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server4_presend_pause as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server4_presend_pause_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server4_presend_pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stimulus_server4_oscpath_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server4_oscpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server4_oscpath as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server4_oscpath as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server4_oscpath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server4_oscpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_stimulus_server4_datatype.
function pop_stimulus_server4_datatype_Callback(hObject, eventdata, handles)
% hObject    handle to pop_stimulus_server4_datatype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_stimulus_server4_datatype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_stimulus_server4_datatype

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function pop_stimulus_server4_datatype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_stimulus_server4_datatype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stimulus_server4_oscdata_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server4_oscdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server4_oscdata as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server4_oscdata as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server4_oscdata_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server4_oscdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stimulus_server1_presend_pause_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server1_presend_pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server1_presend_pause as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server1_presend_pause as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server1_presend_pause_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server1_presend_pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stimulus_server1_oscpath_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server1_oscpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server1_oscpath as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server1_oscpath as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server1_oscpath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server1_oscpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_stimulus_server1_datatype.
function pop_stimulus_server1_datatype_Callback(hObject, eventdata, handles)
% hObject    handle to pop_stimulus_server1_datatype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_stimulus_server1_datatype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_stimulus_server1_datatype

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function pop_stimulus_server1_datatype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_stimulus_server1_datatype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_stimulus_server1_oscdata_Callback(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server1_oscdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_stimulus_server1_oscdata as text
%        str2double(get(hObject,'String')) returns contents of ed_stimulus_server1_oscdata as a double


% --- Executes during object creation, after setting all properties.
function ed_stimulus_server1_oscdata_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server1_oscdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function txt_sd_value_selection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_sd_value_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function txt_sd_resolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_sd_resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function ed_sd_init_instructions_Callback(hObject, eventdata, handles)
% hObject    handle to ed_sd_init_instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_sd_init_instructions as text
%        str2double(get(hObject,'String')) returns contents of ed_sd_init_instructions as a double


% --- Executes during object creation, after setting all properties.
function ed_sd_init_instructions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_sd_init_instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_sd_short_instructions_Callback(hObject, eventdata, handles)
% hObject    handle to ed_sd_short_instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_sd_short_instructions as text
%        str2double(get(hObject,'String')) returns contents of ed_sd_short_instructions as a double


% --- Executes during object creation, after setting all properties.
function ed_sd_short_instructions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_sd_short_instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_rgt2_init_instructions_Callback(hObject, eventdata, handles)
% hObject    handle to ed_rgt2_init_instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_rgt2_init_instructions as text
%        str2double(get(hObject,'String')) returns contents of ed_rgt2_init_instructions as a double



function ed_rgt2_short_instructions_Callback(hObject, eventdata, handles)
% hObject    handle to ed_rgt2_short_instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_rgt2_short_instructions as text
%        str2double(get(hObject,'String')) returns contents of ed_rgt2_short_instructions as a double



function ed_rgt1_init_instructions_Callback(hObject, eventdata, handles)
% hObject    handle to ed_rgt1_init_instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_rgt1_init_instructions as text
%        str2double(get(hObject,'String')) returns contents of ed_rgt1_init_instructions as a double



function ed_rgt1_short_instructions_Callback(hObject, eventdata, handles)
% hObject    handle to ed_rgt1_short_instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_rgt1_short_instructions as text
%        str2double(get(hObject,'String')) returns contents of ed_rgt1_short_instructions as a double



function ed_abx_init_instructions_Callback(hObject, eventdata, handles)
% hObject    handle to ed_abx_init_instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_abx_init_instructions as text
%        str2double(get(hObject,'String')) returns contents of ed_abx_init_instructions as a double


% --- Executes during object creation, after setting all properties.
function ed_abx_init_instructions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_abx_init_instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_abx_short_instructions_Callback(hObject, eventdata, handles)
% hObject    handle to ed_abx_short_instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_abx_short_instructions as text
%        str2double(get(hObject,'String')) returns contents of ed_abx_short_instructions as a double


% --- Executes during object creation, after setting all properties.
function ed_abx_short_instructions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_abx_short_instructions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on ed_rgt1_init_instructions and none of its controls.
function ed_rgt1_init_instructions_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_rgt1_init_instructions (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_rgt1_short_instructions and none of its controls.
function ed_rgt1_short_instructions_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_rgt1_short_instructions (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_rgt2_init_instructions and none of its controls.
function ed_rgt2_init_instructions_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_rgt2_init_instructions (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_rgt2_short_instructions and none of its controls.
function ed_rgt2_short_instructions_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_rgt2_short_instructions (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_sd_init_instructions and none of its controls.
function ed_sd_init_instructions_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_sd_init_instructions (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_sd_short_instructions and none of its controls.
function ed_sd_short_instructions_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_sd_short_instructions (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_abx_init_instructions and none of its controls.
function ed_abx_init_instructions_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_abx_init_instructions (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_abx_short_instructions and none of its controls.
function ed_abx_short_instructions_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_abx_short_instructions (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_default_name and none of its controls.
function ed_stimulus_default_name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_default_name (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server1_presend_pause and none of its controls.
function ed_stimulus_server1_presend_pause_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server1_presend_pause (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server1_oscpath and none of its controls.
function ed_stimulus_server1_oscpath_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server1_oscpath (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server1_oscdata and none of its controls.
function ed_stimulus_server1_oscdata_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server1_oscdata (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server4_presend_pause and none of its controls.
function ed_stimulus_server4_presend_pause_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server4_presend_pause (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server4_oscpath and none of its controls.
function ed_stimulus_server4_oscpath_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server4_oscpath (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server4_oscdata and none of its controls.
function ed_stimulus_server4_oscdata_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server4_oscdata (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server2_presend_pause and none of its controls.
function ed_stimulus_server2_presend_pause_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server2_presend_pause (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server2_oscpath and none of its controls.
function ed_stimulus_server2_oscpath_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server2_oscpath (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server2_oscdata and none of its controls.
function ed_stimulus_server2_oscdata_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server2_oscdata (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server5_presend_pause and none of its controls.
function ed_stimulus_server5_presend_pause_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server5_presend_pause (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server5_oscpath and none of its controls.
function ed_stimulus_server5_oscpath_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server5_oscpath (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server5_oscdata and none of its controls.
function ed_stimulus_server5_oscdata_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server5_oscdata (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server3_presend_pause and none of its controls.
function ed_stimulus_server3_presend_pause_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server3_presend_pause (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server3_oscpath and none of its controls.
function ed_stimulus_server3_oscpath_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server3_oscpath (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server3_oscdata and none of its controls.
function ed_stimulus_server3_oscdata_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server3_oscdata (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server6_presend_pause and none of its controls.
function ed_stimulus_server6_presend_pause_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server6_presend_pause (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server6_oscpath and none of its controls.
function ed_stimulus_server6_oscpath_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server6_oscpath (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');


% --- Executes on key press with focus on ed_stimulus_server6_oscdata and none of its controls.
function ed_stimulus_server6_oscdata_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_stimulus_server6_oscdata (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on'); set(handles.pb_save,'Enable', 'on'); set(handles.pb_reset,'Enable', 'on');

