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
% Updated:   15-Jul-2009 by Andreas Rotter
% =========================================================================


function varargout = edit_procedures(varargin)
% EDIT_PROCEDURES M-file for edit_procedures.fig
%      EDIT_PROCEDURES, by itself, creates a new EDIT_PROCEDURES or raises the existing
%      singleton*.
%
%      H = EDIT_PROCEDURES returns the handle to a new EDIT_PROCEDURES or the handle to
%      the existing singleton*.
%
%      EDIT_PROCEDURES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDIT_PROCEDURES.M with the given input arguments.
%
%      EDIT_PROCEDURES('Property','Value',...) creates a new EDIT_PROCEDURES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before edit_procedures_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to edit_procedures_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help edit_procedures

% Last Modified by GUIDE v2.5 11-Aug-2008 13:28:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @edit_procedures_OpeningFcn, ...
                   'gui_OutputFcn',  @edit_procedures_OutputFcn, ...
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


% --- Executes just before edit_procedures is made visible.
function edit_procedures_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to edit_procedures (see VARARGIN)

% Choose default command line output for edit_procedures
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes edit_procedures wait for user response (see UIRESUME)
% uiwait(handles.fig_edit_procedures);

movegui(hObject,'center')
global TSP PP
load ([PP.path filesep 'TSP.mat']);
set(handles.txt_testseries_name,'String',TSP.name);
fill_list_atp(handles)
fill_list_sots(handles)
if isfield (PP, 'edit_section_line')
    last_section=length(TSP.sections(:,1));
    if PP.edit_section_line>last_section
        PP.edit_section_line=last_section;
    end
    if PP.edit_section_line==0
        PP.edit_section_line=1;
    end
    set(handles.lb_sections_of_test_series,'Value', PP.edit_section_line);
end


function fill_list_atp(handles)
% Inhalt der Liste lb_available_testing_procedures wird generiert.
% Jeder Schleifendurchlauf generiert eine Zeile der Liste.

global PC

for i=1:length(PC.testing_procedures(:,1))
   atp_list{i,1}=PC.testing_procedures{i,2};
end
set(handles.lb_available_testing_procedures,'String', atp_list);


function fill_list_sots(handles)
% Inhalt der Liste lb_sections_of_test_series wird generiert.
% Mit Hilfe der Funktion str_to_len.m werden die Inhalte in die richtige
% L?nge gebracht f?r die tabellarisch korrekte Darstellung, jeder
% Schleifendurchlauf generiert dabei eine Zeile der Liste.
global TSP

if isempty(TSP.sections)==0
  for i=1:length(TSP.sections(:,1))
     sots_list{i,1}=[str_to_len(num2str(i), 6) ...%Spalte: Nr. 
                        str_to_len(TSP.sections{i,2}, 36) ' '...%Spalte: interner Name
                        str_to_len(TSP.sections{i,3}, 36)];      %Spalte: Name f?r VP sichtbar
  end
  set(handles.lb_sections_of_test_series,'String', sots_list);
else
  set(handles.lb_sections_of_test_series,'String','');  
end


