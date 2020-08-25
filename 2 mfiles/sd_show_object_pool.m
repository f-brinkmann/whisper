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
% Author :   Andr� Wlodarski, student at FG Audiokommunikation, TU Berlin
% Email  :   awlodarski AT gmx DOT de
% Date   :   15-Nov-2008
%
% =========================================================================


function varargout = sd_show_object_pool(varargin)
% SD_SHOW_OBJECT_POOL M-file for sd_show_object_pool.fig
%      SD_SHOW_OBJECT_POOL, by itself, creates a new SD_SHOW_OBJECT_POOL or raises the existing
%      singleton*.
%
%      H = SD_SHOW_OBJECT_POOL returns the handle to a new SD_SHOW_OBJECT_POOL or the handle to
%      the existing singleton*.
%
%      SD_SHOW_OBJECT_POOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SD_SHOW_OBJECT_POOL.M with the given input arguments.
%
%      SD_SHOW_OBJECT_POOL('Property','Value',...) creates a new SD_SHOW_OBJECT_POOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sd_show_object_pool_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sd_show_object_pool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sd_show_object_pool

% Last Modified by GUIDE v2.5 13-Oct-2008 13:55:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sd_show_object_pool_OpeningFcn, ...
                   'gui_OutputFcn',  @sd_show_object_pool_OutputFcn, ...
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


% --- Executes just before sd_show_object_pool is made visible.
function sd_show_object_pool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sd_show_object_pool (see VARARGIN)

% Choose default command line output for sd_show_object_pool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sd_show_object_pool wait for user response (see UIRESUME)
% uiwait(handles.fig_show_object_pool);

movegui(hObject,'center')
global TSP PP
set(hObject,'Name',['SD - view object pool (' TSP.sections{PP.edit_section_line,2} ')'])
fill_list_elements(handles)%funktionsaufruf: element pool f�llen


function fill_list_elements(handles)
% Inhalt der Liste wird generiert.
% Mit Hilfe der Funktion str_to_len.m werden die Inhalte in die richtige
% L�nge gebracht f�r die tabellarisch korrekte Darstellung, jeder
% Schleifendurchlauf generiert dabei eine Zeile der Liste.
global TSP PP

if isempty(TSP.sections{PP.edit_section_line,4}{1,1})==0
 for i=1:length(TSP.sections{PP.edit_section_line,4}{1,1}(:,1))
    %in elementliste vorhandene stimuli sind dort nur mit ihrem Index
    %abgelegt. Die Daten werden aus dem globalen Pool geholt. Hier wird die
    %Stelle gesucht, an der sie im globalen Pool zu finden sind:
    line_in_global=0;
    for j=1:length(TSP.stimuli(:,1))
        if TSP.stimuli{j,1}==TSP.sections{PP.edit_section_line,4}{1,1}(i,1)
            line_in_global=j;
        end
    end
    %hier werden die gefundenen Stimuli mit den Daten in die Liste
    %�bernommen
    if line_in_global==0
        stimuli_list{i,1}=[str_to_len(num2str(i), 5) ...
                      'S' str_to_len('000', 5) ...%Spalte: ID 
                      str_to_len('! --- not available', 25)];      %Spalte: name
    else
        stimuli_list{i,1}=[str_to_len(num2str(i), 5) ...
                      'S' str_to_len(num2str(TSP.stimuli{line_in_global,1}), 5) ...%Spalte: ID 
                      str_to_len(TSP.stimuli{line_in_global,2}, 25)];      %Spalte: name
    end
 end
 set(handles.lb_element_pool,'String', stimuli_list);
else
 set(handles.lb_element_pool,'String', '');
end


% --- Outputs from this function are returned to the command line.
function varargout = sd_show_object_pool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in lb_element_pool.
function lb_element_pool_Callback(hObject, eventdata, handles)
% hObject    handle to lb_element_pool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lb_element_pool contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_element_pool


% --- Executes during object creation, after setting all properties.
function lb_element_pool_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_element_pool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

