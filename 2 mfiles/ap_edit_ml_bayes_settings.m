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


function varargout = ap_edit_ml_bayes_settings(varargin)
% AP_EDIT_ML_BAYES_SETTINGS M-file for ap_edit_ml_bayes_settings.fig
%      AP_EDIT_ML_BAYES_SETTINGS, by itself, creates a new AP_EDIT_ML_BAYES_SETTINGS or raises the existing
%      singleton*.
%
%      H = AP_EDIT_ML_BAYES_SETTINGS returns the handle to a new AP_EDIT_ML_BAYES_SETTINGS or the handle to
%      the existing singleton*.
%
%      AP_EDIT_ML_BAYES_SETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AP_EDIT_ML_BAYES_SETTINGS.M with the given input arguments.
%
%      AP_EDIT_ML_BAYES_SETTINGS('Property','Value',...) creates a new AP_EDIT_ML_BAYES_SETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ap_edit_ml_bayes_settings_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ap_edit_ml_bayes_settings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ap_edit_ml_bayes_settings

% Last Modified by GUIDE v2.5 06-Jun-2010 01:03:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ap_edit_ml_bayes_settings_OpeningFcn, ...
                   'gui_OutputFcn',  @ap_edit_ml_bayes_settings_OutputFcn, ...
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


% --- Executes just before ap_edit_ml_bayes_settings is made visible.
function ap_edit_ml_bayes_settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ap_edit_ml_bayes_settings (see VARARGIN)

% Choose default command line output for ap_edit_ml_bayes_settings
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ap_edit_ml_bayes_settings wait for user response (see UIRESUME)
% uiwait(handles.fig_edit_ml_bayes_settings);

movegui(hObject,'center')
global TSP PP
load ([PP.path filesep 'TSP.mat']);
%Auffüllen der GUI mit den gepeicherten Werten
%Anpassen des Fenstertitels
switch TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{2,1}
    case 31
        title = 'ZEST';
        
        % für Initialisierung/pdf werden _nur_ Gauss- und Hyp. zugelassen
        set(handles.rad_implicit,    'Enable', 'off');
        set(handles.rad_uniform,     'Enable', 'off');
        set(handles.cb_exclude_prior,'Enable', 'off');
        set(handles.txt_excl,        'Enable', 'off');
        
        % der nächste Wert errechnet sich _immer_ per Durchschnitt
        set(handles.rad_mode,        'Enable', 'off');
        
    case 32
        title = 'QUEST';
        
        % für Initialisierung/pdf werden _nur_ Gauss- und Hyp. zugelassen
        set(handles.rad_implicit,    'Enable', 'off');
        set(handles.rad_uniform,     'Enable', 'off');
        set(handles.cb_exclude_prior,'Value', 1);
        %set(handles.txt_excl,        'Enable' , 'off');
        
        % der nächste Wert errechnet sich _immer_ per Schwerpunkt
        set(handles.rad_mean,        'Enable', 'off');
        
    case 33
        title = 'ML/Bayes';
end
set(hObject,'Name',['AP - edit ' title ' settings (' TSP.sections{PP.edit_section_line,2} '; Track: ' TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,6} ')']);
%psychometric function
psyfun_typ = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,15};
set(handles.rad_logistic, 'Value', ~(psyfun_typ-1) ) ;
set(handles.rad_weibull,  'Value',   psyfun_typ-1) ;

if (psyfun_typ-1) % = weibull
    set(handles.txt_EPSILON,     'Enable', 'on');
    set(handles.ed_EPSILON,      'Enable', 'on');
    set(handles.pb_calc_epsilon, 'Enable', 'on');
end
    
set(handles.ed_BETA,    'String', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,1});
set(handles.ed_GAMMA,   'String', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,2});
set(handles.ed_LAMBDA,  'String', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,3});
set(handles.ed_EPSILON, 'String', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,16});



%initialisation/p.d.f.
set(handles.cb_exclude_prior, 'Value', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,4});

