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
% Author :   Andreas Rotter, student at FG Audiokommunikation, TU Berlin
% Email  :   andreas.rotter.kontakt AT googlemail DOT com
% Date   :   23-Aug-2009
% Updated:
% Known Bugs: It it not possible, to perform two a/b/x trials successively,
%             without loosing the results from the former trial.
%             Problem is caused by faulty programming of saving the 
%             the results in the TSP.mat. See abx_vp.m line 246ff. 
%             
% =========================================================================


function varargout = abx_edit_main(varargin)
% ABX_EDIT_MAIN M-file for abx_edit_main.fig
%      ABX_EDIT_MAIN, by itself, creates a new ABX_EDIT_MAIN or raises the existing
%      singleton*.
%
%      H = ABX_EDIT_MAIN returns the handle to a new ABX_EDIT_MAIN or the handle to
%      the existing singleton*.
%
%      ABX_EDIT_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ABX_EDIT_MAIN.M with the given input arguments.
%
%      ABX_EDIT_MAIN('Property','Value',...) creates a new ABX_EDIT_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before abx_edit_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to abx_edit_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help abx_edit_main

% Last Modified by GUIDE v2.5 20-Mar-2014 11:47:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @abx_edit_main_OpeningFcn, ...
                   'gui_OutputFcn',  @abx_edit_main_OutputFcn, ...
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


% --- Executes just before abx_edit_main is made visible.
function abx_edit_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to abx_edit_main (see VARARGIN)

% Choose default command line output for abx_edit_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes abx_edit_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);

movegui(hObject,'center');
global TSP PP
load ([PP.path filesep 'TSP.mat']);
%Auff?llen der GUI mit den gepeicherten Werten oder den Voreinstellungen
%aus der PC
set(hObject,'Name',['ABX - main settings (' TSP.sections{PP.edit_section_line,2} ')']);

set(handles.ed_initial_subject_instruction,'String', TSP.sections{PP.edit_section_line,4}{1,2});
set(handles.ed_short_instruction,'String', TSP.sections{PP.edit_section_line,4}{1,3});
set(handles.ed_numbertrials,'String',TSP.sections{PP.edit_section_line,4}{1,4}{1,1});
set(handles.ed_correctanswers,'String',TSP.sections{PP.edit_section_line,4}{1,4}{1,2});
set(handles.ed_significancelevel,'String',TSP.sections{PP.edit_section_line,4}{1,4}{1,3});
set(handles.ed_effectsize,'String',TSP.sections{PP.edit_section_line,4}{1,4}{1,4});
%set(handles.ed_nullhypothesis,'String',TSP.sections{PP.edit_section_line,4}{1,4}{1,5});
set(handles.ed_althypothesis,'String',TSP.sections{PP.edit_section_line,4}{1,4}{1,6});

%Stimuli setting
if isempty(TSP.sections{PP.edit_section_line,4}{1,5}) == 0
set(handles.txt_assign_a,'String',TSP.stimuli{TSP.sections{PP.edit_section_line,4}{1,5}(1,1),2});
set(handles.txt_assign_b,'String',TSP.stimuli{TSP.sections{PP.edit_section_line,4}{1,5}(1,2),2});
end

% --- Outputs from this function are returned to the command line.
function varargout = abx_edit_main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes when user attempts to close fig_abx_edit_main.
function fig_abx_edit_main_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_abx_edit_main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP

if PP.dontopenparent~=1
    edit_procedures
end
PP.dontopenparent=0;

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in pb_save.
function pb_save_Callback(hObject, eventdata, handles)
% hObject    handle to pb_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP TSP

TSP.sections{PP.edit_section_line,4}{1,2}=cellstr(get(handles.ed_initial_subject_instruction,'String'));
TSP.sections{PP.edit_section_line,4}{1,3}=cellstr(get(handles.ed_short_instruction,'String'));
TSP.sections{PP.edit_section_line,4}{1,4}{1,1}=get(handles.ed_numbertrials,'String');
TSP.sections{PP.edit_section_line,4}{1,4}{1,2}=get(handles.ed_correctanswers,'String');
TSP.sections{PP.edit_section_line,4}{1,4}{1,3}=get(handles.ed_significancelevel,'String');
TSP.sections{PP.edit_section_line,4}{1,4}{1,4}=get(handles.ed_effectsize,'String');
%TSP.sections{PP.edit_section_line,4}{1,4}{1,5}=get(handles.ed_nullhypothesis,'String');
TSP.sections{PP.edit_section_line,4}{1,4}{1,6}=get(handles.ed_althypothesis,'String');
%TSP.sections{PP.edit_section_line,4}{1,1}=num2str(get(handles.cb_randomstimuli,'Value'));
save ([PP.path filesep 'TSP.mat'],'TSP');

