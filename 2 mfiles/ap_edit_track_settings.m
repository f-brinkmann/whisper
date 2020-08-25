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


function varargout = ap_edit_track_settings(varargin)
% AP_EDIT_TRACK_SETTINGS M-file for ap_edit_track_settings.fig
%      AP_EDIT_TRACK_SETTINGS, by itself, creates a new AP_EDIT_TRACK_SETTINGS or raises the existing
%      singleton*.
%
%      H = AP_EDIT_TRACK_SETTINGS returns the handle to a new AP_EDIT_TRACK_SETTINGS or the handle to
%      the existing singleton*.
%
%      AP_EDIT_TRACK_SETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AP_EDIT_TRACK_SETTINGS.M with the given input arguments.
%
%      AP_EDIT_TRACK_SETTINGS('Property','Value',...) creates a new AP_EDIT_TRACK_SETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ap_edit_track_settings_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ap_edit_track_settings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ap_edit_track_settings

% Last Modified by GUIDE v2.5 22-May-2010 14:46:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ap_edit_track_settings_OpeningFcn, ...
                   'gui_OutputFcn',  @ap_edit_track_settings_OutputFcn, ...
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


% --- Executes just before ap_edit_track_settings is made visible.
function ap_edit_track_settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ap_edit_track_settings (see VARARGIN)

% Choose default command line output for ap_edit_track_settings
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ap_edit_track_settings wait for user response (see UIRESUME)
% uiwait(handles.fig_edit_track_settings);

movegui(hObject,'center')
global TSP PP
load ([PP.path filesep 'TSP.mat']);
%Auffüllen der GUI mit den gepeicherten Werten
set(hObject,'Name',['AP - edit track settings (' TSP.sections{PP.edit_section_line,2} ')']);
set(handles.pan_track_name,'Title', ['track name for Track ' num2str(PP.edit_track_line)]);
set(handles.ed_track_name,'String', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,6});
set(handles.ed_range,'String', TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(1,1));
switch TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{2,1}
    case 2 %Voreinstellung der GUI ist Auswahl 1 (staircase)
        set(handles.rad_pest,'Value', 1);
        set(handles.pb_pest_settings,'Enable', 'on');
        set(handles.pb_staircase_settings,'Enable', 'off');
    case {31,32,33} %Voreinstellung der GUI ist Auswahl 1 (staircase)
        set(handles.rad_bestpest,'Value', 1);
        set(handles.pb_bestpest_settings,'Enable', 'on');
        set(handles.pb_staircase_settings,'Enable', 'off');
        set(handles.rad_zest,'Enable', 'on');
        set(handles.rad_quest,'Enable', 'on');
        set(handles.rad_manual,'Enable', 'on');
        switch TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{2,1}
            case 31
                set(handles.rad_zest, 'Value', 1);
            case 32
                set(handles.rad_quest, 'Value', 1);  
            case 33
                set(handles.rad_manual, 'Value', 1);
        end
    end


% --- Outputs from this function are returned to the command line.
function varargout = ap_edit_track_settings_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_staircase_settings.
function pb_staircase_settings_Callback(hObject, eventdata, handles)
% hObject    handle to pb_staircase_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP
PP.dontopenparent=1; %verhindern, dass beim schließen die übergeordnete GUI geöffnet wird
pb_save_Callback(hObject, eventdata, handles) %Speichern und schließen
ap_edit_staircase_settings


% --- Executes on button press in pb_pest_settings.
function pb_pest_settings_Callback(hObject, eventdata, handles)
% hObject    handle to pb_pest_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP
PP.dontopenparent=1; %verhindern, dass beim schließen die übergeordnete GUI geöffnet wird
pb_save_Callback(hObject, eventdata, handles) %Speichern und schließen
ap_edit_pest_settings


% --- Executes on button press in pb_bestpest_settings.
function pb_bestpest_settings_Callback(hObject, eventdata, handles)
% hObject    handle to pb_bestpest_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP
PP.dontopenparent=1; %verhindern, dass beim schließen die übergeordnete GUI geöffnet wird
pb_save_Callback(hObject, eventdata, handles) %Speichern und schließen
ap_edit_ml_bayes_settings


% --- Executes on button press in pb_stimulus_assignment.
function pb_stimulus_assignment_Callback(hObject, eventdata, handles)
% hObject    handle to pb_stimulus_assignment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PP
PP.dontopenparent=1; %verhindern, dass beim schließen die übergeordnete GUI geöffnet wird
pb_save_Callback(hObject, eventdata, handles) %Speichern und schließen
ap_edit_stimulus_assignment


function ed_track_name_Callback(hObject, eventdata, handles)
% hObject    handle to ed_track_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_track_name as text
%        str2double(get(hObject,'String')) returns contents of ed_track_name as a double


% --- Executes during object creation, after setting all properties.
function ed_track_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_track_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_range_Callback(hObject, eventdata, handles)
% hObject    handle to ed_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_range as text
%        str2double(get(hObject,'String')) returns contents of ed_range as a double


% --- Executes during object creation, after setting all properties.
function ed_range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_range (see GCBO)
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
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,6}=get(handles.ed_track_name,'String');
%wenn der Range verändert wird, werden für ML/Bayes einige Parameter
%angepasst
newrange=str2num(get(handles.ed_range,'String'));
if newrange~=TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(1,1)
    %spread beta
    TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,1}=newrange/10;
    %gaussian mean mü
    TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,6}=1 + (newrange-1)/2;
    %gaussian standard sigma
    TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,7}=0.7*newrange;
    %Konfidenz-Interval, max width
    TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,11}=round(0.15*newrange);
    %Range an sich
    TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,1}(1,1)=newrange;
