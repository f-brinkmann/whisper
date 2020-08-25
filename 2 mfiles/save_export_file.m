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
% Author :   Andr? Wlodarski, student at FG Audiokommunikation, TU Berlin
% Email  :   awlodarski AT gmx DOT de
% Date   :   15-Nov-2008
%
% =========================================================================


function save_export_file(section)

global TSD PP TSP

% kein Speichern bei leerem TSD
if size(TSD,2)>=4
    switch TSP.sections{section,1}
        case 'tid5' % SAQI
            fprintf('All empirical data from SAQI-test have been saved in TSD.mat.\n')
        case 'tid6' % ABC/HR & MUSHRA
            new_array={};
            % write header part I
            new_array{1,1} = TSD{1,1};
            new_array{1,2} = TSD{1,2};
            new_array{1,3} = TSD{1,3};
            for row = 1:size(TSD,1)-1
                % write run subject and session id
                new_array{row+1,1} = TSD{row+1,1};
                new_array{row+1,2} = TSD{row+1,2};
                new_array{row+1,3} = TSD{row+1,3};
                for col = 1:size(TSD{row+1,section+3},2)
                    % write header part II
                    new_array{1,col+3} = TSD{row+1,section+3}{1,col};
                    % write subjet data
                    new_array{row+1,col+3} = strrep(num2str(TSD{row+1,section+3}{2,col}), '.', ',');
                end
            end
            
            % write to txt file
            fid = fopen([PP.path filesep 'export' filesep 'section' num2str(section) '.csv'], 'w');
            for row=1:size(new_array, 1)
                for col=1:size(new_array, 2)
                    if col < size(new_array, 2)
                        fprintf(fid, '%s;', new_array{row,col}); % Semikolon als Trennzeichen zwischen den Spalten
                    else
                        fprintf(fid, '%s\r\n', new_array{row,col}); % letzte Spalte Zeilenumbuch setzen
                    end
                end
            end
            fclose(fid);
        otherwise
            %Das verschachtelte Cell-Array wird hier entschachtelt, um es als csv-Datei
            %exportieren zu k?nnen
            new_array={};
            %Hier werden nur die ersten drei Spalten mit den unverschachtelten Daten
            %run_number, subject_id und session in das Export-Array new_array
            %?bernommen
            for j=1:size(TSD,1) %?ber zeilen der runs,
                new_array(j,1:3)=TSD(j,1:3);
            end
            
            %Hier nun die tieferen Ebenen
            new_array_column=4; %bis spalte 3 ist new_array schon belegt
            for i=1:size(TSD{1,section+3},2); %ueber spalten der section (TSD Ebene 2)
                if isempty(TSD{1,section+3}{1,i})==0 %wenn der ?berschriften-Block etwas enth?lt (TSD Ebene 2)
                    for j=1:size(TSD,1) %?ber zeilen der runs (TSD Ebene 1)
                        if size(TSD{j,section+3},2)>=i %wenn Stelle i im aktuellen run existiert (TSD Ebene 2)
                            if isempty(TSD{j,section+3}{1,i})==0 %und dort auch im aktuellen run Daten stehen
                                for k=1:size(TSD{j,section+3}{1,i},2)
                                    new_array{j,new_array_column-1+k}=TSD{j,section+3}{1,i}{1,k};
                                end
                            end
                        end
                    end
                    new_array_column=new_array_column+size(TSD{1,section+3}{1,i},2); %Erh?hung des Export-Spaltenindex f?r den n?chsten Durchlauf
                end
            end
            
            %nun noch in reines Textarray wandeln (zum schreiben mit fprintf)
            new_text_array = cellfun(@num2str, new_array, 'UniformOutput', 0);
            %und Punkte durch Komma ersetzen
            new_text_array = strrep(new_text_array, '.', ',');
            
            fid = fopen([PP.path filesep 'export' filesep 'section' num2str(section) '.csv'], 'w');
            for i=1:size(new_text_array, 1)
                fprintf(fid, '%s;', new_text_array{i,1:end-1}); % Semikolon als Trennzeichen zwischen den Spalten
                fprintf(fid, '%s\r\n', new_text_array{i, end}); % letzte Spalte Zeilenumbuch setzen
            end
            fclose(fid);
    end
    
else
    fprintf('No empirical data available for export.\n')
end