close
edit_procedures

% --- Executes on button press in pb_cancel.
function pb_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
edit_procedures

function ed_short_instruction_Callback(hObject, eventdata, handles)
% hObject    handle to ed_short_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_short_instruction as text
%        str2double(get(hObject,'String')) returns contents of ed_short_instruction as a double


% --- Executes during object creation, after setting all properties.
function ed_short_instruction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_short_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_initial_subject_instruction_Callback(hObject, eventdata, handles)
% hObject    handle to ed_initial_subject_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_initial_subject_instruction as text
%        str2double(get(hObject,'String')) returns contents of ed_initial_subject_instruction as a double


% --- Executes during object creation, after setting all properties.
function ed_initial_subject_instruction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_initial_subject_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pb_refresh.
function pb_refresh_Callback(hObject, eventdata, handles)
% hObject    handle to pb_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Parameter werden aus dem GUI abgeholt
num_trials=get(handles.ed_numbertrials,'String');
corr_answ=get(handles.ed_correctanswers,'String');
sig_level=get(handles.ed_significancelevel,'String');
eff_size=get(handles.ed_effectsize,'String');
alt_hypo=get(handles.ed_althypothesis,'String');


% Berechnung, ?bergabe in einer struct
calc_data=abx_parameter(num_trials,corr_answ,sig_level,eff_size,alt_hypo);

% Ergebnisse werden in die entsprechenden Felder eingetragen
set(handles.ed_numbertrials,'String',calc_data.num_trials);
set(handles.ed_correctanswers,'String',calc_data.corr_answ);
set(handles.ed_significancelevel,'String',calc_data.sig_level);
set(handles.ed_effectsize,'String',calc_data.eff_size);
set(handles.ed_althypothesis,'String',calc_data.alt_hypo);

%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
%User m?glicherweise R?ckg?ngig machen will
set(handles.pb_cancel,'Enable', 'on');


function out_para=abx_parameter(num_trial,corr_answ,sig_level,eff_size,alt_hypo)

nullhypo=0.5;
numtrial=str2num(num_trial);
corransw=str2num(corr_answ);
siglevel=str2num(sig_level);
effsize=str2num(eff_size);
althypo=str2num(alt_hypo);

if isempty(siglevel) == 0 & isempty(effsize) == 0 & isempty(althypo) == 0
    z1=abs(norminv(siglevel,0,1));
    z2=abs(norminv(effsize,0,1));
    temp=(z1*sqrt(nullhypo*(1-nullhypo))+z2*sqrt(althypo*(1-althypo)))/(althypo-nullhypo);
    numtrial=ceil(temp*temp);
    corransw=round(z1*sqrt(numtrial*nullhypo*(1-nullhypo))+0.5+numtrial*nullhypo);
       
    out_para.num_trials=numtrial;
    out_para.corr_answ=corransw;
    out_para.sig_level=siglevel;
    out_para.eff_size=effsize;
    out_para.alt_hypo=althypo;
    
elseif (isempty(numtrial) == 0 & isempty(siglevel) == 0 & isempty(corransw) == 1) || ...
       (isempty(numtrial) == 0 & isempty(siglevel) == 0)      
 
    z=abs(norminv(siglevel,0,1));
    corransw=z*sqrt(numtrial*nullhypo*(1-nullhypo))+0.5+numtrial*nullhypo;
    out_para.num_trials=numtrial;
    out_para.corr_answ=ceil(corransw);
    out_para.sig_level=siglevel;
    out_para.eff_size=effsize;
    out_para.alt_hypo=althypo;

