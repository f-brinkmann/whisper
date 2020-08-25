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


function varargout = rgt_edit_constructs(varargin)
% RGT_EDIT_CONSTRUCTS M-file for rgt_edit_constructs.fig
%      RGT_EDIT_CONSTRUCTS, by itself, creates a new RGT_EDIT_CONSTRUCTS or raises the existing
%      singleton*.
%
%      H = RGT_EDIT_CONSTRUCTS returns the handle to a new RGT_EDIT_CONSTRUCTS or the handle to
%      the existing singleton*.
%
%      RGT_EDIT_CONSTRUCTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RGT_EDIT_CONSTRUCTS.M with the given input arguments.
%
%      RGT_EDIT_CONSTRUCTS('Property','Value',...) creates a new RGT_EDIT_CONSTRUCTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rgt_edit_constructs_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rgt_edit_constructs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rgt_edit_constructs

% Last Modified by GUIDE v2.5 21-Oct-2008 05:16:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rgt_edit_constructs_OpeningFcn, ...
                   'gui_OutputFcn',  @rgt_edit_constructs_OutputFcn, ...
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


% --- Executes just before rgt_edit_constructs is made visible.
function rgt_edit_constructs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rgt_edit_constructs (see VARARGIN)

% Choose default command line output for rgt_edit_constructs
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rgt_edit_constructs wait for user response (see UIRESUME)
% uiwait(handles.figure1);

movegui(hObject,'center')
global TSP PP TSD
set(hObject,'Name',['RGT - edit constructs (' TSP.sections{PP.run_section_line,2} ')']);
set(handles.txt_session,'String',['session: ' num2str(TSD{PP.run_number+1,3})]);
set(handles.txt_subject_id,'String',['subject: ' TSD{PP.run_number+1,2}]);
PP.deleted_constructs={}; %initianlisierung für später
fill_list(handles)


function fill_list(handles)
% Inhalt der Liste lb_constructs wird generiert.
% Mit Hilfe der Funktion str_to_len.m werden die Inhalte in die richtige
% Länge gebracht für die tabellarisch korrekte Darstellung, jeder
% Schleifendurchlauf generiert dabei eine Zeile der Liste.
global TSP PP

if isempty(TSP.sections{PP.run_section_line,4}{1,5})==0
  for i=1:length(TSP.sections{PP.run_section_line,4}{1,5}(:,1))
     item_list{i,1}=[str_to_len(num2str(i), 5) ...%Spalte: item(no.)
                        str_to_len(TSP.sections{PP.run_section_line,4}{1,5}{i,1}, 23) ' '...%Spalte: low pole
                        str_to_len(TSP.sections{PP.run_section_line,4}{1,5}{i,2}, 23) ' '...%Spalte: high pole
                        str_to_len(TSP.sections{PP.run_section_line,4}{1,5}{i,3}, 2)];      %Spalte: polarity
  end
  set(handles.lb_constructs,'String', item_list);
else
  set(handles.lb_constructs,'String','');  
end


function fill_list_deleted(handles)
% Inhalt der Liste lb_constructs wird generiert.
% Mit Hilfe der Funktion str_to_len.m werden die Inhalte in die richtige
% Länge gebracht für die tabellarisch korrekte Darstellung, jeder
% Schleifendurchlauf generiert dabei eine Zeile der Liste.
global PP

if isempty(PP.deleted_constructs)==0
  for i=1:length(PP.deleted_constructs(:,1))
     item_list{i,1}=[str_to_len(num2str(i), 5) ...%Spalte: item(no.)
                        str_to_len(PP.deleted_constructs{i,1}, 13) ' '...%Spalte: low pole
                        str_to_len(PP.deleted_constructs{i,2}, 13) ' '...%Spalte: high pole
                        str_to_len(PP.deleted_constructs{i,3}, 2)];      %Spalte: polarity
  end
  set(handles.lb_deleted_constructs,'String', item_list);
else
  set(handles.lb_deleted_constructs,'String','');  
end


