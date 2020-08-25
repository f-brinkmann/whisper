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


function varargout = sd_edit_scale(varargin)
% SD_EDIT_SCALE M-file for sd_edit_scale.fig
%      SD_EDIT_SCALE, by itself, creates a new SD_EDIT_SCALE or raises the existing
%      singleton*.
%
%      H = SD_EDIT_SCALE returns the handle to a new SD_EDIT_SCALE or the handle to
%      the existing singleton*.
%
%      SD_EDIT_SCALE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SD_EDIT_SCALE.M with the given input arguments.
%
%      SD_EDIT_SCALE('Property','Value',...) creates a new SD_EDIT_SCALE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sd_edit_scale_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sd_edit_scale_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sd_edit_scale

% Last Modified by GUIDE v2.5 10-Oct-2008 03:20:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sd_edit_scale_OpeningFcn, ...
                   'gui_OutputFcn',  @sd_edit_scale_OutputFcn, ...
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


% --- Executes just before sd_edit_scale is made visible.
function sd_edit_scale_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sd_edit_scale (see VARARGIN)

% Choose default command line output for sd_edit_scale
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sd_edit_scale wait for user response (see UIRESUME)
% uiwait(handles.fig_sd_edit_scale);

movegui(hObject,'center')
global TSP PP
set(hObject,'Name',['SD - edit scales (' TSP.sections{PP.edit_section_line,2} ')']);
set(handles.pop_number_of_categories, 'Value', length(TSP.sections{PP.edit_section_line,4}{1,2}(:,1))-1); % -1 f?r Value weil das Popup beim Inhalt 2 beginnt
set(handles.ed_minimum_value, 'String', TSP.sections{PP.edit_section_line,4}{1,2}(1,1));
set(handles.ed_category_width, 'String', TSP.sections{PP.edit_section_line,4}{1,2}(2,1)-TSP.sections{PP.edit_section_line,4}{1,2}(1,1));
set(handles.ed_numerical_representatives, 'String', num2str(TSP.sections{PP.edit_section_line,4}{1,2}(:,1)'));
set(handles.ed_category_labels, 'String', sprintf('%s ', TSP.sections{PP.edit_section_line,4}{1,3}{:,1}));
fill_list(handles)


function fill_list(handles)
% Inhalt der Liste lb_definition_of_items wird generiert.
% Mit Hilfe der Funktion str_to_len.m werden die Inhalte in die richtige
% L?nge gebracht f?r die tabellarisch korrekte Darstellung, jeder
% Schleifendurchlauf generiert dabei eine Zeile der Liste.
global TSP PP

if isempty(TSP.sections{PP.edit_section_line,4}{1,5})==0
  for i=1:length(TSP.sections{PP.edit_section_line,4}{1,5}(:,1))
     item_list{i,1}=[str_to_len(num2str(i), 5) ...%Spalte: item(no.)
                        str_to_len(TSP.sections{PP.edit_section_line,4}{1,5}{i,1}, 13) ' '...%Spalte: low pole
                        str_to_len(TSP.sections{PP.edit_section_line,4}{1,5}{i,2}, 13) ' '...%Spalte: high pole
                        str_to_len(TSP.sections{PP.edit_section_line,4}{1,5}{i,3}, 2)];      %Spalte: polarity
  end
  set(handles.lb_definition_of_items,'String', item_list);
else
  set(handles.lb_definition_of_items,'String','');  
end


% --- Executes on button press in pb_apply_range.
function pb_apply_range_Callback(hObject, eventdata, handles)
% hObject    handle to pb_apply_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP

n=    get(handles.pop_number_of_categories,'Value')+1; %+1 weil popup mit 2 anf?ngt
min=  str2num(get(handles.ed_minimum_value,'String'));
width=str2num(get(handles.ed_category_width,'String'));
TSP.sections{PP.edit_section_line,4}{1,2}=(min:width:min+(n-1)*width)';
set(handles.ed_numerical_representatives, 'String', num2str(TSP.sections{PP.edit_section_line,4}{1,2}(:,1)'));
set(handles.pb_cancel,'Enable', 'on');


% --- Outputs from this function are returned to the command line.
function varargout = sd_edit_scale_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_add_new_item.
function pb_add_new_item_Callback(hObject, eventdata, handles)
% hObject    handle to pb_add_new_item (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP

if isempty(TSP.sections{PP.edit_section_line,4}{1,5})==0
    newline=length(TSP.sections{PP.edit_section_line,4}{1,5}(:,1))+1;
else
    newline=1;
end
if newline<31
    TSP.sections{PP.edit_section_line,4}{1,5}{newline,1}='low pole';
    TSP.sections{PP.edit_section_line,4}{1,5}{newline,2}='high pole';
    TSP.sections{PP.edit_section_line,4}{1,5}{newline,3}='+';
    fill_list(handles);
    set(handles.lb_definition_of_items,'Value', newline);
    fill_item_edit_fields(handles)
 %Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
 %User m?glicherweise R?ckg?ngig machen will
    set(handles.pb_cancel,'Enable', 'on');
else
    PP.whisper_message='the maximum number of items is 30';
    whisper_message
end


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


% --- Executes on selection change in lb_definition_of_items.
function lb_definition_of_items_Callback(hObject, eventdata, handles)
% hObject    handle to lb_definition_of_items (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lb_definition_of_items contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_definition_of_items

fill_item_edit_fields(handles)


%Felder zum Bearbeiten der Items werden mit dieser Funktion gef?llt
function fill_item_edit_fields(handles)
global TSP PP
if isempty(TSP.sections{PP.edit_section_line,4}{1,5})==0
    editline=get(handles.lb_definition_of_items, 'Value');
    set(handles.ed_item, 'String', editline);
    set(handles.ed_low_pole, 'String', TSP.sections{PP.edit_section_line,4}{1,5}{editline,1});
    set(handles.ed_high_pole, 'String', TSP.sections{PP.edit_section_line,4}{1,5}{editline,2});
    set(handles.ed_polarity, 'String', TSP.sections{PP.edit_section_line,4}{1,5}{editline,3});
end


% --- Executes during object creation, after setting all properties.
function lb_definition_of_items_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_definition_of_items (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pop_resolution_Callback(hObject, eventdata, handles)
% hObject    handle to pop_number_of_categories (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pop_number_of_categories as text
%        str2double(get(hObject,'String')) returns contents of pop_number_of_categories as a double


% --- Executes during object creation, after setting all properties.
function pop_resolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_number_of_categories (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_apply_items.
function pb_apply_items_Callback(hObject, eventdata, handles)
% hObject    handle to pb_apply_items (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global TSP PP
editline=get(handles.lb_definition_of_items, 'Value');
TSP.sections{PP.edit_section_line,4}{1,5}{editline,1}=get(handles.ed_low_pole, 'String');
TSP.sections{PP.edit_section_line,4}{1,5}{editline,2}=get(handles.ed_high_pole, 'String');
TSP.sections{PP.edit_section_line,4}{1,5}{editline,3}=get(handles.ed_polarity, 'String');
fill_list(handles)
fill_item_edit_fields(handles)
 %Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
 %User m?glicherweise R?ckg?ngig machen will
set(handles.pb_cancel,'Enable', 'on');


% --- Executes on button press in pb_switch_labels.
function pb_switch_labels_Callback(hObject, eventdata, handles)
% hObject    handle to pb_switch_labels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

old_low_pole=get(handles.ed_low_pole, 'String');
old_high_pole=get(handles.ed_high_pole, 'String');
set(handles.ed_high_pole, 'String', old_low_pole)
set(handles.ed_low_pole, 'String', old_high_pole)


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


% --- Executes on button press in pb_delete_item.
function pb_delete_item_Callback(hObject, eventdata, handles)
% hObject    handle to pb_delete_item (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP
if isempty(TSP.sections{PP.edit_section_line,4}{1,5})==0
   deleteline=get(handles.lb_definition_of_items,'Value');
   set(handles.lb_definition_of_items,'Value', 1);
   TSP.sections{PP.edit_section_line,4}{1,5}(deleteline,:)=[];
   fill_list(handles);
   fill_item_edit_fields(handles)
 %Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
 %User m?glicherweise R?ckg?ngig machen will
   set(handles.pb_cancel,'Enable', 'on');
end


% --- Executes on button press in pb_move_up.
function pb_move_up_Callback(hObject, eventdata, handles)
% hObject    handle to pb_move_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP
line_to_move_up=get(handles.lb_definition_of_items, 'Value');
if line_to_move_up > 1
    temp=TSP.sections{PP.edit_section_line,4}{1,5}(line_to_move_up-1,:);
    TSP.sections{PP.edit_section_line,4}{1,5}(line_to_move_up-1,:)=TSP.sections{PP.edit_section_line,4}{1,5}(line_to_move_up,:);
    TSP.sections{PP.edit_section_line,4}{1,5}(line_to_move_up,:)=temp;
    fill_list(handles)
    set(handles.lb_definition_of_items,'Value', line_to_move_up-1);
    fill_item_edit_fields(handles)
    %Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
    %User m?glicherweise R?ckg?ngig machen will
    set(handles.pb_cancel,'Enable', 'on');
end

% --- Executes on button press in pb_move_down.
function pb_move_down_Callback(hObject, eventdata, handles)
% hObject    handle to pb_move_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP
line_to_move_down=get(handles.lb_definition_of_items, 'Value');
if isempty(TSP.sections{PP.edit_section_line,4}{1,5})==0
    lastline=length(TSP.sections{PP.edit_section_line,4}{1,5}(:,1));
    if line_to_move_down < lastline
      temp=TSP.sections{PP.edit_section_line,4}{1,5}(line_to_move_down+1,:);
      TSP.sections{PP.edit_section_line,4}{1,5}(line_to_move_down+1,:)=TSP.sections{PP.edit_section_line,4}{1,5}(line_to_move_down,:);
      TSP.sections{PP.edit_section_line,4}{1,5}(line_to_move_down,:)=temp;
      fill_list(handles)
      set(handles.lb_definition_of_items,'Value', line_to_move_down+1);
      fill_item_edit_fields(handles)
     %Cancel-Button wird aktiviert, da ?nderungen vorgenommen wurden, die der
     %User m?glicherweise R?ckg?ngig machen will
      set(handles.pb_cancel,'Enable', 'on');
    end
end


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


% --- Executes on selection change in pop_number_of_categories.
function pop_number_of_categories_Callback(hObject, eventdata, handles)
% hObject    handle to pop_number_of_categories (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_number_of_categories contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_number_of_categories


% --- Executes during object creation, after setting all properties.
function pop_number_of_categories_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_number_of_categories (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_category_width_Callback(hObject, eventdata, handles)
% hObject    handle to ed_category_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_category_width as text
%        str2double(get(hObject,'String')) returns contents of ed_category_width as a double


% --- Executes during object creation, after setting all properties.
function ed_category_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_category_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_category_labels_Callback(hObject, eventdata, handles)
% hObject    handle to ed_category_labels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_category_labels as text
%        str2double(get(hObject,'String')) returns contents of ed_category_labels as a double


% --- Executes during object creation, after setting all properties.
function ed_category_labels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_category_labels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_minimum_value_Callback(hObject, eventdata, handles)
% hObject    handle to ed_minimum_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_minimum_value as text
%        str2double(get(hObject,'String')) returns contents of ed_minimum_value as a double


% --- Executes during object creation, after setting all properties.
function ed_minimum_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_minimum_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ed_numerical_representatives_Callback(hObject, eventdata, handles)
% hObject    handle to ed_numerical_representatives (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_numerical_representatives as text
%        str2double(get(hObject,'String')) returns contents of ed_numerical_representatives as a double


% --- Executes during object creation, after setting all properties.
function ed_numerical_representatives_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_numerical_representatives (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_save.
function pb_save_Callback(hObject, eventdata, handles)
% hObject    handle to pb_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP
label_string=get(handles.ed_category_labels, 'String');
%category-labels speichern
TSP.sections{PP.edit_section_line,4}{1,3}=strread(label_string,'%s');
%Datenstruktur auf die Fesplatte schreiben
save ([PP.path filesep 'TSP.mat'],'TSP');
close


% --- Executes on button press in pb_cancel.
function pb_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close


% --- Executes when user attempts to close fig_sd_edit_scale.
function fig_sd_edit_scale_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_sd_edit_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
if PP.dontopenparent~=1
    sd_edit_main
end
PP.dontopenparent=0;

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on key press with focus on ed_category_labels and no controls selected.
function ed_category_labels_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ed_category_labels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pb_cancel,'Enable', 'on');


% --- Executes during object creation, after setting all properties.
function fig_sd_edit_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fig_sd_edit_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