switch TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,5}
    case 1 %Voreinstellung der GUI ist Auswahl 1 (implicit)
    case 2 %gaussian
        set(handles.rad_gaussian,'Value', 1);
        set(handles.ed_mean,'Enable', 'on');
        set(handles.ed_std_deviation,'Enable', 'on');
    case 3 %uniform
        set(handles.rad_uniform,'Value', 1);
    case 4 % Aus Kompatibilitätsgründen (zu früheren Whispermessungen) wird die "modified hyperbolic p.d.f." als _letzte_ der case-Anweisungen hier eingefügt
        set(handles.rad_hyppdf, 'Value', 1);
        set(handles.ed_Aheight,'Enable', 'on');
        set(handles.ed_Blowslope,'Enable', 'on');
        set(handles.ed_tprobthresh,'Enable', 'on');
        set(handles.ed_Chighslope,'Enable', 'on');
        set(handles.pb_norm,      'Enable', 'on');
end
set(handles.ed_mean, 'String',          TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,6});
set(handles.ed_std_deviation, 'String', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,7});
set(handles.ed_Aheight, 'String',       TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,18});
set(handles.ed_Blowslope, 'String',     TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,19});
set(handles.ed_tprobthresh, 'String',   TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,20});
set(handles.ed_Chighslope, 'String',    TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,21});


%measure of central tendency
if TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,8}==2 %Voreinstellung der GUI ist Auswahl 1 (mode)
    set(handles.rad_mean,'Value', 1);
end

%termination
if TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,9}==2 %Voreinstellung der GUI ist Auswahl 1 (number of trials)
    set(handles.rad_confidence_interval,'Value', 1);
    set(handles.ed_number_of_trials,'Enable', 'Off');
    set(handles.ed_confidence_interval,'Enable', 'On');
    set(handles.ed_confidence_level,'Enable', 'On');
    set(handles.cb_secondary_termination,'Enable', 'on');
    if TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,13}==1
       set(handles.ed_secondary_termination,'Enable', 'on');
    end
end
set(handles.ed_number_of_trials, 'String', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,10});
set(handles.ed_confidence_interval, 'String', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,11});
set(handles.ed_confidence_level, 'String', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,12});

%secondary termination
set(handles.cb_secondary_termination, 'Value', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,13});
set(handles.ed_secondary_termination, 'String', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,14});

% pThreshold anzeigen
update_pThresholdvalue(handles)


% --- Outputs from this function are returned to the command line.
function varargout = ap_edit_ml_bayes_settings_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function ed_number_of_trials_Callback(hObject, eventdata, handles)
% hObject    handle to ed_number_of_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_number_of_trials as text
%        str2double(get(hObject,'String')) returns contents of ed_number_of_trials as a double


% --- Executes during object creation, after setting all properties.
function ed_number_of_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_number_of_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_BETA_Callback(hObject, eventdata, handles)
% hObject    handle to ed_BETA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_BETA as text
%        str2double(get(hObject,'String')) returns contents of ed_BETA as a double

% pThreshold anzeigen
update_pThresholdvalue(handles)


% --- Executes during object creation, after setting all properties.
function ed_BETA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_BETA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_view_psychometric_function.
function pb_view_psychometric_function_Callback(hObject, eventdata, handles)
% hObject    handle to pb_view_psychometric_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
% Werte beta und lambda in Datenstruktur schreiben, damit Veränderungen
% gleich sichtbar sind
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,15}=get(handles.rad_weibull,'Value')+1; % kann man hier so machen, da der Wert von rad_logistic sich aus dem von rad_weibull ergibt (und umgekehrt)
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,1}=str2num(get(handles.ed_BETA,'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,3}=str2num(get(handles.ed_LAMBDA,'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,16}=str2num(get(handles.ed_EPSILON, 'String'));

psyfuntype = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,15};
range      = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(1,1);
n          = TSP.sections{PP.edit_section_line,4}{1,8}{1,1};
beta       = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,1};
lambda     = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,3};
epsilon    = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,16};


% Plot der psychometrischen Funktion
plot_psyfunc(psyfuntype, range, n, beta, lambda, epsilon);


function ed_GAMMA_Callback(hObject, eventdata, handles)
% hObject    handle to ed_GAMMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_GAMMA as text
%        str2double(get(hObject,'String')) returns contents of ed_GAMMA as a double

% pThreshold anzeigen
update_pThresholdvalue(handles)


% --- Executes during object creation, after setting all properties.
function ed_GAMMA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_GAMMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_LAMBDA_Callback(hObject, eventdata, handles)
% hObject    handle to ed_LAMBDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_LAMBDA as text
%        str2double(get(hObject,'String')) returns contents of ed_LAMBDA as a double