%Felder zum Bearbeiten der Items werden mit dieser Funktion gefüllt
function fill_item_edit_fields(handles)
global TSP PP
if isempty(TSP.sections{PP.run_section_line,4}{1,5})==0
    editline=get(handles.lb_constructs, 'Value');
    set(handles.ed_item, 'String', editline);
    set(handles.ed_low_pole, 'String', TSP.sections{PP.run_section_line,4}{1,5}{editline,1});
    set(handles.ed_high_pole, 'String', TSP.sections{PP.run_section_line,4}{1,5}{editline,2});
    set(handles.ed_polarity, 'String', TSP.sections{PP.run_section_line,4}{1,5}{editline,3});
end


% --- Outputs from this function are returned to the command line.
function varargout = rgt_edit_constructs_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_delete_construct.
function pb_delete_construct_Callback(hObject, eventdata, handles)
% hObject    handle to pb_delete_construct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP
if isempty(TSP.sections{PP.run_section_line,4}{1,5})==0
   deleteline=get(handles.lb_constructs,'Value');
   set(handles.lb_constructs,'Value', 1);
   % als gelöschtes Konstrukt sichern
   newline_in_deleted=size(PP.deleted_constructs,1)+1;
   PP.deleted_constructs(newline_in_deleted,1:3)=TSP.sections{PP.run_section_line,4}{1,5}(deleteline,1:3);
   % löschen
   TSP.sections{PP.run_section_line,4}{1,5}(deleteline,:)=[];
   fill_list(handles);
   fill_item_edit_fields(handles)
   fill_list_deleted(handles)
end


% --- Executes on button press in pb_move_up.
function pb_move_up_Callback(hObject, eventdata, handles)
% hObject    handle to pb_move_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP
line_to_move_up=get(handles.lb_constructs, 'Value');
if line_to_move_up > 1
    temp=TSP.sections{PP.run_section_line,4}{1,5}(line_to_move_up-1,:);
    TSP.sections{PP.run_section_line,4}{1,5}(line_to_move_up-1,:)=TSP.sections{PP.run_section_line,4}{1,5}(line_to_move_up,:);
    TSP.sections{PP.run_section_line,4}{1,5}(line_to_move_up,:)=temp;
    fill_list(handles)
    set(handles.lb_constructs,'Value', line_to_move_up-1);
    fill_item_edit_fields(handles)
end


% --- Executes on button press in pb_move_down.
function pb_move_down_Callback(hObject, eventdata, handles)
% hObject    handle to pb_move_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP
line_to_move_down=get(handles.lb_constructs, 'Value');
if isempty(TSP.sections{PP.run_section_line,4}{1,5})==0
    lastline=length(TSP.sections{PP.run_section_line,4}{1,5}(:,1));
    if line_to_move_down < lastline
      temp=TSP.sections{PP.run_section_line,4}{1,5}(line_to_move_down+1,:);
      TSP.sections{PP.run_section_line,4}{1,5}(line_to_move_down+1,:)=TSP.sections{PP.run_section_line,4}{1,5}(line_to_move_down,:);
      TSP.sections{PP.run_section_line,4}{1,5}(line_to_move_down,:)=temp;
      fill_list(handles)
      set(handles.lb_constructs,'Value', line_to_move_down+1);
      fill_item_edit_fields(handles)
    end
end


% --- Executes on button press in pb_undelete.
function pb_undelete_Callback(hObject, eventdata, handles)
% hObject    handle to pb_undelete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP
if isempty(PP.deleted_constructs)==0
   deleteline=get(handles.lb_deleted_constructs,'Value');
   set(handles.lb_deleted_constructs,'Value', 1);
   % als gelöschtes Konstrukt sichern
   newline_in_constructs=size(TSP.sections{PP.run_section_line,4}{1,5},1)+1;
   TSP.sections{PP.run_section_line,4}{1,5}(newline_in_constructs,1:3)=PP.deleted_constructs(deleteline,1:3);
   % löschen
   PP.deleted_constructs(deleteline,:)=[];
   fill_list(handles);
   fill_item_edit_fields(handles)
   fill_list_deleted(handles)
