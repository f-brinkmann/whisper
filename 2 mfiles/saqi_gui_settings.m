function varargout = saqi_gui_settings(varargin)
% SAQI_GUI_SETTINGS MATLAB code for saqi_gui_settings.fig
%      SAQI_GUI_SETTINGS, by itself, creates a new SAQI_GUI_SETTINGS or raises the existing
%      singleton*.
%
%      H = SAQI_GUI_SETTINGS returns the handle to a new SAQI_GUI_SETTINGS or the handle to
%      the existing singleton*.
%
%      SAQI_GUI_SETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAQI_GUI_SETTINGS.M with the given input arguments.
%
%      SAQI_GUI_SETTINGS('Property','Value',...) creates a new SAQI_GUI_SETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before saqi_gui_settings_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to saqi_gui_settings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help saqi_gui_settings

% Last Modified by GUIDE v2.5 31-Mar-2015 12:52:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @saqi_gui_settings_OpeningFcn, ...
                   'gui_OutputFcn',  @saqi_gui_settings_OutputFcn, ...
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


% --- Executes just before saqi_gui_settings is made visible.
function saqi_gui_settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to saqi_gui_settings (see VARARGIN)

% Choose default command line output for saqi_gui_settings
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Center GUI
movegui(hObject,'center');

global TSP PP

% load parameter
set(handles.ed_1, 'string', TSP.sections{PP.edit_section_line,4}{1,3}{19})              % max. no. of conditions in rating GUI
set(handles.ed_2, 'string', TSP.sections{PP.edit_section_line,4}{1,3}{20})              % min. no. of conditions in last rating GUI
set(handles.ed_3, 'string', TSP.sections{PP.edit_section_line,4}{1,3}{21})              % min. no. of groups in last rating GUI
set(handles.ed_4, 'string', num2str(TSP.sections{PP.edit_section_line,4}{1,3}{22}(1)))  % label scale for bipolar slider
set(handles.ed_5, 'string', num2str(TSP.sections{PP.edit_section_line,4}{1,3}{22}(2)))  % label offset for bipolar slider
set(handles.ed_6, 'string', num2str(TSP.sections{PP.edit_section_line,4}{1,3}{23}(1)))  % label scale for bipolar slider
set(handles.ed_7, 'string', num2str(TSP.sections{PP.edit_section_line,4}{1,3}{23}(2)))  % label offset for bipolar slider

set_label_positions(handles)



% --- Outputs from this function are returned to the command line.
function varargout = saqi_gui_settings_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function ed_1_Callback(hObject, eventdata, handles)
% hObject    handle to ed_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_1 as text
%        str2double(get(hObject,'String')) returns contents of ed_1 as a double


% --- Executes during object creation, after setting all properties.
function ed_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_2_Callback(hObject, eventdata, handles)
% hObject    handle to ed_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_2 as a double


% --- Executes during object creation, after setting all properties.
function ed_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_3_Callback(hObject, eventdata, handles)
% hObject    handle to ed_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_3 as text
%        str2double(get(hObject,'String')) returns contents of ed_3 as a double


% --- Executes during object creation, after setting all properties.
function ed_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_3 (see GCBO)
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
global TSP PP

% save parameter
TSP.sections{PP.edit_section_line,4}{1,3}{19} = get(handles.ed_1, 'string');
TSP.sections{PP.edit_section_line,4}{1,3}{20} = get(handles.ed_2, 'string');
TSP.sections{PP.edit_section_line,4}{1,3}{21} = get(handles.ed_3, 'string');
TSP.sections{PP.edit_section_line,4}{1,3}{22} = [str2double(get(handles.ed_4, 'string')) str2double(get(handles.ed_5, 'string'))];
TSP.sections{PP.edit_section_line,4}{1,3}{23} = [str2double(get(handles.ed_6, 'string')) str2double(get(handles.ed_7, 'string'))];

close


% --- Executes during object creation, after setting all properties.
function fig_saqi_gui_settings_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fig_saqi_gui_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function sli_bi1_Callback(hObject, eventdata, handles)
% hObject    handle to sli_bi1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sli_bi1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sli_bi1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sli_uni1_Callback(hObject, eventdata, handles)
% hObject    handle to sli_uni1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sli_uni1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sli_uni1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function ed_4_Callback(hObject, eventdata, handles)
% hObject    handle to ed_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_4 as text
%        str2double(get(hObject,'String')) returns contents of ed_4 as a double
set_label_positions(handles)



% --- Executes during object creation, after setting all properties.
function ed_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_5_Callback(hObject, eventdata, handles)
% hObject    handle to ed_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_5 as text
%        str2double(get(hObject,'String')) returns contents of ed_5 as a double
set_label_positions(handles)

% --- Executes during object creation, after setting all properties.
function ed_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_6_Callback(hObject, eventdata, handles)
% hObject    handle to ed_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_6 as text
%        str2double(get(hObject,'String')) returns contents of ed_6 as a double
set_label_positions(handles)

% --- Executes during object creation, after setting all properties.
function ed_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_7_Callback(hObject, eventdata, handles)
% hObject    handle to ed_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_7 as text
%        str2double(get(hObject,'String')) returns contents of ed_7 as a double
set_label_positions(handles)

% --- Executes during object creation, after setting all properties.
function ed_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function set_label_positions(handles)

% --- reference points and distances for arragement of GUI items ---
% slider width and height, and x positions
tmp         = get(handles.sli_bi1, 'position');
geo.sli_bi  = tmp(3:4);
geo.x(1)    = tmp(1);
tmp         = get(handles.sli_uni1, 'position');
geo.sli_uni = tmp(3:4);
geo.x(2)    = tmp(1);
% get scale and offset
geo.sli_range_bi  = geo.sli_bi(2) * str2double(get(handles.ed_4, 'string'));
geo.sli_range_uni = geo.sli_uni(2)* str2double(get(handles.ed_6, 'string'));
geo.sli_range_off = [str2double(get(handles.ed_5, 'string')) str2double(get(handles.ed_7, 'string'))];
% x offset from ideal x positions to make slider and label look centered
geo.offset_sli = 0;
tmp = get(handles.txt_bi1, 'position');
geo.lab = tmp(3:4);
% center of GUI, most things will be arranged relatively
geo.zero = [NaN 160];
% y positions of labels
scale_size = 3;
geo.lab_y_bi  = geo.zero(2) + linspace(0, geo.sli_range_bi, scale_size)              - geo.sli_range_bi/2  - geo.lab(2)/2;
geo.lab_y_uni = geo.zero(2) + linspace(0, geo.sli_range_uni, ceil((scale_size+1)/2)) - geo.sli_range_uni/2 - geo.lab(2)/2;

% bipolar scale
set(handles.sli_bi1, 'position', [geo.x(1)-geo.offset_sli geo.zero(2)-geo.sli_bi(2)/2 geo.sli_bi])
for m = 1:scale_size
    set(eval(['handles.txt_bi' num2str(m)]), 'position', [geo.x(1)+geo.sli_bi(1)-geo.offset_sli, geo.lab_y_bi(m)+geo.sli_range_off(1), geo.lab])
end

% unipolar scale
set(handles.sli_uni1, 'position', [geo.x(2)-geo.offset_sli, geo.zero(2)-geo.sli_uni(2)/2, geo.sli_uni])
for m = 1:ceil((scale_size+1)/2)
    set(eval(['handles.txt_uni' num2str(m)]), 'position', [geo.x(2)+geo.sli_uni(1)-geo.offset_sli, geo.lab_y_uni(m)+geo.sli_range_off(2), geo.lab])
end
