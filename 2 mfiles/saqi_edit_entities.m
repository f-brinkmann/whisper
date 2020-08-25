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
% Author :   Martina Vrhovnik and Fabian Brinkmann,
%            Audio Communication Group, TU Berlin
% Email  :   fabian.brinkmann at tu-berlin dot de
% Date   :   Oct. 2013
% Updated: 
%             
% =========================================================================

function varargout = saqi_edit_entities(varargin)
% SAQI_EDIT_ENTITIES MATLAB code for saqi_edit_entities.fig
%      SAQI_EDIT_ENTITIES, by itself, creates a new SAQI_EDIT_ENTITIES or raises the existing
%      singleton*.
%
%      H = SAQI_EDIT_ENTITIES returns the handle to a new SAQI_EDIT_ENTITIES or the handle to
%      the existing singleton*.
%
%      SAQI_EDIT_ENTITIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAQI_EDIT_ENTITIES.M with the given input arguments.
%
%      SAQI_EDIT_ENTITIES('Property','Value',...) creates a new SAQI_EDIT_ENTITIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before saqi_edit_entities_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to saqi_edit_entities_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help saqi_edit_entities

% Last Modified by GUIDE v2.5 27-Sep-2013 14:49:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @saqi_edit_entities_OpeningFcn, ...
                   'gui_OutputFcn',  @saqi_edit_entities_OutputFcn, ...
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


% --- Executes just before saqi_edit_entities is made visible.
function saqi_edit_entities_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to saqi_edit_entities (see VARARGIN)

% Choose default command line output for saqi_edit_entities
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes saqi_edit_entities wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global TSP PP
movegui(hObject,'center');
set(hObject,'Name',['Edit assessment entities (' TSP.sections{PP.edit_section_line,2} ')']);

% set strings to display entities as saved in TSP
for n = 1:7
    set(eval(['handles.txt_entity_' num2str(n)]), 'String', TSP.sections{PP.edit_section_line,4}{1,11}{n,2})
end

% set checkboxes and enable selected entities as saved in TSP
for n = 1:numel(TSP.sections{PP.edit_section_line,4}{1,10})
    set(eval(['handles.cb_entity_' num2str(TSP.sections{PP.edit_section_line,4}{1,10}{n})]), 'Value', 1)
    set(eval(['handles.txt_entity_' num2str(TSP.sections{PP.edit_section_line,4}{1,10}{n})]), 'enable', 'on')
end

% --- Outputs from this function are returned to the command line.
function varargout = saqi_edit_entities_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in cb_entity_1.
function cb_entity_1_Callback(hObject, eventdata, handles)
% hObject    handle to cb_entity_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_entity_1

% enable/disable entiti string depending on checkbox value
if get(hObject,'Value')
    set(handles.txt_entity_1, 'Enable', 'On')
else
    set(handles.txt_entity_1, 'Enable', 'Off')
end

% --- Executes on button press in cb_entity_2.
function cb_entity_2_Callback(hObject, eventdata, handles)
% hObject    handle to cb_entity_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_entity_2

% enable/disable entiti string depending on checkbox value
if get(hObject,'Value')
    set(handles.txt_entity_2, 'Enable', 'On')
else
    set(handles.txt_entity_2, 'Enable', 'Off')
end

% --- Executes on button press in cb_entity_3.
function cb_entity_3_Callback(hObject, eventdata, handles)
% hObject    handle to cb_entity_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_entity_3

% enable/disable entiti string depending on checkbox value
if get(hObject,'Value')
    set(handles.txt_entity_3, 'Enable', 'On')
else
    set(handles.txt_entity_3, 'Enable', 'Off')
end

% --- Executes on button press in cb_entity_4.
function cb_entity_4_Callback(hObject, eventdata, handles)
% hObject    handle to cb_entity_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_entity_4

% enable/disable entiti string depending on checkbox value
if get(hObject,'Value')
    set(handles.txt_entity_4, 'Enable', 'On')
else
    set(handles.txt_entity_4, 'Enable', 'Off')
end

% --- Executes on button press in cb_entity_5.
function cb_entity_5_Callback(hObject, eventdata, handles)
% hObject    handle to cb_entity_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_entity_5

