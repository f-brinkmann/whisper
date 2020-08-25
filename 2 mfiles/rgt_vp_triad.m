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


function varargout = rgt_vp_triad(varargin)
% RGT_VP_TRIAD M-file for rgt_vp_triad.fig
%      RGT_VP_TRIAD, by itself, creates a new RGT_VP_TRIAD or raises the existing
%      singleton*.
%
%      H = RGT_VP_TRIAD returns the handle to a new RGT_VP_TRIAD or the handle to
%      the existing singleton*.
%
%      RGT_VP_TRIAD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RGT_VP_TRIAD.M with the given input arguments.
%
%      RGT_VP_TRIAD('Property','Value',...) creates a new RGT_VP_TRIAD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rgt_vp_triad_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rgt_vp_triad_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rgt_vp_triad

% Last Modified by GUIDE v2.5 24-Oct-2008 04:22:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rgt_vp_triad_OpeningFcn, ...
                   'gui_OutputFcn',  @rgt_vp_triad_OutputFcn, ...
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


% --- Executes just before rgt_vp_triad is made visible.
function rgt_vp_triad_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rgt_vp_triad (see VARARGIN)

% Choose default command line output for rgt_vp_triad
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rgt_vp_triad wait for user response (see UIRESUME)
% uiwait(handles.fig_rgt_vp_triad);

global PP TSP
set(hObject,'Name',TSP.sections{PP.run_section_line,3});
movegui(hObject,'center')
set(handles.txt_short_instruction,'String',TSP.sections{PP.run_section_line,5}{1,5});

% --- Outputs from this function are returned to the command line.
function varargout = rgt_vp_triad_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global PP TSD

set(handles.pan_triad,'Title',['Hörbeispiel ' num2str(PP.counter) ' / ' num2str(length(PP.playlist))]);
set(handles.txt_session,'String',['session: ' num2str(TSD{PP.run_number+1,3})]);
set(handles.txt_subject_id,'String',['subject: ' TSD{PP.run_number+1,2}]);
set(handles.pan_step,'Title',['Schritt ' num2str(PP.step)]);
PP.triad_completely_listened=[];

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_y.
function pb_y_Callback(hObject, eventdata, handles)
% hObject    handle to pb_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP TSP
triad_nr=PP.playlist(PP.counter);
stimulus_id=TSP.sections{PP.run_section_line,5}{1,1}(triad_nr,2);
present_stimulus(stimulus_id);
PP.triad_completely_listened(2)=1;


% --- Executes on button press in pb_x.
function pb_x_Callback(hObject, eventdata, handles)
% hObject    handle to pb_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP TSP
triad_nr=PP.playlist(PP.counter);
stimulus_id=TSP.sections{PP.run_section_line,5}{1,1}(triad_nr,1);
present_stimulus(stimulus_id);
PP.triad_completely_listened(1)=1;


% --- Executes on button press in pb_z.
function pb_z_Callback(hObject, eventdata, handles)
% hObject    handle to pb_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP TSP
triad_nr=PP.playlist(PP.counter);
stimulus_id=TSP.sections{PP.run_section_line,5}{1,1}(triad_nr,3);
present_stimulus(stimulus_id);
PP.triad_completely_listened(3)=1;


function ed_sim_1_Callback(hObject, eventdata, handles)
% hObject    handle to ed_sim_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_sim_1 as text
%        str2double(get(hObject,'String')) returns contents of ed_sim_1 as a double


% --- Executes during object creation, after setting all properties.
function ed_sim_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_sim_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_sim_2_Callback(hObject, eventdata, handles)
% hObject    handle to ed_sim_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_sim_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_sim_2 as a double


% --- Executes during object creation, after setting all properties.
function ed_sim_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_sim_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_ok.
function pb_ok_Callback(hObject, eventdata, handles)
% hObject    handle to pb_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP TSP

sim_1=get(handles.ed_sim_1, 'String');
sim_2=get(handles.ed_sim_2, 'String');
switch sim_1
    case 'x'
        sim_1='X';
    case 'y'
        sim_1='Y';
    case 'z'
        sim_1='Z';
end
switch sim_2
    case 'x'
        sim_2='X';
    case 'y'
        sim_2='Y';
    case 'z'
        sim_2='Z';
end
        
if isempty(sim_1)==0 && isempty(sim_2)==0 && sim_1~=sim_2 && (sim_1=='X' || sim_1=='Y' || sim_1=='Z') && (sim_2=='X' || sim_2=='Y' || sim_2=='Z') && sum(PP.triad_completely_listened)==3
    set(handles.txt_similarity,'String',['Welche Eigenschaft macht ' sim_1 ' und ' sim_2 ' ähnlich?'],'Visible','On');
    x_present=0;
    y_present=0;