end
fill_list_deleted(handles)


% --- Executes on button press in pb_resume.
function pb_resume_Callback(hObject, eventdata, handles)
% hObject    handle to pb_resume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close
global PP TSP TSD
%daten in TSD schreiben
for i=1:length(TSP.sections{PP.run_section_line,4}{1,5}(:,1))
%Spalten-Überschriften für Export generieren
    TSD{1,3+PP.run_section_line}{1,i}{1,1}=['lp_c' num2str(i)];
    TSD{1,3+PP.run_section_line}{1,i}{1,2}=['hp_c' num2str(i)];
    %inhalte speichern
    TSD{PP.run_number+1,3+PP.run_section_line}{1,i}{1,1}=TSP.sections{PP.run_section_line,4}{1,5}{i,1};
    TSD{PP.run_number+1,3+PP.run_section_line}{1,i}{1,2}=TSP.sections{PP.run_section_line,4}{1,5}{i,2};
end
% TSP.sections{PP.run_section_line,4}{1,5}
rgt_vp_rating_init


function ed_low_pole_Callback(hObject, eventdata, handles)
% hObject    handle to ed_low_pole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_low_pole as text
%        str2double(get(hObject,'String')) returns contents of ed_low_pole as a double


% --- Executes during object creation, after setting all properties.
function ed_low_pole_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_low_pole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_high_pole_Callback(hObject, eventdata, handles)
% hObject    handle to ed_high_pole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_high_pole as text
%        str2double(get(hObject,'String')) returns contents of ed_high_pole as a double


% --- Executes during object creation, after setting all properties.
function ed_high_pole_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_high_pole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lb_constructs.
function lb_constructs_Callback(hObject, eventdata, handles)
% hObject    handle to lb_constructs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lb_constructs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_constructs

fill_item_edit_fields(handles)


% --- Executes during object creation, after setting all properties.
function lb_constructs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_constructs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_switch_polarity.
function pb_switch_polarity_Callback(hObject, eventdata, handles)
% hObject    handle to pb_switch_polarity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

before=get(handles.ed_polarity, 'String');
if before=='+'
    after='-';
else
    after='+';
end
set(handles.ed_polarity, 'String', after);


% --- Executes on button press in pb_apply.
function pb_apply_Callback(hObject, eventdata, handles)
% hObject    handle to pb_apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP
editline=get(handles.lb_constructs, 'Value');
TSP.sections{PP.run_section_line,4}{1,5}{editline,1}=get(handles.ed_low_pole, 'String');
TSP.sections{PP.run_section_line,4}{1,5}{editline,2}=get(handles.ed_high_pole, 'String');
TSP.sections{PP.run_section_line,4}{1,5}{editline,3}=get(handles.ed_polarity, 'String');
fill_list(handles)
fill_item_edit_fields(handles)


function ed_item_Callback(hObject, eventdata, handles)
% hObject    handle to ed_item (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_item as text
%        str2double(get(hObject,'String')) returns contents of ed_item as a double


% --- Executes during object creation, after setting all properties.
function ed_item_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_item (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_switch_labels.
function pb_switch_labels_Callback(hObject, eventdata, handles)
% hObject    handle to pb_switch_labels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

old_low_pole=get(handles.ed_low_pole, 'String');
old_high_pole=get(handles.ed_high_pole, 'String');
set(handles.ed_high_pole, 'String', old_low_pole)
set(handles.ed_low_pole, 'String', old_high_pole)


function ed_polarity_Callback(hObject, eventdata, handles)
% hObject    handle to ed_polarity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_polarity as text
%        str2double(get(hObject,'String')) returns contents of ed_polarity as a double


% --- Executes during object creation, after setting all properties.
function ed_polarity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_polarity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lb_deleted_constructs.
function lb_deleted_constructs_Callback(hObject, eventdata, handles)
% hObject    handle to lb_deleted_constructs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lb_deleted_constructs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_deleted_constructs


% --- Executes during object creation, after setting all properties.
function lb_deleted_constructs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_deleted_constructs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

