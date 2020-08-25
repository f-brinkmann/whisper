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


function varargout = ap_show_tracks(varargin)
% AP_SHOW_TRACKS M-file for ap_show_tracks.fig
%      AP_SHOW_TRACKS, by itself, creates a new AP_SHOW_TRACKS or raises the existing
%      singleton*.
%
%      H = AP_SHOW_TRACKS returns the handle to a new AP_SHOW_TRACKS or the handle to
%      the existing singleton*.
%
%      AP_SHOW_TRACKS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AP_SHOW_TRACKS.M with the given input arguments.
%
%      AP_SHOW_TRACKS('Property','Value',...) creates a new AP_SHOW_TRACKS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ap_show_tracks_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ap_show_tracks_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ap_show_tracks

% Last Modified by GUIDE v2.5 13-Oct-2008 23:41:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ap_show_tracks_OpeningFcn, ...
                   'gui_OutputFcn',  @ap_show_tracks_OutputFcn, ...
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


% --- Executes just before ap_show_tracks is made visible.
function ap_show_tracks_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ap_show_tracks (see VARARGIN)

% Choose default command line output for ap_show_tracks
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ap_show_tracks wait for user response (see UIRESUME)
% uiwait(handles.fig_ap_show_tracks);

movegui(hObject,'center')
global TSP PP
set(hObject,'Name',['AP - view tracks (' TSP.sections{PP.edit_section_line,2} ')'])
fill_list(handles) %funktionsaufruf: element pool füllen


function fill_list(handles)
% Inhalt der Track-Liste wird generiert.
% Mit Hilfe der Funktion str_to_len.m werden die Inhalte in die richtige
% Länge gebracht für die tabellarisch korrekte Darstellung, jeder
% generiert dabei eine Zeile der Liste.
global TSP PP

for i=1:length(TSP.sections{PP.edit_section_line,4}(:,6))
   tracks{i,1}=['Track ' num2str(i) ': ' ...%Spalte: ID 
                      str_to_len(TSP.sections{PP.edit_section_line,4}{i,6}, 25)];      %Spalte: name
end
set(handles.lb_tracks,'String', tracks);


% --- Outputs from this function are returned to the command line.
function varargout = ap_show_tracks_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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

