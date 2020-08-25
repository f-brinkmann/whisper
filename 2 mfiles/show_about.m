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


function varargout = show_about(varargin)
% SHOW_ABOUT M-file for show_about.fig
%      SHOW_ABOUT, by itself, creates a new SHOW_ABOUT or raises the existing
%      singleton*.
%
%      H = SHOW_ABOUT returns the handle to a new SHOW_ABOUT or the handle to
%      the existing singleton*.
%
%      SHOW_ABOUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOW_ABOUT.M with the given input arguments.
%
%      SHOW_ABOUT('Property','Value',...) creates a new SHOW_ABOUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before show_about_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to show_about_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help show_about

% Last Modified by GUIDE v2.5 09-Nov-2008 00:11:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @show_about_OpeningFcn, ...
                   'gui_OutputFcn',  @show_about_OutputFcn, ...
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


% --- Executes just before show_about is made visible.
function show_about_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to show_about (see VARARGIN)

% Choose default command line output for show_about
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes show_about wait for user response (see UIRESUME)
% uiwait(handles.fig_about);
movegui(hObject,'center')


% --- Outputs from this function are returned to the command line.
function varargout = show_about_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

