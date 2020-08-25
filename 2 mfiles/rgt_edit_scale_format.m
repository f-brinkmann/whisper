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


function varargout = rgt_edit_scale_format(varargin)
% RGT_EDIT_SCALE_FORMAT M-file for rgt_edit_scale_format.fig
%      RGT_EDIT_SCALE_FORMAT, by itself, creates a new RGT_EDIT_SCALE_FORMAT or raises the existing
%      singleton*.
%
%      H = RGT_EDIT_SCALE_FORMAT returns the handle to a new RGT_EDIT_SCALE_FORMAT or the handle to
%      the existing singleton*.
%
%      RGT_EDIT_SCALE_FORMAT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RGT_EDIT_SCALE_FORMAT.M with the given input arguments.
%
%      RGT_EDIT_SCALE_FORMAT('Property','Value',...) creates a new RGT_EDIT_SCALE_FORMAT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rgt_edit_scale_format_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rgt_edit_scale_format_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rgt_edit_scale_format

% Last Modified by GUIDE v2.5 10-Oct-2008 03:25:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rgt_edit_scale_format_OpeningFcn, ...
                   'gui_OutputFcn',  @rgt_edit_scale_format_OutputFcn, ...
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


% --- Executes just before rgt_edit_scale_format is made visible.
function rgt_edit_scale_format_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rgt_edit_scale_format (see VARARGIN)

% Choose default command line output for rgt_edit_scale_format
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rgt_edit_scale_format wait for user response (see UIRESUME)
% uiwait(handles.fig_rgt_edit_scale_format);

movegui(hObject,'center')
global TSP PP
set(hObject,'Name',['RGT - edit scale format (' TSP.sections{PP.edit_section_line,2} ')']);
set(handles.pop_number_of_categories, 'Value', length(TSP.sections{PP.edit_section_line,4}{1,2}(:,1))-1); % -1 für Value weil das Popup beim Inhalt 2 beginnt
set(handles.ed_minimum_value, 'String', TSP.sections{PP.edit_section_line,4}{1,2}(1,1));
set(handles.ed_category_width, 'String', TSP.sections{PP.edit_section_line,4}{1,2}(2,1)-TSP.sections{PP.edit_section_line,4}{1,2}(1,1));
set(handles.ed_numerical_representatives, 'String', num2str(TSP.sections{PP.edit_section_line,4}{1,2}(:,1)'));
set(handles.ed_category_labels, 'String', sprintf('%s ', TSP.sections{PP.edit_section_line,4}{1,3}{:,1}));


% --- Outputs from this function are returned to the command line.
function varargout = rgt_edit_scale_format_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in pop_resolution.
function pop_resolution_Callback(hObject, eventdata, handles)
% hObject    handle to pop_resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pop_resolution contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_resolution


% --- Executes during object creation, after setting all properties.
function pop_resolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
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


% --- Executes on button press in pb_apply.
function pb_apply_Callback(hObject, eventdata, handles)
% hObject    handle to pb_apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP
n=    get(handles.pop_number_of_categories,'Value')+1; %+1 weil popup mit 2 anfängt
min=  str2num(get(handles.ed_minimum_value,'String'));
width=str2num(get(handles.ed_category_width,'String'));
TSP.sections{PP.edit_section_line,4}{1,2}=(min:width:min+(n-1)*width)';
set(handles.ed_numerical_representatives, 'String', num2str(TSP.sections{PP.edit_section_line,4}{1,2}(:,1)'));
set(handles.pb_cancel,'Enable', 'on');


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


% --- Executes on button press in pb_cancel.
function pb_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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


% --- Executes when user attempts to close fig_rgt_edit_scale_format.
function fig_rgt_edit_scale_format_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_rgt_edit_scale_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
if PP.dontopenparent~=1
    rgt_edit_main
end
PP.dontopenparent=0;

% Hint: delete(hObject) closes the figure
delete(hObject);