end    
save ([PP.path filesep 'TSP.mat'],'TSP');
close


% --- Executes on button press in rad_pest.
function rad_pest_Callback(hObject, eventdata, handles)
% hObject    handle to rad_pest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_pest
global TSP PP
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{2,1}=2;
set(handles.pb_pest_settings,'Value', 1);
set(handles.pb_bestpest_settings,'Enable', 'off');
set(handles.pb_staircase_settings,'Enable', 'off');
set(handles.pb_pest_settings,'Enable', 'on');
set(handles.rad_zest,'Enable', 'off');
set(handles.rad_quest,'Enable', 'off');
set(handles.rad_manual,'Enable', 'off');
set(handles.rad_zest,'Value', 0);
set(handles.rad_quest,'Value', 0);
set(handles.rad_manual,'Value', 0);
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in rad_bestpest.
function rad_bestpest_Callback(hObject, eventdata, handles)
% hObject    handle to rad_bestpest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_bestpest
global TSP PP
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{2,1}=31; %ZEST ist vorgewählt
% Vorselektion der Weibull-Funktion als psychometrische.
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,15}=2;
% Vorselektion der "modified hyperbolic pdf"
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,5}=4;
% Vorselektion der central tendency als "mean"
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,8}=2;
% Da ZEST bereits bei 20 trials konvergiert (Siehe Otto(2008)),
% ist das der neue default-Wert hierfür.
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,10}=20;
set(handles.pb_bestpest_settings,'Value', 1);
set(handles.pb_bestpest_settings,'Enable', 'on');
set(handles.pb_staircase_settings,'Enable', 'off');
set(handles.pb_pest_settings,'Enable', 'off');
set(handles.rad_zest,'Enable', 'on');
set(handles.rad_quest,'Enable', 'on');
set(handles.rad_manual,'Enable', 'on');
set(handles.rad_zest,'Value', 1);
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in rad_staircase.
function rad_staircase_Callback(hObject, eventdata, handles)
% hObject    handle to rad_staircase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rad_staircase
global TSP PP
TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{2,1}=1;
set(handles.pb_staircase_settings,'Value', 1);
set(handles.pb_bestpest_settings,'Enable', 'off');
set(handles.pb_staircase_settings,'Enable', 'on');
set(handles.pb_pest_settings,'Enable', 'off');
set(handles.rad_zest,'Enable', 'off');
set(handles.rad_quest,'Enable', 'off');
set(handles.rad_manual,'Enable', 'off');
set(handles.rad_zest,'Value', 0);
set(handles.rad_quest,'Value', 0);
set(handles.rad_manual,'Value', 0);
%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes when user attempts to close fig_edit_track_settings.
function fig_edit_track_settings_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_edit_track_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
if PP.dontopenparent~=1
    ap_edit_main
end
PP.dontopenparent=0;

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on key press with focus on ed_track_name and no controls selected.
function ed_track_name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_track_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_range and no controls selected.
function ed_range_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da Änderungen vorgenommen wurden, die der User möglicherweise Rückgängig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes when selected object is changed in bg_type_of_MLBayes.
function bg_type_of_MLBayes_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in bg_type_of_MLBayes 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global TSP PP
    rad_tag = get(eventdata.NewValue, 'Tag');
    switch rad_tag;
        case 'rad_zest'
            TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{2,1}=31; %MLBayes Typ
            % Vorselektion der Weibull-Funktion als psychometrische.
            TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,15}=2;
            % Vorselektion der "modified hyperbolic pdf"
            TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,5}=4;
            % Vorselektion der central tendency als "mean"
            TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,8}=2;
            % Die  "prior pdf" wird nicht ausgeschlossen
            TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,4}=0;
            % Da ZEST bereits bei 20 trials konvergiert (Siehe Otto(2008)),
            % ist das der neue default-Wert hierfür.
            TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,10}=20;
          
        case 'rad_quest'
            TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{2,1}=32; %MLBayes Typ
            % Vorselektion der Weibull-Funktion als psychometrische.
            TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,15}=2;
            % Vorselektion der "gaussian pdf"
            TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,5}=2;
            % Vorselektion der central tendency als "mode"
            TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,8}=1;
            % Vorselektion von "exclude prior"
            TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,4}=1;
            % 40 Trials vorselektiert
            TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,10}=40;
            
        case 'rad_manual' % Standardwerte
            TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{2,1}=33; %MLBayes Typ
            % Vorselektion der logistischen als psychometrische Funktion.
            TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,15}=1;
            % Vorselektion der impliciten Trials
            TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,5}=1;
            % Vorselektion der central tendency als "mode"
            TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,8}=1;
            % 40 Trials vorselektiert
            TSP.sections{PP.edit_section_line,4}{PP.edit_track_line,7}{1,4}{1,10}=40;
    end
    
set(handles.pb_cancel,'Enable', 'on');


% --- Executes when selected object is changed in pan_type_of_procedure.
function pan_type_of_procedure_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in pan_type_of_procedure 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

% function update_pThresholdvalue(psyfun_typ, gamma, lambda, beta, epsilon, range, handles)
% global TSP
% 
% switch psyfun_typ
%     case 1 % logistische
%         PsyFunc = gamma + ((1-gamma-lambda)./(1+exp(-(x-range)/beta))); 
%         
%     case 2 % Weibull Funktion
%         PsyFunc = 1 - lambda - ((1-gamma-lambda)./(exp(10.^((beta/20)*(x-range+epsilon))))); 
% end
% 
% pThresh = PsyFunc(range);
% set(handles.ed_pT('Value',pThresh));
% % und in die TSP schreiben. ? Oder woanders hin? Plotten vielleicht?