else
    abx_calc_info
    
    out_para.num_trials=numtrial;
    out_para.corr_answ=corransw;
    out_para.sig_level=siglevel;
    out_para.eff_size=effsize;
    out_para.alt_hypo=althypo;
end




function ed_numbertrials_Callback(hObject, eventdata, handles)
% hObject    handle to ed_numbertrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_numbertrials as text
%        str2double(get(hObject,'String')) returns contents of ed_numbertrials as a double


% --- Executes during object creation, after setting all properties.
function ed_numbertrials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_numbertrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_correctanswers_Callback(hObject, eventdata, handles)
% hObject    handle to ed_correctanswers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_correctanswers as text
%        str2double(get(hObject,'String')) returns contents of ed_correctanswers as a double


% --- Executes during object creation, after setting all properties.
function ed_correctanswers_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_correctanswers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_significancelevel_Callback(hObject, eventdata, handles)
% hObject    handle to ed_significancelevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_significancelevel as text
%        str2double(get(hObject,'String')) returns contents of ed_significancelevel as a double


% --- Executes during object creation, after setting all properties.
function ed_significancelevel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_significancelevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_effectsize_Callback(hObject, eventdata, handles)
% hObject    handle to ed_effectsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_effectsize as text
%        str2double(get(hObject,'String')) returns contents of ed_effectsize as a double


% --- Executes during object creation, after setting all properties.
function ed_effectsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_effectsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_nullhypothesis_Callback(hObject, eventdata, handles)
% hObject    handle to ed_nullhypothesis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_nullhypothesis as text
%        str2double(get(hObject,'String')) returns contents of ed_nullhypothesis as a double


% --- Executes during object creation, after setting all properties.
function ed_nullhypothesis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_nullhypothesis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_althypothesis_Callback(hObject, eventdata, handles)
% hObject    handle to ed_althypothesis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_althypothesis as text
%        str2double(get(hObject,'String')) returns contents of ed_althypothesis as a double


% --- Executes during object creation, after setting all properties.
function ed_althypothesis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_althypothesis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

 % --- Executes on key press with focus on ed_initial_subject_instruction and no controls selected.
function ed_initial_subject_instruction_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_initial_subject_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der User m?glicherweise R?ckg?ngig machen will
 set(handles.pb_cancel,'Enable', 'on');


% --- Executes on key press with focus on ed_short_instruction and no controls selected.
function ed_short_instruction_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_short_instruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der User m?glicherweise R?ckg?ngig machen will
 set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in pb_edit_assign.
function pb_edit_assign_Callback(hObject, eventdata, handles)
% hObject    handle to pb_edit_assign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%global PP
%PP.edit_track_line=get(handles.lb_tracks,'Value');
%PP.dontopenparent=1; %verhindern, dass beim schlie?en die ?bergeordnete GUI ge?ffnet wird
%pb_save_Callback(hObject, eventdata, handles) %Speichern und schlie?en
abx_stimulus_selection



% --- Executes on selection change in lb_tracks.
function lb_tracks_Callback(hObject, eventdata, handles)
% hObject    handle to lb_tracks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lb_tracks contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_tracks


% --- Executes during object creation, after setting all properties.
function lb_tracks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_tracks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_assign_a_Callback(hObject, eventdata, handles)
% hObject    handle to txt_assign_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_assign_a as text
%        str2double(get(hObject,'String')) returns contents of txt_assign_a as a double


% --- Executes during object creation, after setting all properties.
function txt_assign_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_assign_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_assign_b_Callback(hObject, eventdata, handles)
% hObject    handle to txt_assign_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_assign_b as text
%        str2double(get(hObject,'String')) returns contents of txt_assign_b as a double


% --- Executes during object creation, after setting all properties.
function txt_assign_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_assign_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_refresh_stimuli_list.
function pb_refresh_stimuli_list_Callback(hObject, eventdata, handles)
% hObject    handle to pb_refresh_stimuli_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP

if isempty(TSP.sections{PP.edit_section_line,4}{1,5}) == 0
set(handles.txt_assign_a,'String',TSP.stimuli{TSP.sections{PP.edit_section_line,4}{1,5}(1,1),2});
set(handles.txt_assign_b,'String',TSP.stimuli{TSP.sections{PP.edit_section_line,4}{1,5}(1,2),2});
end