% pThreshold anzeigen
update_pThresholdvalue(handles)


% --- Executes during object creation, after setting all properties.
function ed_LAMBDA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_LAMBDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_mean_Callback(hObject, eventdata, handles)
% hObject    handle to ed_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_mean as text
%        str2double(get(hObject,'String')) returns contents of ed_mean as a double


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


function ed_std_deviation_Callback(hObject, eventdata, handles)
% hObject    handle to ed_std_deviation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_std_deviation as text
%        str2double(get(hObject,'String')) returns contents of ed_std_deviation as a double


% --- Executes during object creation, after setting all properties.
function ed_std_deviation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_std_deviation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in pb_view_apriori_likelihood.
function pb_view_apriori_likelihood_Callback(hObject, eventdata, handles)
% hObject    handle to pb_view_apriori_likelihood (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP

% Werte beta und lambda in Datenstruktur schreiben, damit Veränderungen
% gleich sichtbar sind
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,15} =         get(handles.rad_weibull,     'Value')+1; % kann man hier so machen, da der Wert von rad_logistic sich aus dem von rad_weibull ergibt (und umgekehrt)
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,1}  = str2num(get(handles.ed_BETA,         'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,3}  = str2num(get(handles.ed_LAMBDA,       'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,16} = str2num(get(handles.ed_EPSILON,      'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,4}  =         get(handles.cb_exclude_prior,'Value');
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,6}  = str2num(get(handles.ed_mean,         'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,7}  = str2num(get(handles.ed_std_deviation,'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,18} = str2num(get(handles.ed_Aheight,      'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,19} = str2num(get(handles.ed_Blowslope,    'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,20} = str2num(get(handles.ed_tprobthresh,  'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,21} = str2num(get(handles.ed_Chighslope,   'String'));

range       = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(1,1);
n           = TSP.sections{PP.edit_section_line,4}{1,8}{1,1};
beta        = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,1};
lambda      = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,3};
epsilon     = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,16};
psyfuntype  = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,15};
priortype   = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,5};

mu          = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,6};
sigma       = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,7};

Aheight     = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,18};
Blowslope   = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,19};
tprobthresh = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,20};
Chighslope  = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,21};


plot_prior(range, n, psyfuntype, priortype, beta, lambda, epsilon, mu, sigma, Aheight, Blowslope, tprobthresh, Chighslope);

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
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,15}=get(handles.rad_weibull, 'Value')+1; % kann man hier so machen, da der Wert von rad_logistic sich aus dem von rad_weibull ergibt (und umgekehrt)
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,1}=str2num(get(handles.ed_BETA,'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,3}=str2num(get(handles.ed_LAMBDA,'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,16}=str2num(get(handles.ed_EPSILON, 'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,17}=str2num(get(handles.ed_pT, 'String'));

TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,4}=get(handles.cb_exclude_prior,'Value');

TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,6}=str2num(get(handles.ed_mean,'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,7}=str2num(get(handles.ed_std_deviation,'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,18}=str2num(get(handles.ed_Aheight, 'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,19}=str2num(get(handles.ed_Blowslope, 'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,20}=str2num(get(handles.ed_tprobthresh, 'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,21}=str2num(get(handles.ed_Chighslope, 'String'));

TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,10}=str2num(get(handles.ed_number_of_trials,'String'));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,11}=round(str2num(get(handles.ed_confidence_interval,'String')));
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,12}=str2num(get(handles.ed_confidence_level,'String'));

TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,13}=get(handles.cb_secondary_termination,'Value');
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,14}=str2num(get(handles.ed_secondary_termination,'String'));

save ([PP.path filesep 'TSP.mat'],'TSP');
close


% --- Executes on key press with focus on ed_BETA and no controls selected.
function ed_BETA_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_BETA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_LAMBDA and no controls selected.
function ed_LAMBDA_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_LAMBDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_number_of_trials and no controls selected.
function ed_number_of_trials_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_number_of_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_mean and no controls selected.
function ed_mean_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_std_deviation and no controls selected.
function ed_std_deviation_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_std_deviation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');

