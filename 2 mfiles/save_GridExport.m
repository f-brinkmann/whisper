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
% This file :   Wrapper f?r die XML/GRD - Export Funktionen
%               - rudiment?rer check der Daten
%               - es werden nur die Ratings der Semantischen Differentiale
%               und der RGT-Sektionen exportiert

% Author    :   Johannes Blickensdorff, alumni at FG Audiokommunikation, TU Berlin
% Email     :   hannes AT blickensdorff DOT com
% Date      :   04-Jan-2011
% Version   :   1.0
% Updated   :
% Tested on :   OSX 10.6.5 w/ Matlab R2009b (7.9.0, OSX)
%               WinXP(32) w/ Matlab R2010b  (7.11.0.58, Win)
%
% to do:
% - whisper version auslesen
% - Benennung der Files / Methadaten evtl. anpassen (user-feedback)
% =========================================================================

%---Debug:------------------------------------------------
%TSD.mat und TSP.mat in das gleiche Verzeichnis kopieren und
%folgende Zeilen aktivieren:
%clear all;
%close all;
%load TSD.mat
%load TSP.mat
%---------------------------------------------------------

global TSD PP

grdLabel        =  TSP.name; %globaler Name des Versuchs
modulname       = 'rgt2IdiogridAndXML: ';
exportdir       = [PP.path filesep 'export' filesep];
for run=2:size(TSD,1) %loop ?ber alle runs ...(ab 2, 1. zeile ist der spalten-header)
    runinfo     = num2str(TSD{run,1}(1));   %infos, um den dateinamen/methas sp?ter zu bauen ...
    subjectinfo = cell2mat(TSD(run,2));
    sessioninfo = cell2mat(TSD(run,3));
    
    globale_anzahl_sections = length(TSP.sections(:,1)); %globale anzahl der definierten sections
    savedSections_current_run = length(TSD(run,:))-3;    %wie viele sektionen im aktuellen run wirklich abgespeichert ?!(plausibilit?t)
    
    if savedSections_current_run ~= globale_anzahl_sections %konsistenz der definierten (TSP) und im versuch auch abgespeicherten (TSD) sektionen pro run testen (funktioniert nicht nur bei abbruch, nicht bei ?bersprungenen sections)
        disp([modulname, 'Warnung! Anzahl abgeschlossener Sections in Run ', runinfo, ' nicht vollstaendig.'])
        disp([modulname, 'Setze Anzahl Sections in Run ', runinfo, ' auf ', num2str(savedSections_current_run)])
        globale_anzahl_sections = savedSections_current_run; %f?r diesen run fixen
    end
    
    
    for sektion=1:globale_anzahl_sections %loop ?ber alle sektionen eines runs; info aus TSP-matrix (d.h. sie sind definiert, k?nnen aber in TSD.mat leer sein)
        
        sektiontype     = TSP.sections{sektion,1};          %'tid1'=adaptive;'tid2'=RGT;'tid3'=SD;'tid4'= A/B/X;
        
        %gridexport sowieso nur f?r RGT (tid2) oder SemDiffs (tid3) - sections:
        if (strcmp(sektiontype,'tid2')==1) || (strcmp(sektiontype,'tid3')==1)
            
        anzahl_Elemente = TSP.sections{sektion,4}{1,4}{2};  %Anzahl benutzter Elemente (Stimuli) in current session, 2do: nochmal checken ob das immer im mat-file gilt
        
        %DEBUG ALEX LINDAU 23.02.2014
        anzahl_Elemente = length(TSP.sections{sektion,4}{1,4});  %Anzahl benutzter Elemente (Stimuli) in current session, 2do: nochmal checken ob das immer im mat-file gilt
        
        Elements        = TSP.stimuli(1:anzahl_Elemente,2); %Bezeichner der Elemente (Stimuli) extrahieren
        sektionname     = TSP.sections(sektion,2:3);        %Name der Sektion extrahieren
          
            %ist die akt. sektion vlt. definiert, enth?lt aber aufgr. Abbruch etc. keine Daten (also leer=[])?!
            if (isempty(TSD{run,sektion+3})==0) && (length(TSD{run,sektion+3})>2)
                
                %Bezeichner der Konstrukte extrahieren: f?r Sektion mit RGT ('tid2')
                if (strcmp(sektiontype,'tid2')==1) %RGT-ID?!
                    Constructs  = TSD{run,sektion+3}(1,1:30)'; %Konstrukt-Bezeichner auslesen (30 ist max.); flippen
                    Constructs(cellfun(@isempty,Constructs)) = []; %leere cells entfernen (weniger als 10 Konstrukte genannt)
                    %data-conversion (geht besser, ich weiss ;) ):
                    for i=1:length(Constructs)   %cell-typ an exportfunktion anpassen (eine ebene raus)
                        Constructs2{i,1} = Constructs{i}{1};
                        Constructs2{i,2} = Constructs{i}{2};
                    end
                    %debug: Constructs3rgt = Constructs2;
                end
                
                %Bezeichner der Konstrukte extrahieren: f?r Sektion mit Semantischem Differential ('tid3')
                if   (strcmp(sektiontype,'tid3')==1)
                    %Constructs2(:,1) = TSP.sections{3,4}{1,5}(:,1); %Bezeichner der SemDiff-Pole holen...
                    %Constructs2(:,2) = TSP.sections{3,4}{1,5}(:,2);
                    % DEBUG AL 23.02.2015
                    Constructs2(:,1) = TSP.sections{sektion,4}{1,5}(:,1); %Bezeichner der SemDiff-Pole holen...
                    Constructs2(:,2) = TSP.sections{sektion,4}{1,5}(:,2);
                    %debug: Constructs3SD = Constructs2;
                end
                
                
                %Bezeichner der Elemente extrahieren:
                for elemente = 1:anzahl_Elemente
                    GridRatings(:,elemente) = TSD{run,sektion+3}{1,(30+elemente)}';
                end
                
                %Dateinamen Methastring bauen....
                grdstring = strcat(TSP.name,'_Sess', sessioninfo, '_Run', runinfo, '_Subj', subjectinfo,'_Sect',num2str(sektion),'_', sektionname{1},'_',sektionname{2});
                %debug:
                %disp([exportdir grdstring])
                      
                %save to Idiogrid-File:
                save_export_whisper2idiogrid([exportdir grdstring '.grd'],cell2mat(GridRatings),grdstring,Constructs2,Elements,0,'')
                
                %save to gridXML-File: (2do: Methadaten noch (besser) aus dem Mat-file zuweisen!)
                Metha.HeaderTopic = grdLabel;
                Metha.HeaderClientName = subjectinfo;
                Metha.HeaderConsultantName = 'WhisperToolbox http://www.ak.tu-berlin.de/whisper';
                Metha.HeaderDatumHV = ''; %eigtl. Datum des Versuchs; wenn leer, dann wird Tagesdatum des Exports eingesetzt
                Metha.HeaderComment = grdstring;
                Metha.ElementeComment = '';
                Metha.RatingsScale = '';
                
                save_export_whisper2gridXML([exportdir grdstring], Elements, Constructs2, cell2mat(GridRatings), Metha);
                
                clear GridRatings Constructs Constructs2;
                
            else
                disp([modulname, 'Warnung! Section ',num2str(sektion), ' in Run ', runinfo, ' ist leer.'])
            end
            
        end
    end %for loop
    %
    
end

