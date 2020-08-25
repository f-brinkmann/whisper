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
% This file :   Exports Rating-Data to Idiogrid-File (*.grd)
%
% Author    :   Johannes Blickensdorff, alumni at FG Audiokommunikation, TU Berlin
% Email     :   hannes AT blickensdorff DOT com
% Date      :   17-Dec-2010
% Version   :   1.0
% Updated   :   
% Tested on :   OSX 10.6.5 w/ Matlab R2009b (7.9.0, OSX)
%               WinXP(32) w/ Matlab R2010b  (7.11.0.58, Win)
%
% to do:   
% - whisper version auslesen
% 
% =========================================================================

function [] = save_export_whisper2idiogrid(grdfilename, grdData, grdLabel, grdKonstrukte, grdElemente, grdType, grdBemerkung)

%Erklärung der zu übergebenen Parameter:
%grdfilename  : kompletter Dateiname des zu erstellenden *.grd-Files (ohne Endung)
%grdData      : Rating-Matrix, [Konstrukte (Zeilen) x Elemente (Spalten)]
%grdLabel     : Name des Grids 
%grdKonstrukte: Bezeichner der Konstrukt-Pole; [Anzahl x 2] (1: low/neg, 2: high/pos)
%grdElemente  : Bezeichner der Elemente [Anzahl x 1]
%grdType      : %0=Rating/1=Ranking/2=Binary/3=Coordinate/4=Transformed(Standard ist 0, kann auch in Idiogrid geändert werden...)
%grdBemerkung : Anmerkungen, Whisper-ID wird autom. angehängt

[grdNrConst, grdNrElmnts]   = size(grdData);        %Dimensionen des Grids ermitteln
[grdNrConstPole, bla]       = size(grdKonstrukte);  %Anzahl Konstrukt-Bezeichner
[grdNrElmntsPole, bla]      = size(grdElemente);    %Anzahl Element-Bezeichner
clear bla

%plausibilität
if grdNrConst~=grdNrConstPole 
   disp('rgt2idiogrid: Konstrukt-Dimension des Rating-Grids stimmt nicht mit Anzahl der Konstrukt-Bezeichner überein.');
   pause
   return
elseif grdNrElmnts~=grdNrElmntsPole
    disp('rgt2idiogrid: Elemente-Dimension des Rating-Grids stimmt nicht mit Anzahl der Elemente-Bezeichner überein.');
    pause
    return
end

%Extrema der Ratings ermitteln:
grdMin          = min(min(grdData));  
grdMax          = max(max(grdData));  


grdFnamePath    = '';   %Idiogrid kommt damit kar wenn es leer bleibt, keine probleme mit cross-platform fileseps etc...
%grdType         = 0;    %0=Rating/1=Ranking/2=Binary/3=Coordinate/4=Transformed
grdNrPoles      = 2;    %gibt es eine option für mehr pole in whisper ?!
grdBemerkung = [grdBemerkung 'WhisperToolbox http://www.ak.tu-berlin.de/whisper']; %2do: Whisper-version dynamisch auslesen


grdFile = struct ('headerString'        ,{'[Idiogrid Grid File: Version 2.4]',''},...
                   'grdLabel'           ,{'Grid Label = '           , grdLabel}, ...
                   'grdFnamePath'       ,{'Grid File Name = '       , grdFnamePath}, ...
                   'grdType'            ,{'Grid Type = '            , num2str(grdType)}, ... %0=Rating/1=Ranking/2=Binary/3=Coordinate/4=Transformed
                   'grdNrConst'         ,{'Number of Constructs = ' , num2str(grdNrConst)}, ...
                   'grdNrElmnts'        ,{'Number of Elements = '   , num2str(grdNrElmnts)}, ...
                   'grdNrPoles'         ,{'Number of Poles = '      , num2str(grdNrPoles)}, ...
                   'grdMin'             ,{'Grid Min =     '         , num2str(grdMin)}, ...
                   'grdMax'             ,{'Grid Max =     '         , num2str(grdMax)}, ...
                   'beginConString'     ,{'[BEGIN Constructs]',''},... 
                   'PosConstructPoles'  ,{ grdKonstrukte(:,1), ''}, ... %positive konstrukt-pol bezeichner hier rein
                   'endConString'       ,{'[END Constructs]',''},...
                   'beginConOpString'   ,{'[BEGIN Construct Opposites]',''},...
                   'NegConstructPoles'  ,{ grdKonstrukte(:,2),''}, ...  %negative konstrukt-pol bezeichner hier rein
                   'endConOpString'     ,{'[END Construct Opposites]',''},...
                   'beginElmntsString'  ,{'[BEGIN Elements]',''},... 
                   'ElementNames'       ,{ grdElemente(:,1),''}, ...    %Element-Bezeichner hier rein 
                   'endElmntsString'    ,{'[END Elements]',''},...
                   'beginGriddataString',{'[BEGIN Grid Data]',''},...   %Grid matrix hier rein: Elemente (Spalten) kreuz Konstrukte (Zeilen)
                   'endGriddataString'  ,{'[END Grid Data]',''},...  
                   'beginNotesString'   ,{'[BEGIN Notes]',''},... 
                   'NotesString'        ,{ grdBemerkung,''},...         %Notes hier rein 
                    'endNotesString'     ,{'[END Notes]',''}...
);
               
fid = fopen(grdfilename, 'w');
fprintf(fid, [grdFile.headerString,'\n']);
fprintf(fid, [grdFile.grdLabel,'\n']);
fprintf(fid, [grdFile.grdFnamePath,'\n']);
fprintf(fid, [grdFile.grdType,'\n']);
fprintf(fid, [grdFile.grdNrConst,'\n']);
fprintf(fid, [grdFile.grdNrElmnts,'\n']);
fprintf(fid, [grdFile.grdNrPoles,'\n']);
fprintf(fid, [grdFile.grdMin,'\n']);
fprintf(fid, [grdFile.grdMax,'\n']);

%positive Konstrukt-Pol-Bezeichner rausschreiben:
fprintf(fid, [grdFile.beginConString,'\n']);
    for i=1:grdNrConst
    fprintf(fid, [grdFile(1,1).PosConstructPoles{i},'\n']);  
    end
fprintf(fid, [grdFile.endConString,'\n']);

%negative Konstrukt-Pol-Bezeichner rausschreiben:
fprintf(fid, [grdFile.beginConOpString,'\n']);
    for i=1:grdNrConst
    fprintf(fid, [grdFile(1,1).NegConstructPoles{i},'\n']); 
    end
fprintf(fid, [grdFile.endConOpString,'\n']);

%Elementbezeichner rein:
fprintf(fid, [grdFile.beginElmntsString,'\n']);
    for i=1:grdNrElmnts
    fprintf(fid, [grdFile(1,1).ElementNames{i},'\n']); 
    end
fprintf(fid, [grdFile.endElmntsString,'\n']);

%Grid Daten:
fprintf(fid, [grdFile.beginGriddataString,'\n']);
    for i=1:grdNrConst %zeilenweise
    fprintf(fid, [num2str(grdData(i,:), '     %+5.14f'),'\n']);
    end
fprintf(fid, [grdFile.endGriddataString,'\n']);

%notes rein:
fprintf(fid, [grdFile.beginNotesString,'\n']);
fprintf(fid, [grdFile.NotesString,'\n']);
fprintf(fid, [grdFile.endNotesString,'\n']);
fclose(fid);         