% !! Alles auskommentiert, da die radio-buttons jetzt nicht mehr über ihre
% Callbacks, sondern über die selection_change_FCN ihrer sie enthaltenden
% Buttongroup gemanaged werden.
%
%     % --- Executes on button press in rad_implicit.
%     function rad_implicit_Callback(hObject, eventdata, handles)
%     % hObject    handle to rad_implicit (see GCBO)
%     % eventdata  reserved - to be defined in a future version of MATLAB
%     % handles    structure with handles and user data (see GUIDATA)
% 
%     % Hint: get(hObject,'Value') returns toggle state of rad_implicit
% 
%     % global TSP PP
%     % TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,5}=1;
%     % set(handles.rad_implicit,'Value', 1);
%     % set(handles.ed_mean,'Enable', 'off');
%     % set(handles.ed_std_deviation,'Enable', 'off');
%      %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
%      set(handles.pb_cancel,'Enable', 'on');


%     % --- Executes on button press in rad_gaussian.
%     function rad_gaussian_Callback(hObject, eventdata, handles)
%     % hObject    handle to rad_gaussian (see GCBO)
%     % eventdata  reserved - to be defined in a future version of MATLAB
%     % handles    structure with handles and user data (see GUIDATA)
% 
%     % Hint: get(hObject,'Value') returns toggle state of rad_gaussian
% 
%     global TSP PP
%     TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,5}=2;
%     set(handles.rad_gaussian,'Value', 1);
%     set(handles.ed_mean,'Enable', 'on');
%     set(handles.ed_std_deviation,'Enable', 'on');
%     %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
%     set(handles.pb_cancel,'Enable', 'on');


%     % --- Executes on button press in rad_uniform.
%     function rad_uniform_Callback(hObject, eventdata, handles)
%     % hObject    handle to rad_uniform (see GCBO)
%     % eventdata  reserved - to be defined in a future version of MATLAB
%     % handles    structure with handles and user data (see GUIDATA)
% 
%     % Hint: get(hObject,'Value') returns toggle state of rad_uniform
% 
%     global TSP PP
%     TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,5}=3;
%     set(handles.rad_uniform,'Value', 1);
%     set(handles.ed_mean,'Enable', 'off');
%     set(handles.ed_std_deviation,'Enable', 'off');
%     %Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
%     set(handles.pb_cancel,'Enable', 'on');



% --- Executes when user attempts to close fig_edit_ml_bayes_settings.
function fig_edit_ml_bayes_settings_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_edit_ml_bayes_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
if PP.dontopenparent~=1
    ap_edit_track_settings
end
PP.dontopenparent=0;

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in rad_mode.
function rad_mode_Callback(hObject, eventdata, handles)
% hObject    handle to rad_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_mode

global TSP PP
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,8}=1;
set(handles.rad_mode,'Value', 1);
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in rad_mean.
function rad_mean_Callback(hObject, eventdata, handles)
% hObject    handle to rad_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_mean

global TSP PP
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,8}=2;
set(handles.rad_mean,'Value', 1);
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in rad_number_of_trials.
function rad_number_of_trials_Callback(hObject, eventdata, handles)
% hObject    handle to rad_number_of_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_number_of_trials

global TSP PP
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,9}=1;
set(handles.rad_number_of_trials,'Value', 1);
set(handles.ed_number_of_trials,'Enable', 'on');
set(handles.ed_confidence_interval,'Enable', 'off');
set(handles.ed_confidence_level,'Enable', 'off');
set(handles.cb_secondary_termination,'Enable', 'off');
set(handles.ed_secondary_termination,'Enable', 'off');
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in rad_confidence_interval.
function rad_confidence_interval_Callback(hObject, eventdata, handles)
% hObject    handle to rad_confidence_interval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_confidence_interval

global TSP PP
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,9}=2;
set(handles.rad_confidence_interval,'Value', 1);
set(handles.ed_number_of_trials,'Enable', 'Off');
set(handles.ed_confidence_interval,'Enable', 'on');
set(handles.ed_confidence_level,'Enable', 'on');
set(handles.cb_secondary_termination,'Enable', 'on');
if get(handles.cb_secondary_termination,'Value')==1
    set(handles.ed_secondary_termination,'Enable', 'on');
end
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


function ed_confidence_interval_Callback(hObject, eventdata, handles)
% hObject    handle to ed_confidence_interval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_confidence_interval as text
%        str2double(get(hObject,'String')) returns contents of ed_confidence_interval as a double