% enable/disable entiti string depending on checkbox value
if get(hObject,'Value')
    set(handles.txt_entity_5, 'Enable', 'On')
else
    set(handles.txt_entity_5, 'Enable', 'Off')
end

% --- Executes on button press in cb_entity_6.
function cb_entity_6_Callback(hObject, eventdata, handles)
% hObject    handle to cb_entity_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_entity_6

% enable/disable entiti string depending on checkbox value
if get(hObject,'Value')
    set(handles.txt_entity_6, 'Enable', 'On')
else
    set(handles.txt_entity_6, 'Enable', 'Off')
end

% --- Executes on button press in cb_entity_7.
function cb_entity_7_Callback(hObject, eventdata, handles)
% hObject    handle to cb_entity_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_entity_7

% enable/disable entiti string depending on checkbox value
if get(hObject,'Value')
    set(handles.txt_entity_7, 'Enable', 'On')
else
    set(handles.txt_entity_7, 'Enable', 'Off')
end


function txt_entity_1_Callback(hObject, eventdata, handles)
% hObject    handle to txt_entity_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_entity_1 as text
%        str2double(get(hObject,'String')) returns contents of txt_entity_1 as a double


% --- Executes during object creation, after setting all properties.
function txt_entity_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_entity_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_entity_2_Callback(hObject, eventdata, handles)
% hObject    handle to txt_entity_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_entity_2 as text
%        str2double(get(hObject,'String')) returns contents of txt_entity_2 as a double


% --- Executes during object creation, after setting all properties.
function txt_entity_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_entity_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_entity_3_Callback(hObject, eventdata, handles)
% hObject    handle to txt_entity_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_entity_3 as text
%        str2double(get(hObject,'String')) returns contents of txt_entity_3 as a double


% --- Executes during object creation, after setting all properties.
function txt_entity_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_entity_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_entity_4_Callback(hObject, eventdata, handles)
% hObject    handle to txt_entity_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_entity_4 as text
%        str2double(get(hObject,'String')) returns contents of txt_entity_4 as a double


% --- Executes during object creation, after setting all properties.
function txt_entity_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_entity_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_entity_5_Callback(hObject, eventdata, handles)
% hObject    handle to txt_entity_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_entity_5 as text
%        str2double(get(hObject,'String')) returns contents of txt_entity_5 as a double


% --- Executes during object creation, after setting all properties.
function txt_entity_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_entity_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function txt_entity_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_entity_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function txt_entity_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_entity_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pb_save.
function pb_save_Callback(hObject, eventdata, handles)
% hObject    handle to pb_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP

% check which entities were selected
selected_entities = {};
for n = 1:7
    TSP.sections{PP.edit_section_line,4}{1,11}{n,2} = get(eval(['handles.txt_entity_' num2str(n)]), 'String');
    if get(eval(['handles.cb_entity_' num2str(n)]), 'Value')
        selected_entities{end+1} = n;
    end
end

tmp_entities = cell2mat(selected_entities);

% check if any entities were selected
if isempty(tmp_entities)
    PP.whisper_message = 'Select at least 1 entity';
    whisper_message;
else
    % check if entities were selected in a row and print error message if they
    % were not
    dif_entities = diff(tmp_entities);
    dif_id = find(dif_entities > 1, 1, 'first');
    
    if ~isempty(dif_id)
        if (tmp_entities(dif_id)==5 || tmp_entities(dif_id)+dif_entities(dif_id)>5)
            correct_selection(selected_entities)
        else
            wrong_selection
        end
    else
        if tmp_entities(1)>5 || tmp_entities(1)==1
            correct_selection(selected_entities)
        else
            wrong_selection
        end
    end
end

% --- Executes on button press in pb_cancel.
function pb_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close

function wrong_selection
global PP
PP.whisper_message = {'Entities have to be selcted in a row' '' '(E.g. you can not select entity 2 and 4'  'without selecting entity 1 and 3)'};
whisper_message;

function correct_selection(selected_entities)
global TSP PP
% save selected entites to TSP and close window
TSP.sections{PP.edit_section_line,4}{1,10} = selected_entities;
close

