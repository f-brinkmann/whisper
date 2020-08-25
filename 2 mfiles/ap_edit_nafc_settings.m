% =========================================================================
%
% This file has been written as part of WhisPER, a package of interacting 
% MATLAB scripts for designing and controlling experiments in the field of 
% auditory perceptive measurement and evaluation. The copyright for WhisPER
% is held by its originators André Wlodarski and Simon Ciba and protected 
% by the German Copyright Act (§ 2 Abs. 2 UrhG).
% 
% Copyright (C) 2008, 2009 André Wlodarski and Simon Ciba
%
%
% Note: The use of WhisPER or any of its components is under the complete 
% and sole responsibility of the user.
%
% -------------------------------------------------------------------------
% 
% This file:
%
% Author :   André Wlodarski, student at FG Audiokommunikation, TU Berlin
% Email  :   awlodarski AT gmx DOT de
% Date   :   15-Nov-2008
%
% =========================================================================


function varargout = ap_edit_nafc_settings(varargin)
% AP_EDIT_NAFC_SETTINGS M-file for ap_edit_nafc_settings.fig
%      AP_EDIT_NAFC_SETTINGS, by itself, creates a new AP_EDIT_NAFC_SETTINGS or raises the existing
%      singleton*.
%
%      H = AP_EDIT_NAFC_SETTINGS returns the handle to a new AP_EDIT_NAFC_SETTINGS or the handle to
%      the existing singleton*.
%
%      AP_EDIT_NAFC_SETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AP_EDIT_NAFC_SETTINGS.M with the given input arguments.
%
%      AP_EDIT_NAFC_SETTINGS('Property','Value',...) creates a new AP_EDIT_NAFC_SETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ap_edit_nafc_settings_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ap_edit_nafc_settings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ap_edit_nafc_settings

% Last Modified by GUIDE v2.5 06-Dec-2013 14:20:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ap_edit_nafc_settings_OpeningFcn, ...
                   'gui_OutputFcn',  @ap_edit_nafc_settings_OutputFcn, ...
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


% --- Executes just before ap_edit_nafc_settings is made visible.
function ap_edit_nafc_settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ap_edit_nafc_settings (see VARARGIN)

% Choose default command line output for ap_edit_nafc_settings
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ap_edit_nafc_settings wait for user response (see UIRESUME)
% uiwait(handles.fig_edit_nafc_settings);

movegui(hObject,'center')
global TSP PP
load ([PP.path filesep 'TSP.mat']);
%Auffüllen der GUI mit den gepeicherten Werten
set(hObject,'Name',['AP - edit nAFC settings (' TSP.sections{PP.edit_section_line,2} ')']);
set(handles.cb_multi_listening, 'Value', TSP.sections{PP.edit_section_line,4}{1,8}{1,3})
set(handles.pop_nAFC, 'Value', TSP.sections{PP.edit_section_line,4}{1,8}{1,1}-1)
set(handles.ed_break_between_trials, 'String', TSP.sections{PP.edit_section_line,4}{1,8}{1,2})



% --- Outputs from this function are returned to the command line.
function varargout = ap_edit_nafc_settings_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on selection change in pop_nAFC.
function pop_nAFC_Callback(hObject, eventdata, handles)
% hObject    handle to pop_nAFC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_nAFC contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_nAFC

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function pop_nAFC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_nAFC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_break_duration_Callback(hObject, eventdata, handles)
% hObject    handle to ed_break_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_break_duration as text
%        str2double(get(hObject,'String')) returns contents of ed_break_duration as a double


% --- Executes during object creation, after setting all properties.
function ed_break_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_break_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_break_between_trials_Callback(hObject, eventdata, handles)
% hObject    handle to ed_break_between_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_break_between_trials as text
%        str2double(get(hObject,'String')) returns contents of ed_break_between_trials as a double


% --- Executes during object creation, after setting all properties.
function ed_break_between_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_break_between_trials (see GCBO)
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
n=get(handles.pop_nAFC,'Value')+1;
%wenn Änderung...
if n~=TSP.sections{PP.edit_section_line,4}{1,8}{1,1}
    TSP.sections{PP.edit_section_line,4}{1,8}{1,1}=n;
    % Schleife über alle Tracks, in der Anpassungen der Parameter
    % vorgenommen werden, die durch de Änderung von n nötig sind
    for i=1:length(TSP.sections{PP.edit_section_line,4}(:,7))
        % für bestPEST guessing rate anpassen, da diese hier fest 1/n ist.
        TSP.sections{PP.edit_section_line,4}{i,7}{1,4}{1,2}=1/n;
        % für PEST target probability anpassen
        TSP.sections{PP.edit_section_line,4}{i,7}{1,3}{1,6}=1/n+(1-1/n)/2;
    end
end
TSP.sections{PP.edit_section_line,4}{1,8}{1,2}=str2num(get(handles.ed_break_between_trials,'String'));
multi_listening=get(handles.cb_multi_listening,'Value');
TSP.sections{PP.edit_section_line,4}{1,8}{1,3}=multi_listening;
save ([PP.path filesep 'TSP.mat'],'TSP');
close


% --- Executes when user attempts to close fig_edit_nafc_settings.
function fig_edit_nafc_settings_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_edit_nafc_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
if PP.dontopenparent~=1
    ap_edit_main
end
PP.dontopenparent=0;

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on key press with focus on ed_break_between_trials and no controls selected.
function ed_break_between_trials_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_break_between_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in cb_multi_listening.
function cb_multi_listening_Callback(hObject, eventdata, handles)
% hObject    handle to cb_multi_listening (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