%     z_present=0;
    if sim_1=='X' || sim_2=='X', x_present=1;end
    if sim_1=='Y' || sim_2=='Y', y_present=1;end
    if sim_1=='Z' || sim_2=='Z', z_present=1;end
    if x_present==0
        not_chosen='X';
    elseif y_present==0
        not_chosen='Y';
    else
        not_chosen='Z';
    end
    set(handles.txt_difference,'String',['Welche Eigenschaft unterscheidet ' not_chosen ' von ' sim_1 ' / ' sim_2 '?'],'Visible','On');
    set(handles.ed_similarity,'Visible','On');
    set(handles.txt_difference,'Visible','On');
    set(handles.ed_difference,'Visible','On');
    set(handles.pan_weitere,'Visible','On');
    
    if TSP.sections{PP.run_section_line,5}{1,3}==PP.step %wenn letzter erlaubter Schritt erreicht, nur noch weiter-Möglichkeit anbieten
      set(handles.pb_ja,'Visible','Off');
      set(handles.pb_nein,'String','zum nächsten Hörbeispiel');
      set(handles.txt_weitere,'Visible','Off');
    end    
end


function ed_similarity_Callback(hObject, eventdata, handles)
% hObject    handle to ed_similarity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_similarity as text
%        str2double(get(hObject,'String')) returns contents of ed_similarity as a double


% --- Executes during object creation, after setting all properties.
function ed_similarity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_similarity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_difference_Callback(hObject, eventdata, handles)
% hObject    handle to ed_difference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_difference as text
%        str2double(get(hObject,'String')) returns contents of ed_difference as a double


% --- Executes during object creation, after setting all properties.
function ed_difference_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_difference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_ja.
function pb_ja_Callback(hObject, eventdata, handles)
% hObject    handle to pb_ja (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP TSP

%Speichern des Begriffspaares
next_line=size(TSP.sections{PP.run_section_line,4}{1,5},1)+1;
TSP.sections{PP.run_section_line,4}{1,5}{next_line,1}=get(handles.ed_similarity,'String');
TSP.sections{PP.run_section_line,4}{1,5}{next_line,2}=get(handles.ed_difference,'String');
TSP.sections{PP.run_section_line,4}{1,5}{next_line,3}='+';
PP.allowed_to_close=1;
close
PP.allowed_to_close=0;
PP.step=PP.step+1;
rgt_vp_triad


% --- Executes on button press in pb_nein.
function pb_nein_Callback(hObject, eventdata, handles)
% hObject    handle to pb_nein (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP TSP TSD
%Speichern des Begriffspaares
next_line=size(TSP.sections{PP.run_section_line,4}{1,5},1)+1;
TSP.sections{PP.run_section_line,4}{1,5}{next_line,1}=get(handles.ed_similarity,'String');
TSP.sections{PP.run_section_line,4}{1,5}{next_line,2}=get(handles.ed_difference,'String');
TSP.sections{PP.run_section_line,4}{1,5}{next_line,3}='+';

PP.allowed_to_close=1;
close
PP.allowed_to_close=0;
%logfile-zeugs

PP.step=1;
PP.counter=PP.counter+1;
if PP.counter>length(PP.playlist) %wenn Triads vorbei, dann Rating vorbereiten
    save ([PP.path filesep 'TSD'],'TSD');
    %Objekt-Playlist für das rating generieren
    if TSP.sections{PP.run_section_line,4}{1,6}{1,1}==1 %bei zufälliger auswahl aus allen objekten
            objektanzahl=length(TSP.sections{PP.run_section_line,4}{1,1}(:,1));
            PP.playlist=randperm(objektanzahl); %liefert zufällige Abfolge aller vorhandenen Objekte
    else %bei Nutzung der Session/sequence-Funktion
            sessionnr=str2num(TSD{PP.run_number+1,3});
            templist=TSP.sections{PP.run_section_line,4}{1,6}{sessionnr,2};
            if TSP.sections{PP.run_section_line,4}{1,6}{1,3}==1, PP.playlist=templist; end %as defined
            if TSP.sections{PP.run_section_line,4}{1,6}{1,3}==1, PP.playlist=templist(randperm(length(templist))); end %play defined list random
    end
    PP.counter=1;
    rgt_vp_triad_exit
else %sonst weiter Triads
    rgt_vp_triad
end


% --- Executes on key press with focus on ed_sim_1 and no controls selected.
function ed_sim_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_sim_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    set(handles.txt_similarity,'String','','Visible','Off');
    set(handles.ed_similarity,'Visible','Off');
    set(handles.txt_difference,'String','','Visible','Off');
    set(handles.ed_difference,'Visible','Off');
    set(handles.pan_weitere,'Visible','Off');


% --- Executes when user attempts to close fig_rgt_vp_triad.
function fig_rgt_vp_triad_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_rgt_vp_triad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
if PP.allowed_to_close==1
    delete(hObject);
end


% --- Executes on key press with focus on ed_sim_2 and no controls selected.
function ed_sim_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_sim_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    set(handles.txt_similarity,'String','','Visible','Off');
    set(handles.ed_similarity,'Visible','Off');
    set(handles.txt_difference,'String','','Visible','Off');
    set(handles.ed_difference,'Visible','Off');
    set(handles.pan_weitere,'Visible','Off');