% --- Outputs from this function are returned to the command line.
function varargout = edit_procedures_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in lb_sections_of_test_series.
function lb_sections_of_test_series_Callback(hObject, eventdata, handles)
% hObject    handle to lb_sections_of_test_series (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lb_sections_of_test_series contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_sections_of_test_series

fill_section_edit_fields(handles)


%Felder zum Bearbeiten der Namen werden mit diese Funktion gef?llt
function fill_section_edit_fields(handles)
global TSP
if isempty(TSP.sections)==0
    editline=get(handles.lb_sections_of_test_series, 'Value');
    set(handles.ed_section, 'String', editline);
    set(handles.ed_internal_label, 'String', TSP.sections{editline,2});
    set(handles.ed_synonym, 'String', TSP.sections{editline,3});
end


% --- Executes during object creation, after setting all properties.
function lb_sections_of_test_series_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_sections_of_test_series (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_specify_test_properties.
function pb_specify_test_properties_Callback(hObject, eventdata, handles)
% hObject    handle to pb_specify_test_properties (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP TSP

%die angew?hlte Sektion wird ausgelesen (und als Parameter abgelegt)
PP.edit_section_line=get(handles.lb_sections_of_test_series,'Value');

if isempty(PP.edit_section_line) == 0
        
    %das dazugeh?rige Testverfahren ermittelt
    type=TSP.sections{PP.edit_section_line,1};
    PP.dontopenparent=1;
    pb_save_Callback(hObject, eventdata, handles) %Speichern der Daten und Schlie?en
    %und das entsprechende GUI aufgerufen
    switch type
        case 'tid1'
            ap_edit_main
        case 'tid2'
            rgt_edit_main
        case 'tid3'
            sd_edit_main
        case 'tid4'
            abx_edit_main
        case 'tid5'
            saqi_edit_main
        case 'tid6'
            abchr_mushra_edit_main
    end
end


% --- Executes on button press in pb_delete.
function pb_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pb_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP
if isempty(TSP.sections)==0
   deleteline=get(handles.lb_sections_of_test_series,'Value');
   set(handles.lb_sections_of_test_series,'Value', 1);
   TSP.sections(deleteline,:)=[];
   fill_list_sots(handles);
 %Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
 %User m?glicherweise R?ckg?ngig machen will
   set(handles.pb_cancel,'Enable', 'on');
end    
    

% --- Executes on selection change in lb_available_testing_procedures.
function lb_available_testing_procedures_Callback(hObject, eventdata, handles)
% hObject    handle to lb_available_testing_procedures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lb_available_testing_procedures contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_available_testing_procedures


% --- Executes during object creation, after setting all properties.
function lb_available_testing_procedures_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_available_testing_procedures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_add_to_list_below.
function pb_add_to_list_below_Callback(hObject, eventdata, handles)
% hObject    handle to pb_add_to_list_below (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PC
procedure_to_add=get(handles.lb_available_testing_procedures,'Value');
newline=1;
if isempty(TSP.sections)==0
    newline=length(TSP.sections(:,1))+1;
end
TSP.sections{newline,1}=PC.testing_procedures{procedure_to_add,1};
TSP.sections{newline,2}=PC.testing_procedures{procedure_to_add,2};
TSP.sections{newline,3}='Teil A';
TSP.sections{newline,4}=PC.testing_procedures{procedure_to_add,3};
TSP.sections{newline,5}=PC.testing_procedures{procedure_to_add,4};


fill_list_sots(handles);
 %Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
 %User m?glicherweise R?ckg?ngig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in pb_move_up.
function pb_move_up_Callback(hObject, eventdata, handles)
% hObject    handle to pb_move_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP
line_to_move_up=get(handles.lb_sections_of_test_series, 'Value');
if line_to_move_up > 1
    temp=TSP.sections(line_to_move_up-1,:);
    TSP.sections(line_to_move_up-1,:)=TSP.sections(line_to_move_up,:);
    TSP.sections(line_to_move_up,:)=temp;
    fill_list_sots(handles)
    set(handles.lb_sections_of_test_series,'Value', line_to_move_up-1);
    fill_section_edit_fields(handles)
    %Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
    %User m?glicherweise R?ckg?ngig machen will
    set(handles.pb_cancel,'Enable', 'on');
end


% --- Executes on button press in pb_move_down.
function pb_move_down_Callback(hObject, eventdata, handles)
% hObject    handle to pb_move_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP
line_to_move_down=get(handles.lb_sections_of_test_series, 'Value');
if isempty(TSP.sections)==0
    lastline=length(TSP.sections(:,1));
    if line_to_move_down < lastline
      temp=TSP.sections(line_to_move_down+1,:);
      TSP.sections(line_to_move_down+1,:)=TSP.sections(line_to_move_down,:);
      TSP.sections(line_to_move_down,:)=temp;
      fill_list_sots(handles)
      set(handles.lb_sections_of_test_series,'Value', line_to_move_down+1);
      fill_section_edit_fields(handles)
     %Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
     %User m?glicherweise R?ckg?ngig machen will
      set(handles.pb_cancel,'Enable', 'on');
    end
end


function ed_internal_label_Callback(hObject, eventdata, handles)
% hObject    handle to ed_internal_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_internal_label as text
%        str2double(get(hObject,'String')) returns contents of ed_internal_label as a double


% --- Executes during object creation, after setting all properties.
function ed_internal_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_internal_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_synonym_Callback(hObject, eventdata, handles)
% hObject    handle to ed_synonym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_synonym as text
%        str2double(get(hObject,'String')) returns contents of ed_synonym as a double


% --- Executes during object creation, after setting all properties.
function ed_synonym_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_synonym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_section_Callback(hObject, eventdata, handles)
% hObject    handle to ed_section (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_section as text
%        str2double(get(hObject,'String')) returns contents of ed_section as a double


% --- Executes during object creation, after setting all properties.
function ed_section_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_section (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_apply.
function pb_apply_Callback(hObject, eventdata, handles)
% hObject    handle to pb_apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP
editline=get(handles.lb_sections_of_test_series, 'Value');
TSP.sections{editline,2}=get(handles.ed_internal_label, 'String');
TSP.sections{editline,3}=get(handles.ed_synonym, 'String');
fill_list_sots(handles)
fill_section_edit_fields(handles)
 %Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
 %User m?glicherweise R?ckg?ngig machen will
set(handles.pb_cancel,'Enable', 'on');


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
save ([PP.path filesep 'TSP.mat'],'TSP');
close


% --- Executes when user attempts to close fig_edit_procedures.
function fig_edit_procedures_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_edit_procedures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
if PP.dontopenparent~=1
    mainmenu
end
PP.dontopenparent=0;

% Hint: delete(hObject) closes the figure
delete(hObject);

