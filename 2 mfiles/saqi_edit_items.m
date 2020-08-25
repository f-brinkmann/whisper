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

function varargout = saqi_edit_items(varargin)
% SAQI_EDIT_ITEMS MATLAB code for saqi_edit_items.fig
%      SAQI_EDIT_ITEMS, by itself, creates a new SAQI_EDIT_ITEMS or raises the existing
%      singleton*.
%
%      H = SAQI_EDIT_ITEMS returns the handle to a new SAQI_EDIT_ITEMS or the handle to
%      the existing singleton*.
%
%      SAQI_EDIT_ITEMS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAQI_EDIT_ITEMS.M with the given input arguments.
%
%      SAQI_EDIT_ITEMS('Property','Value',...) creates a new SAQI_EDIT_ITEMS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before saqi_edit_items_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to saqi_edit_items_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help saqi_edit_items

% Last Modified by GUIDE v2.5 24-Feb-2016 22:41:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @saqi_edit_items_OpeningFcn, ...
                   'gui_OutputFcn',  @saqi_edit_items_OutputFcn, ...
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


% --- Executes just before saqi_edit_items is made visible.
function saqi_edit_items_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to saqi_edit_items (see VARARGIN)

% Choose default command line output for saqi_edit_items
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes saqi_edit_items wait for user response (see UIRESUME)
% uiwait(handles.fig_saqi_edit_items);
global TSP PP
movegui(hObject,'center');
set(hObject,'Name',['Edit items (' TSP.sections{PP.edit_section_line,2} ')']);

% write item and category names to listbox
fill_items(handles)
fill_categories(handles)

% set display of item listbox
set(handles.lb_edit_items, 'ListBoxTop', 1);


% fill listbox with all items from the TSP
function fill_items(handles)
global TSP PP select_status
for n = 1:size(TSP.sections{PP.edit_section_line,4}{1,6}, 1)
    tmp_items{n} = [num2str(TSP.sections{PP.edit_section_line,4}{1,6}{n,1}) ' '...
                    TSP.sections{PP.edit_section_line,4}{1,6}{n,2}];
end
set(handles.lb_edit_items, 'String', tmp_items)

%select items according to TSP
set(handles.lb_edit_items, 'Value', cell2mat(TSP.sections{PP.edit_section_line,4}{1,4}))

select_status = 1;

    
 
% fill checkboxes with categories from the tsp line 
function fill_categories(handles)
global TSP PP select_categories
for n = 1:size(TSP.sections{PP.edit_section_line,4}{1,12}, 1)
    tmp_categories{n} = [num2str(TSP.sections{PP.edit_section_line,4}{1,12}{n,1}) ' '...
                         TSP.sections{PP.edit_section_line,4}{1,12}{n,2}];
end
set(handles.lb_categories, 'String', tmp_categories)

%select categories according to TSP
set(handles.lb_categories, 'Value', cell2mat(TSP.sections{PP.edit_section_line,4}{1,13}))
%set(handles.lb_categories,'Value',1);

select_categories = 1;



% --- Outputs from this function are returned to the command line.
function varargout = saqi_edit_items_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in lb_edit_items.
function lb_edit_items_Callback(hObject, eventdata, handles)
% hObject    handle to lb_edit_items (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lb_edit_items contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_edit_items


% --- Executes during object creation, after setting all properties.
function lb_edit_items_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_edit_items (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_save.
function pb_save_Callback(hObject, eventdata, handles)
%         hObject    handle to pb_save (see GCBO)
%         eventdata  reserved - to be defined in a future version of MATLAB
%         handles    structure with handles and user data (see GUIDATA)
global TSP PP

tmp_selected_items = get(handles.lb_edit_items, 'Value');
tmp_selected_categories = get(handles.lb_categories, 'Value');


if isempty(tmp_selected_items)
    % if no item was selected show warning
    PP.whisper_message = 'The first and last item must be selected!';
    whisper_message;
elseif tmp_selected_items(1) ~= 1  || tmp_selected_items(end) ~= size(TSP.sections{PP.edit_section_line,4}{1,6},1)
    % if first and/or last item were not selected show warning
    PP.whisper_message = 'The first and last item must be selected!';
    whisper_message;
else
    %saves chosen items in TSP
    for n = 1:numel(tmp_selected_items)
        cell_selected_items{n} = tmp_selected_items(n);
    end
    TSP.sections{PP.edit_section_line,4}{1,4} = cell_selected_items;
    
    % saves chosen categories in TSP
    if ~isempty(tmp_selected_categories)
        for n = 1:numel(tmp_selected_categories)
            cell_selected_categories{n} = tmp_selected_categories(n);
        end
        TSP.sections{PP.edit_section_line,4}{1,13} = cell_selected_categories;
    else
        TSP.sections{PP.edit_section_line,4}{1,13} = cell(0);
    end
    
    save ([PP.path filesep 'TSP.mat'],'TSP');
    close
end
       


% --- Executes on button press in pb_cancel.
function pb_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close


% --- Executes on button press in pb_select.
function pb_select_Callback(hObject, eventdata, handles)
% hObject    handle to pb_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TSP PP select_status select_categories 

% de/select all items
if select_status
    set(handles.lb_edit_items, 'Value', [])
    select_status = 0;
else
    set(handles.lb_edit_items, 'Value', 1:size(TSP.sections{PP.edit_section_line,4}{1,6}, 1))
    select_status = 1;
end

% de/select all categories 
if select_categories 
    set (handles.lb_categories, 'Value', [])
    select_categories = 0;
else
    set(handles.lb_categories, 'Value', 1:size(TSP.sections{PP.edit_section_line,4} {1,12},1))
    select_categories = 1;
end


% --- Executes on selection change in lb_categories.
function lb_categories_Callback(hObject, eventdata, handles)
% hObject    handle to lb_categories (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lb_categories contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_categories
global TSP PP 

%select all items of all selected categories in lb_items
tmp_selected_categories = get(hObject,'Value');
tmp_selected_items      = get(handles.lb_edit_items, 'Value');
for n = 1:size(TSP.sections{PP.edit_section_line,4} {1,12},1)
    if find(tmp_selected_categories == n)
        for m = 1:size(TSP.sections{PP.edit_section_line,4} {1,6},1)
            if TSP.sections{PP.edit_section_line,4} {1,6}{m,5} == n
                tmp_selected_items = [tmp_selected_items m];
            end
        end
    else
        for m = 1:size(TSP.sections{PP.edit_section_line,4} {1,6},1)
            if TSP.sections{PP.edit_section_line,4} {1,6}{m,5} == n
                id = find(tmp_selected_items == m);
                if ~isempty(id)
                    if id == numel(tmp_selected_items)
                        tmp_selected_items = tmp_selected_items(1:id-1);
                    else
                        tmp_selected_items = tmp_selected_items([1:id-1 id+1:end]);
                    end
                end
            end
        end  
    end
end

tmp_selected_items = sort(tmp_selected_items, 'ascend');
tmp_selected_items = unique(tmp_selected_items);

set(handles.lb_edit_items, 'Value', tmp_selected_items, 'ListBoxTop', 1);

% --- Executes during object creation, after setting all properties.
function lb_categories_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_categories (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
