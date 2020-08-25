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


function varargout = sd_vp(varargin)
% SD_VP M-file for sd_vp.fig
%      SD_VP, by itself, creates a new SD_VP or raises the existing
%      singleton*.
%
%      H = SD_VP returns the handle to a new SD_VP or the handle to
%      the existing singleton*.
%
%      SD_VP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SD_VP.M with the given input arguments.
%
%      SD_VP('Property','Value',...) creates a new SD_VP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sd_vp_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sd_vp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sd_vp

% Last Modified by GUIDE v2.5 23-Oct-2008 04:14:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sd_vp_OpeningFcn, ...
                   'gui_OutputFcn',  @sd_vp_OutputFcn, ...
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


% --- Executes just before sd_vp is made visible.
function sd_vp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sd_vp (see VARARGIN)

% Choose default command line output for sd_vp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sd_vp wait for user response (see UIRESUME)
% uiwait(handles.fig_sd_vp);

global TSP PP
movegui(hObject,'center') 
set(hObject,'Name',TSP.sections{PP.run_section_line,3});
PP.allowed_to_close=0;


% --- Outputs from this function are returned to the command line.
function varargout = sd_vp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global TSP PP TSD

set(handles.txt_short_instruction,'String',TSP.sections{PP.run_section_line,4}{1,9});
set(handles.txt_counter,'String',['Hörbeispiel ' num2str(PP.counter) ' / ' num2str(length(PP.playlist))]);
set(handles.txt_session,'String',['session: ' num2str(TSD{PP.run_number+1,3})]);
set(handles.txt_subject_id,'String',['subject: ' TSD{PP.run_number+1,2}]);

%n ist Anzahl der categories, x_position die x-Werte für deren Positionierung 
n=length(TSP.sections{PP.run_section_line,4}{1,2}(:,1));
abstand=330/n;
for i=1:n
    x_position(i)=abstand*i-abstand/2+130;
end

for j=1:length(TSP.sections{PP.run_section_line,4}{1,5}(:,1)) %items
  if j<16
      handles.pan(j)=uibuttongroup('Tag',['pan_' num2str(j)], 'Units', 'pixels','Position', [10 593-(j-1)*37 600 37]); %Beachte: Units VOR Postion übergeben!
  else
      handles.pan(j)=uibuttongroup('Tag',['pan_' num2str(j)], 'Units', 'pixels','Position', [625 593-(j-16)*37 600 37]);
  end
  for i=1:n %diese innere Schleife über i generiert für ein panel die radiobuttons und labels
    rad_tagstring=['rad_1_' num2str(i)]; %name der radiobuttons
    txt_tagstring=['txt_1_' num2str(i)]; %name der labels
    if size(TSP.sections{PP.run_section_line,4}{1,3},1)>=i %inhalt der labels, wenn vorhanden
        switch TSP.sections{PP.run_section_line,4}{1,5}{j,3}
            case '+'
                txt_label=TSP.sections{PP.run_section_line,4}{1,3}{i,1};
            case '-'
                txt_label=TSP.sections{PP.run_section_line,4}{1,3}{1+n-i,1};
        end
    else
        txt_label='';
    end
    if txt_label=='$'  % $ ist geschützes Zeichen für -keinLabel-
        txt_label='';
    end
    PP.handles.rad(j,i)=uicontrol(handles.pan(j),...
        'style','radiobutton',...
        'Tag',rad_tagstring,...
        'Position', [x_position(i) 17 15 15]);
    handles.txt(j,i)=uicontrol(handles.pan(j),...
        'style','text',...
        'Tag',txt_tagstring,...
        'Position', [x_position(i)-30 1 70 15],...
        'String', txt_label);
  set(PP.handles.rad(j,i),'Value',0);
  end
  %labels für den Low Pole und den High Pole
  switch TSP.sections{PP.run_section_line,4}{1,5}{j,3}
      case '+'
          low_label=TSP.sections{PP.run_section_line,4}{1,5}{j,1};
          high_label=TSP.sections{PP.run_section_line,4}{1,5}{j,2};
      case '-'
          low_label=TSP.sections{PP.run_section_line,4}{1,5}{j,2};
          high_label=TSP.sections{PP.run_section_line,4}{1,5}{j,1};
  end
  handles.txt_low_label(j)=uicontrol(handles.pan(j),...
        'style','text',...
        'Tag',['txt_' num2str(j) '_low'],...
        'Position', [3 2 127 30],...
        'HorizontalAlignment', 'right',...
        'String', low_label);
  handles.txt_high_label(j)=uicontrol(handles.pan(j),...
        'style','text',...
        'Tag',['txt_' num2str(j) '_high'],...
        'Position', [469 2 127 30],...
        'HorizontalAlignment', 'left',...
        'String', high_label);
end

%Abspielen
pause(TSP.sections{PP.run_section_line,4}{1,7})
object_nr=PP.playlist(PP.counter);
stimulus_id=TSP.sections{PP.run_section_line,4}{1,1}(object_nr,1);
present_stimulus(stimulus_id);
pause(str2num(TSP.stimuli{stimulus_id,4}))
set(handles.pb_weiter,'Enable', 'On');

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_weiter.
function pb_weiter_Callback(hObject, eventdata, handles)
% hObject    handle to pb_weiter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP TSP TSD

%DATEN SPEICHERN
object_nr=PP.playlist(PP.counter);
%n ist Anzahl der categories
n=length(TSP.sections{PP.run_section_line,4}{1,2}(:,1));
forgot_some_value=0;
for j=1:length(TSP.sections{PP.run_section_line,4}{1,5}(:,1)) %items
    rating_sc=0;
    for i=1:n
        rating_sc=rating_sc+get(PP.handles.rad(j,i),'Value')*i;
    end
    %Spalten-Überschriften für Export generieren
    TSD{1,3+PP.run_section_line}{1,object_nr+30}{1,j}=['rat_sc' num2str(j) '_ob' num2str(object_nr)];
    %ratings speichern
    if rating_sc~=0 %wenn überhaupt eine Auswahl getroffen wurde, schreibe
        switch TSP.sections{PP.run_section_line,4}{1,5}{j,3}
            case '+'
                TSD{PP.run_number+1,3+PP.run_section_line}{1,object_nr+30}{1,j}=TSP.sections{PP.run_section_line,4}{1,2}(rating_sc,1);
            case '-'
                TSD{PP.run_number+1,3+PP.run_section_line}{1,object_nr+30}{1,j}=TSP.sections{PP.run_section_line,4}{1,2}(1+n-rating_sc,1);
        end
    else
        TSD{PP.run_number+1,3+PP.run_section_line}{1,object_nr+30}{1,j}='';
        forgot_some_value=1;
    end
end

if forgot_some_value==0
    PP.handles={};
    save ([PP.path filesep 'TSD'],'TSD');
    PP.allowed_to_close=1;
    close
    PP.allowed_to_close=0;
    %logfile-zeugs

    PP.counter=PP.counter+1;
    if PP.counter>length(PP.playlist)
        save_export_file(PP.run_section_line)
        PP.run_section_line=PP.run_section_line+1;
        vp_main
    else
        sd_vp
    end
end


% --- Executes when user attempts to close fig_sd_vp.
function fig_sd_vp_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_sd_vp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PP
if PP.allowed_to_close==1
    delete(hObject);
end

