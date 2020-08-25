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
% -------------------------------------------------------------------------
% 
% This file:
%
% Author :   Andr? Wlodarski, student at FG Audiokommunikation, TU Berlin
% Email  :   awlodarski AT gmx DOT de
% Date   :   15-Nov-2008
% Changed:   26-Mai-2010, Matthias Herder: Compatibilitycheck and -import 
%            (extended MLBayes)
%
% =========================================================================


function load_test_series(path)

close all
clear global TSP TSD PP
load ([path filesep 'TSP.mat']);

% Kompatibilit?tscheck und -import(wg. erweitertem MLBayes-Verfahren)
% 1.Schritt: Welche Sections enthalten ?berhaupt das tid1 = AP?
if ~isempty(TSP.sections)
    ap_sections = strmatch('tid1', cat(1,TSP.sections{:,1}));
else
    ap_sections = [];
end

if length(ap_sections) > 0
    load 'PC.mat';
    for n = 1:length(ap_sections) 
        % 2.Schritt: Wieviele Tracks gibts in der jeweiligen AP-section?
        num_ap_tracks = length(TSP.sections{n,4}(:,7));
        if num_ap_tracks > 0
            for m = 1:num_ap_tracks
                % Ist das erste "neue" Feld vorhanden?
                try 
                    TSP.sections{n,4}{m,7}{1,4}{1,15};
                catch exception
                    if strcmp(exception.identifier, 'MATLAB:badsubscript') 
                        % Treffer, da war nix -> Auff?llen:
                        % PsyFunc-typ
                        TSP.sections{n,4}{m,7}{1,4}{1,15} = 1; % logistische
                        % Epsilon
                        TSP.sections{n,4}{m,7}{1,4}{1,16} = PC.testing_procedures{1,3}{1,7}{1,4}{1,16};
                        % pT (wird eh' nur angezeigt)
                        TSP.sections{n,4}{m,7}{1,4}{1,17} = PC.testing_procedures{1,3}{1,7}{1,4}{1,17};
                        % A
                        TSP.sections{n,4}{m,7}{1,4}{1,18} = PC.testing_procedures{1,3}{1,7}{1,4}{1,18};
                        % B
                        TSP.sections{n,4}{m,7}{1,4}{1,19} = PC.testing_procedures{1,3}{1,7}{1,4}{1,19};
                        % t
                        TSP.sections{n,4}{m,7}{1,4}{1,20} = PC.testing_procedures{1,3}{1,7}{1,4}{1,20};
                        % C
                        TSP.sections{n,4}{m,7}{1,4}{1,21} = PC.testing_procedures{1,3}{1,7}{1,4}{1,21};

                        % War als Prozedur "MLBayes" ausgew?hlt? -> dann
                        % anpassen an die neue Codierung
                        if TSP.sections{n,4}{m,7}{2,1} == 3 % alter Wert
                            TSP.sections{n,4}{m,7}{2,1} = 33; % = MLBayes, manuell -> wie vorher
                        end
                    end
                end
            end
        end
    end
    
    clear PC;
end
            
    



if exist([path filesep 'TSD.mat'])>0
    load ([path filesep 'TSD.mat']);
end
global PP;
PP.path=path;
%Falls Ordner umbenannt wurde, wird der neue Ordnername auch f?r die
%Versuchsreihe gesetzt
backslash_positions=findstr(PP.path, filesep);
last_backslash_position=backslash_positions(numel(backslash_positions));
TSP.name=PP.path(last_backslash_position+1:numel(PP.path));
save ([PP.path filesep 'TSP.mat'],'TSP');

mainmenu