% --- Executes during object creation, after setting all properties.
function ed_confidence_interval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_confidence_interval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_confidence_level_Callback(hObject, eventdata, handles)
% hObject    handle to ed_confidence_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_confidence_level as text
%        str2double(get(hObject,'String')) returns contents of ed_confidence_level as a double


% --- Executes during object creation, after setting all properties.
function ed_confidence_level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_confidence_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_secondary_termination_Callback(hObject, eventdata, handles)
% hObject    handle to ed_secondary_termination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_secondary_termination as text
%        str2double(get(hObject,'String')) returns contents of ed_secondary_termination as a double


% --- Executes during object creation, after setting all properties.
function ed_secondary_termination_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_secondary_termination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
        set(handles.ed_secondary_termination,'Enable', 'Off');
    case 1
        set(handles.ed_secondary_termination,'Enable', 'On');
end

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');



function ed_Aheight_Callback(hObject, eventdata, handles)
% hObject    handle to ed_Aheight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_Aheight as text
%        str2double(get(hObject,'String')) returns contents of ed_Aheight as a double


% --- Executes during object creation, after setting all properties.
function ed_Aheight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_Aheight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_tprobthresh_Callback(hObject, eventdata, handles)
% hObject    handle to ed_tprobthresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_tprobthresh as text
%        str2double(get(hObject,'String')) returns contents of ed_tprobthresh as a double


% --- Executes during object creation, after setting all properties.
function ed_tprobthresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_tprobthresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_Blowslope_Callback(hObject, eventdata, handles)
% hObject    handle to ed_Blowslope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_Blowslope as text
%        str2double(get(hObject,'String')) returns contents of ed_Blowslope as a double


% --- Executes during object creation, after setting all properties.
function ed_Blowslope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_Blowslope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_Chighslope_Callback(hObject, eventdata, handles)
% hObject    handle to ed_Chighslope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_Chighslope as text
%        str2double(get(hObject,'String')) returns contents of ed_Chighslope as a double


% --- Executes during object creation, after setting all properties.
function ed_Chighslope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_Chighslope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_EPSILON_Callback(hObject, eventdata, handles)
% hObject    handle to ed_EPSILON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_EPSILON as text
%        str2double(get(hObject,'String')) returns contents of ed_EPSILON as a double

% pThreshold anzeigen
update_pThresholdvalue(handles)

% --- Executes during object creation, after setting all properties.
function ed_EPSILON_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_EPSILON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_calc_epsilon.
function pb_calc_epsilon_Callback(hObject, eventdata, handles)
% hObject    handle to pb_calc_epsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP TSP

gamma   = str2num(get(handles.ed_GAMMA,'String'));
lambda  = str2num(get(handles.ed_LAMBDA,'String'));
beta    = str2num(get(handles.ed_BETA,'String'));
epsilon = str2num(get(handles.ed_EPSILON,'String'));
range   = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(1,1);

[epsilon, pThreshold] = find_epsilon_for_ideal_sweat_factor (gamma, lambda, beta, range);
set(handles.ed_EPSILON, 'String', num2str(epsilon, 3));
set(handles.ed_pT, 'String', num2str(pThreshold, 3));


function ed_pT_Callback(hObject, eventdata, handles)
% hObject    handle to ed_pT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_pT as text
%        str2double(get(hObject,'String')) returns contents of ed_pT as a double


% --- Executes during object creation, after setting all properties.
function ed_pT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_pT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function update_pThresholdvalue(handles)
global TSP PP

gamma   = str2num(get(handles.ed_GAMMA,'String'));
lambda  = str2num(get(handles.ed_LAMBDA,'String'));
beta    = str2num(get(handles.ed_BETA,'String'));
epsilon = str2num(get(handles.ed_EPSILON,'String'));
range   = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(1,1);
psyfun_typ = TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,15};

x = 1:2*range;
switch psyfun_typ
    case 1 % logistische
        PsyFunc = gamma + ((1-gamma-lambda)./(1+exp(-(x-range)/beta))); 
        
    case 2 % Weibull Funktion
        PsyFunc = 1 - lambda - ((1-gamma-lambda)./(exp(10.^((beta/20)*(x-range+epsilon))))); 
end

pThresh = PsyFunc(range);
set(handles.ed_pT, 'String', num2str(pThresh,3));
% und in die TSP schreiben. ? Oder woanders hin? Plotten vielleicht?

