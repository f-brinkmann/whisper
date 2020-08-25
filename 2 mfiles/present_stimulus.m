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


function present_stimulus(ID)

global TSP PP PS


%ID im Pool suchen
line_in_global=0;
for j=1:length(TSP.stimuli(:,1))
    if TSP.stimuli{j,1}==ID
        line_in_global=j;
    end
end


%wavefile abspielen
if isempty(TSP.stimuli{line_in_global,3})==0 %wenn Simulus wave enth?lt...
    wavepath=[PP.path filesep 'audiofiles' filesep TSP.stimuli{line_in_global,3}];
    [y, Fs] = audioread(wavepath, 'native');
    clear global player;
    global player; 
    player = audioplayer(y, Fs);
    play(player);
end


%osc-Befehl senden
for i=1:6
    if ~isempty(TSP.stimuli{line_in_global,5}{i,2})
        host     = PS.network{1,1}{i,1};
        port     = str2num(PS.network{1,1}{i,2});
        osc_path = TSP.stimuli{line_in_global,5}{i,2};
        type     = TSP.stimuli{line_in_global,5}{i,3};
        %start changes alex:
        switch type
            case 's'
                data = cell2mat(TSP.stimuli{line_in_global,5}(i,4));
            case 'i'
                data = cell2mat({str2num(TSP.stimuli{line_in_global,5}{i,4})});
            case 'f'
                data = cell2mat({str2num(TSP.stimuli{line_in_global,5}{i,4})});
            case 'T'
                data = 'true';
            case 'F'
                data = 'false';
        end
        clc % echoing
        struct( 'path', osc_path, 'type', type, 'data', { data } )
        
        u = udp(host, port);
        fopen(u);
        pause(TSP.stimuli{line_in_global,5}{i,1})
        oscsend(u,osc_path,type,data);
        fclose(u);
        %end changes alex        
    end
end