% --- Executes when selected object is changed in bg_psy_typ.
function bg_psy_typ_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in bg_psy_typ 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global TSP PP

    rad_tag = get(eventdata.NewValue, 'Tag');
    switch rad_tag;
        case 'rad_logistic'
            psyfun_typ = 1;
            enable     = 'off';
        case 'rad_weibull'
            psyfun_typ = 2;
            enable     = 'on';
    end
    
set(handles.txt_EPSILON,     'Enable', enable);
set(handles.ed_EPSILON,      'Enable', enable);
set(handles.pb_calc_epsilon, 'Enable', enable);
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,15}=psyfun_typ;
update_pThresholdvalue(handles)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');




% --- Executes on key press with focus on ed_EPSILON and none of its controls.
function ed_EPSILON_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_EPSILON (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_Aheight and none of its controls.
function ed_Aheight_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_Aheight (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_Blowslope and none of its controls.
function ed_Blowslope_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_Blowslope (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_tprobthresh and none of its controls.
function ed_tprobthresh_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_tprobthresh (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_Chighslope and none of its controls.
function ed_Chighslope_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_Chighslope (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes when selected object is changed in pan_initialisation.
function pan_initialisation_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in pan_initialisation 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

global TSP PP

% Hier werden die Funktionen aufgerufen, wenn einer der Pushbuttons zur
% pdf-Auswahl gedrückt wird.

    rad_tag = get(eventdata.NewValue, 'Tag');
    switch rad_tag;
        case 'rad_implicit'
            pdf_typ = 1;
            set(handles.ed_mean,         'Enable', 'off');
            set(handles.ed_std_deviation,'Enable', 'off');
            set(handles.ed_Aheight,      'Enable', 'off');
            set(handles.ed_Blowslope,    'Enable', 'off');
            set(handles.ed_tprobthresh,  'Enable', 'off');
            set(handles.ed_Chighslope,   'Enable', 'off');
            set(handles.pb_norm,         'Enable', 'off');
        case 'rad_gaussian'
            pdf_typ = 2;
            set(handles.ed_mean,         'Enable', 'on');
            set(handles.ed_std_deviation,'Enable', 'on');
            set(handles.ed_Aheight,      'Enable', 'off');
            set(handles.ed_Blowslope,    'Enable', 'off');
            set(handles.ed_tprobthresh,  'Enable', 'off');
            set(handles.ed_Chighslope,   'Enable', 'off');
            set(handles.pb_norm,         'Enable', 'off');
        case 'rad_hyppdf'
            pdf_typ = 4; % Obwohl im GUI an 3. Stelle! Wg. Kompatibilität.
            set(handles.ed_mean,         'Enable', 'off');
            set(handles.ed_std_deviation,'Enable', 'off');
            set(handles.ed_Aheight,      'Enable', 'on');
            set(handles.ed_Blowslope,    'Enable', 'on');
            set(handles.ed_tprobthresh,  'Enable', 'on');
            set(handles.ed_Chighslope,   'Enable', 'on');
            set(handles.pb_norm,         'Enable', 'on');
        case 'rad_uniform'
            pdf_typ = 3; % Obwohl im GUI an 4. Stelle! Wg. Kompatibilität.
            set(handles.ed_mean,         'Enable', 'off');
            set(handles.ed_std_deviation,'Enable', 'off');
            set(handles.ed_Aheight,      'Enable', 'off');
            set(handles.ed_Blowslope,    'Enable', 'off');
            set(handles.ed_tprobthresh,  'Enable', 'off');
            set(handles.ed_Chighslope,   'Enable', 'off');
            set(handles.pb_norm,         'Enable', 'off');
    end
    
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,5} = pdf_typ;    

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');



% --- Executes on button press in pb_norm.
function pb_norm_Callback(hObject, eventdata, handles)
% hObject    handle to pb_norm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP

A   = str2num(get(handles.ed_Aheight, 'String'));
B   = str2num(get(handles.ed_Blowslope, 'String'));
t   = str2num(get(handles.ed_tprobthresh, 'String'));
C   = str2num(get(handles.ed_Chighslope, 'String'));

x   = t;

A   = ((B*exp(-C*(x-t))) + (C*exp(B*(x-t))));
set(handles.ed_Aheight, 'String', A);

