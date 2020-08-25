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
% Updated:   18-Nov-2008 - fixed spelling and representation of triad
%                          contents
% =========================================================================


global TSP PP

summary={};
%Name und Sesson
summary{1,1}=['name of test series: ', TSP.name];
summary{size(summary,1)+1,1}='';
summary{size(summary,1)+1,1}=['number of sessions: ', num2str(TSP.number_of_sessions)];
summary{size(summary,1)+1,1}='';
summary{size(summary,1)+1,1}='';
summary{size(summary,1)+1,1}='';
%stimulus pool
summary{size(summary,1)+1,1}='----------------------------------------------------------------------';
summary{size(summary,1)+1,1}='stimuli of test series';
summary{size(summary,1)+1,1}='----------------------------------------------------------------------';
summary{size(summary,1)+1,1}='';
summary{size(summary,1)+1,1}='';
for i=1:length(TSP.stimuli(:,1)) %Schleife ?ber alle Stimuli
    summary{size(summary,1)+1,1}=['stimulus ID  : S', num2str(TSP.stimuli{i,1})];
    summary{size(summary,1)+1,1}='------------';
    summary{size(summary,1)+1,1}=['stimulus name: ', TSP.stimuli{i,2}];
    summary{size(summary,1)+1,1}=['wave file    : ', TSP.stimuli{i,3}];
    summary{size(summary,1)+1,1}=['duration     : ', num2str(TSP.stimuli{i,4})];
    %osc des Stimulus
    for j=1:6 %Schleife ?ber osc-Server
        summary{size(summary,1)+1,1}='-';
        summary{size(summary,1)+1,1}=['osc pre pause ', num2str(j), ': ', num2str(TSP.stimuli{i,5}{j,1})];
        summary{size(summary,1)+1,1}=['osc path ', num2str(j), '     : ', num2str(TSP.stimuli{i,5}{j,2})];
        summary{size(summary,1)+1,1}=['osc data type ', num2str(j), ': ', num2str(TSP.stimuli{i,5}{j,3})];
        summary{size(summary,1)+1,1}=['osc data ', num2str(j), '     : ', num2str(TSP.stimuli{i,5}{j,4})];
    end
    summary{size(summary,1)+1,1}='';
    summary{size(summary,1)+1,1}='';
end

summary{size(summary,1)+1,1}='';
summary{size(summary,1)+1,1}='';

if size(TSP.sections,1)>0
    
 %Testverfahren
 for i=1:length(TSP.sections(:,1)) %Schleife ?ber sections
    summary{size(summary,1)+1,1}='----------------------------------------------------------------------';
    summary{size(summary,1)+1,1}=['test section ',num2str(i)];
    summary{size(summary,1)+1,1}='----------------------------------------------------------------------';
    
    switch TSP.sections{i,1}
        case 'tid1' %adaptive Verfahren
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}='type of procedure    : adaptive procedure';
            summary{size(summary,1)+1,1}=['internal name        : ',TSP.sections{i,2}];
            summary{size(summary,1)+1,1}=['label for subject GUI: ',TSP.sections{i,3}];
            summary{size(summary,1)+1,1}='initial instruction:';
            summary{size(summary,1)+1,1}=TSP.sections{i,4}{1,2}(:,:);
            summary{size(summary,1)+1,1}='short instruction:';
            summary{size(summary,1)+1,1}=TSP.sections{i,4}{1,3}(:,:);
            summary{size(summary,1)+1,1}='';
            
            %paradigm
            switch TSP.sections{i,4}{1,5}
                case 1
                    summary{size(summary,1)+1,1}=['paradigm             : ',num2str(TSP.sections{i,4}{1,8}{1,1}), 'AFC'];
                    summary{size(summary,1)+1,1}=['break betw. intervals: ',num2str(TSP.sections{i,4}{1,8}{1,2}), ' sec'];
                case 2
                    %derzeit nicht vorhanden
            end
            summary{size(summary,1)+1,1}=['break between trials : ',num2str(TSP.sections{i,4}{1,1}), ' sec'];
            
            %tracks
            if TSP.sections{i,4}{1,4}{1,1}==2
                value_string='yes';
            else
                value_string='no';
            end
            summary{size(summary,1)+1,1}=['multi session use:     ',value_string];
            summary{size(summary,1)+1,1}='';
            for j=1:length(TSP.sections{i,4}(:,6)) %Schleife ?ber alle Tracks
                summary{size(summary,1)+1,1}=['track number         : ',num2str(j)];
                summary{size(summary,1)+1,1}='-------------------------';
                summary{size(summary,1)+1,1}=['track name           : ',TSP.sections{i,4}{j,6}];
                summary{size(summary,1)+1,1}=['range from 1 to:       ',num2str(TSP.sections{i,4}{j,7}{1,1}(1,1))];
                summary{size(summary,1)+1,1}='stimulus assignement:';
                last_connected_stimulus=TSP.sections{i,4}{j,7}{1,1}(1,1);
                if length(TSP.sections{i,4}{j,7}{1,1}(:,2))<last_connected_stimulus
                    last_connected_stimulus=length(TSP.sections{i,4}{j,7}{1,1}(:,2));
                end
                for k=1:last_connected_stimulus %Schleife ?ber alle Targets
                    summary{size(summary,1)+1,1}=['   stimulus ID for value ',num2str(k),': S',num2str(TSP.sections{i,4}{j,7}{1,1}(k,2))];
                end
                
                %Track-Einstellungen
                %Adaptionsmechanismus
                switch TSP.sections{i,4}{j,7}{2,1}(1,1)
                    case 1 %staircase
                        summary{size(summary,1)+1,1}=['track type           : ','staircase'];
                        if TSP.sections{i,4}{j,7}{1,2}{1,1}==0
                            summary{size(summary,1)+1,1}=['halve step size      : ','no'];
                        else
                            summary{size(summary,1)+1,1}=['halve stepsize after : ',strcat(num2str(TSP.sections{i,4}{j,7}{1,2}{1,2})),' (reversals)'];
                        end
                        summary{size(summary,1)+1,1}=['initial level        : ',num2str(TSP.sections{i,4}{j,7}{1,2}{1,3})];
                        summary{size(summary,1)+1,1}=['adaption rule        : ',num2str(TSP.sections{i,4}{j,7}{1,2}{1,4}),'-down/1-up'];
                        summary{size(summary,1)+1,1}=['termination after    : ',num2str(TSP.sections{i,4}{j,7}{1,2}{1,5}),' reversals'];
                        if TSP.sections{i,4}{j,7}{1,2}{1,8}==1
                            summary{size(summary,1)+1,1}=['jump out after       : ',num2str(TSP.sections{i,4}{j,7}{1,2}{1,6}),' trials'];
                        end
                        summary{size(summary,1)+1,1}=['averaging the last   : ',num2str(TSP.sections{i,4}{j,7}{1,2}{1,7}),' reversals for estimation'];
                    case 2 %PEST
                        summary{size(summary,1)+1,1}=['track type           : ','PEST'];
                        summary{size(summary,1)+1,1}=['initial level        : ',num2str(TSP.sections{i,4}{j,7}{1,3}{1,1})];
                        summary{size(summary,1)+1,1}=['initial stepsize     : ',num2str(2^TSP.sections{i,4}{j,7}{1,3}{1,2})];
                        summary{size(summary,1)+1,1}=['maximum stepsize     : ',num2str(2^TSP.sections{i,4}{j,7}{1,3}{1,8})];
                        if TSP.sections{i,4}{j,7}{1,3}{1,3}==1
                            summary{size(summary,1)+1,1}=['PEST version         : ','original PEST (Taylor & Creelman 1967)'];
                            summary{size(summary,1)+1,1}=['deviation limit W    : ',num2str(TSP.sections{i,4}{j,7}{1,3}{1,4})];
                        else
                            summary{size(summary,1)+1,1}=['PEST version         : ','more virulent PEST (Findlay 1978)'];
                            summary{size(summary,1)+1,1}=['parameter M          : ',num2str(TSP.sections{i,4}{j,7}{1,3}{1,5})];
                        end
                        summary{size(summary,1)+1,1}=['target probability   : ',num2str(TSP.sections{i,4}{j,7}{1,3}{1,6})];
                        if TSP.sections{i,4}{j,7}{1,3}{1,9}==1
                            summary{size(summary,1)+1,1}=['jump out after       : ',num2str(TSP.sections{i,4}{j,7}{1,3}{1,7}),' trials'];
                        end
                    case {31,32,33} %ML Bayes
                     switch TSP.sections{i,4}{j,7}{2,1}(1,1)
                         case 31 %ZEST
                             summary{size(summary,1)+1,1}=['track type           : ','maximum likelihood / Bayes - ZEST'];
                         case 32 %QUEST
                             summary{size(summary,1)+1,1}=['track type           : ','maximum likelihood / Bayes - QUEST'];
                         case 33 %manuell
                             summary{size(summary,1)+1,1}=['track type           : ','maximum likelihood / Bayes - manuell'];
                     end 
                        summary{size(summary,1)+1,1}=['spread parameter beta: ',num2str(TSP.sections{i,4}{j,7}{1,4}{1,1})];
                        summary{size(summary,1)+1,1}=['guessing rate gamma  : ',num2str(TSP.sections{i,4}{j,7}{1,4}{1,2})];
                        summary{size(summary,1)+1,1}=['lapsing rate lambda  : ',num2str(TSP.sections{i,4}{j,7}{1,4}{1,3})];
                        switch TSP.sections{i,4}{j,7}{1,4}{1,5}
                            case 1
                                summary{size(summary,1)+1,1}=['initialisation       : ','implicit trials (Liebermann & Pentland 1982)'];
                            case 2
                                summary{size(summary,1)+1,1}=['initialisation       : ','gaussian a-priori likelihood'];
                                summary{size(summary,1)+1,1}=['   mean              : ',num2str(TSP.sections{i,4}{j,7}{1,4}{1,6})];
                                summary{size(summary,1)+1,1}=['   standard deviation: ',num2str(TSP.sections{i,4}{j,7}{1,4}{1,7})];
                            case 3
                                summary{size(summary,1)+1,1}=['initialisation       : ','uniform a-priori likelihood'];
                        end
                        if TSP.sections{i,4}{j,7}{1,4}{1,4}==1
                            summary{size(summary,1)+1,1}=['final estimate       : ','exclude prior information from calculation'];
                        else
                            summary{size(summary,1)+1,1}=['final estimate       : ','include prior information from calculation'];
                        end
                        if TSP.sections{i,4}{j,7}{1,4}{1,8}==1
                            summary{size(summary,1)+1,1}=['measure of central tendency : ','mode'];
                        else
                            summary{size(summary,1)+1,1}=['measure of central tendency : ','mean'];
                        end
                        if TSP.sections{i,4}{j,7}{1,4}{1,9}==1
                            summary{size(summary,1)+1,1}=['termination by       : ','number of trials'];
                            summary{size(summary,1)+1,1}=['   number of trials  : ',num2str(TSP.sections{i,4}{j,7}{1,4}{1,10})];
                        else
                            summary{size(summary,1)+1,1}=['termination by       : ','confidence interval'];
                            summary{size(summary,1)+1,1}=['   max. width        : ',num2str(TSP.sections{i,4}{j,7}{1,4}{1,11})];
                            summary{size(summary,1)+1,1}=['   conf. level       : ',num2str(TSP.sections{i,4}{j,7}{1,4}{1,12})];
                            if TSP.sections{i,4}{j,7}{1,4}{1,13}==1
                                summary{size(summary,1)+1,1}=['   jump out after    : ',num2str(TSP.sections{i,4}{j,7}{1,4}{1,14}),' trials'];
                            end
                        end
                        
                end
                summary{size(summary,1)+1,1}='';
            end
            
            %session-info AP
            summary{size(summary,1)+1,1}='session setup';
            summary{size(summary,1)+1,1}='-------------';
            summary{size(summary,1)+1,1}=['number of sessions   : ',num2str(TSP.number_of_sessions)];
            if TSP.sections{i,4}{1,4}{1,1}==2
                summary{size(summary,1)+1,1}=['multi session use    : ','yes, organized manually'];
                %nun einzelne sessions durchgehen
                summary{size(summary,1)+1,1}='';
                for j=1:TSP.number_of_sessions
                    summary{size(summary,1)+1,1}=['session number       : ',num2str(j)];
                    summary{size(summary,1)+1,1}=['   content of session: ',num2str(TSP.sections{i,4}{1,4}{j,2})];
                    summary{size(summary,1)+1,1}='';
                end
            else
                summary{size(summary,1)+1,1}=['multi session use    : ','no, all tracks interleaved'];
            end
            
        case 'tid2' %RGT
            %%%%%%%%% allgemeine Info
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}='type of procedure:     repertory grid techniqe';
            summary{size(summary,1)+1,1}=['internal name        : ',TSP.sections{i,2}];
            summary{size(summary,1)+1,1}=['label for subject GUI: ',TSP.sections{i,3}];
            summary{size(summary,1)+1,1}='';
            %elementpool
            summary{size(summary,1)+1,1}='element pool:';
            summary{size(summary,1)+1,1}='-------------';
            for j=1:length(TSP.sections{i,4}{1,1}(:,1))
                summary{size(summary,1)+1,1}=['element ', num2str(j),':  S',num2str(TSP.sections{i,4}{1,1}(j,1))];
            end
            %triads
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}='triads:';
            summary{size(summary,1)+1,1}='-------';
            for j=1:length(TSP.sections{i,5}{1,1}(:,1))
                summary{size(summary,1)+1,1}=['triad ', num2str(j),':  S',num2str(TSP.sections{i,5}{1,1}(j,1)),'  S',num2str(TSP.sections{i,5}{1,1}(j,2)),'  S',num2str(TSP.sections{i,5}{1,1}(j,3))];
            end
            
            %%%%%%%%% Konstrukt-Erhebung
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}='construct elicitation part:';
            summary{size(summary,1)+1,1}='----------------------------------------------------------------------';
            summary{size(summary,1)+1,1}='initial instruction:';
            summary{size(summary,1)+1,1}=TSP.sections{i,5}{1,4}(:,:);
            summary{size(summary,1)+1,1}='short instruction:';
            summary{size(summary,1)+1,1}=TSP.sections{i,5}{1,5}(:,:);
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}=['max num of constructs per triad: ',num2str(TSP.sections{i,5}{1,3})];
            
            %session info kontrukt
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}='session setup';
            summary{size(summary,1)+1,1}='-------------';
            summary{size(summary,1)+1,1}=['number of sessions   : ',num2str(TSP.number_of_sessions)];
            if TSP.sections{i,5}{1,2}{1,1}==2
                summary{size(summary,1)+1,1}=['multi session use    : ','yes, manual selection'];
                if TSP.sections{i,5}{1,2}{1,3}==2
                    summary{size(summary,1)+1,1}=['sequence             : ','random'];
                else
                    summary{size(summary,1)+1,1}=['sequence             : ','as defined below'];
                end
                %nun einzelne sessions durchgehen
                summary{size(summary,1)+1,1}='';
                for j=1:TSP.number_of_sessions
                    summary{size(summary,1)+1,1}=['session number       : ',num2str(j)];
                    if length(TSP.sections{i,5}{1,2}(:,2))>=j
                        summary{size(summary,1)+1,1}=['   content of session: ',num2str(TSP.sections{i,5}{1,2}{j,2})];
                    end
                    summary{size(summary,1)+1,1}='';
                end
            else
                summary{size(summary,1)+1,1}=['multi session use    : ','no, all triads in random order'];
            end
            
            %%%%%%%%% Rating-Teil
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}='rating part:';
            summary{size(summary,1)+1,1}='----------------------------------------------------------------------';
            summary{size(summary,1)+1,1}='initial instruction:';
            summary{size(summary,1)+1,1}=TSP.sections{i,4}{1,8}(:,:);
            summary{size(summary,1)+1,1}='short instruction:';
            summary{size(summary,1)+1,1}=TSP.sections{i,4}{1,9}(:,:);
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}=['break between trials : ',num2str(TSP.sections{i,4}{1,7}), ' sec'];
            
            %range
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}='range settings:';
            summary{size(summary,1)+1,1}='---------------';
            summary{size(summary,1)+1,1}=['categories'' values  : ',num2str(TSP.sections{i,4}{1,2}')];
            cat_labels='';
            if isempty(TSP.sections{i,4}{1,3})==0
            for j=1:length(TSP.sections{i,4}{1,3}(:,1))
                cat_labels=[cat_labels,'  ',(TSP.sections{i,4}{1,3}{j,1})];
            end
            end
            summary{size(summary,1)+1,1}=['categories'' labels  : ',cat_labels];
            
            %session info rating
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}='session setup';
            summary{size(summary,1)+1,1}='-------------';
            summary{size(summary,1)+1,1}=['number of sessions   : ',num2str(TSP.number_of_sessions)];
            if TSP.sections{i,4}{1,6}{1,1}==2
                summary{size(summary,1)+1,1}=['multi session use    : ','yes, manual selection'];
                if TSP.sections{i,4}{1,6}{1,3}==2
                    summary{size(summary,1)+1,1}=['sequence             : ','random'];
                else
                    summary{size(summary,1)+1,1}=['sequence             : ','as defined below'];
                end
                %nun einzelne sessions durchgehen
                summary{size(summary,1)+1,1}='';
                for j=1:TSP.number_of_sessions
                    summary{size(summary,1)+1,1}=['session number       : ',num2str(j)];
                    if length(TSP.sections{i,4}{1,6}(:,2))>=j
                        summary{size(summary,1)+1,1}=['   content of session: ',num2str(TSP.sections{i,4}{1,6}{j,2})];
                    end
                    summary{size(summary,1)+1,1}='';
                end
            else
                summary{size(summary,1)+1,1}=['multi session use    : ','no, all elements in random order'];
            end
            
        case 'tid3' %SD
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}='type of procedure:     semantic differential';
            summary{size(summary,1)+1,1}=['internal name        : ',TSP.sections{i,2}];
            summary{size(summary,1)+1,1}=['label for subject GUI: ',TSP.sections{i,3}];
            summary{size(summary,1)+1,1}='initial instruction:';
            summary{size(summary,1)+1,1}=TSP.sections{i,4}{1,8}(:,:);
            summary{size(summary,1)+1,1}='short instruction:';
            summary{size(summary,1)+1,1}=TSP.sections{i,4}{1,9}(:,:);
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}=['break between trials : ',num2str(TSP.sections{i,4}{1,7}), ' sec'];
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}='object pool:';
            summary{size(summary,1)+1,1}='------------';
            for j=1:length(TSP.sections{i,4}{1,1}(:,1))
                summary{size(summary,1)+1,1}=['object ', num2str(j),':  S',num2str(TSP.sections{i,4}{1,1}(j,1))];
            end
            %range
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}='range settings:';
            summary{size(summary,1)+1,1}='------------';
            summary{size(summary,1)+1,1}=['categories'' values  : ',num2str(TSP.sections{i,4}{1,2}')];
            cat_labels='';
            if isempty(TSP.sections{i,4}{1,3})==0
            for j=1:length(TSP.sections{i,4}{1,3}(:,1))
                cat_labels=[cat_labels,'  ',(TSP.sections{i,4}{1,3}{j,1})];
            end
            end
            summary{size(summary,1)+1,1}=['categories'' labels  : ',cat_labels];
            %items
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}='definition of items:';
            summary{size(summary,1)+1,1}='--------------------';
            for j=1:length(TSP.sections{i,4}{1,5}(:,1))
                summary{size(summary,1)+1,1}='';
                summary{size(summary,1)+1,1}=['item ', num2str(j)];
                summary{size(summary,1)+1,1}='-';
                summary{size(summary,1)+1,1}=['low pole : ',TSP.sections{i,4}{1,5}{j,1}];
                summary{size(summary,1)+1,1}=['high pole: ',TSP.sections{i,4}{1,5}{j,2}];
                summary{size(summary,1)+1,1}=['polarity : ',TSP.sections{i,4}{1,5}{j,3}];
            end
            %session
            summary{size(summary,1)+1,1}='';
            summary{size(summary,1)+1,1}='session setup';
            summary{size(summary,1)+1,1}='-------------';
            summary{size(summary,1)+1,1}=['number of sessions   : ',num2str(TSP.number_of_sessions)];
            if TSP.sections{i,4}{1,6}{1,1}==2
                summary{size(summary,1)+1,1}=['multi session use    : ','yes, manual selection'];
                if TSP.sections{i,4}{1,6}{1,3}==2
                    summary{size(summary,1)+1,1}=['sequence             : ','random'];
                else
                    summary{size(summary,1)+1,1}=['sequence             : ','as defined below'];
                end
                %nun einzelne sessions durchgehen
                summary{size(summary,1)+1,1}='';
                for j=1:TSP.number_of_sessions
                    summary{size(summary,1)+1,1}=['session number       : ',num2str(j)];
                    if length(TSP.sections{i,4}{1,6}(:,2))>=j
                        summary{size(summary,1)+1,1}=['   content of session: ',num2str(TSP.sections{i,4}{1,6}{j,2})];
                    end
                    summary{size(summary,1)+1,1}='';
                end
            else
                summary{size(summary,1)+1,1}=['multi session use    : ','no, all objects in random order'];
            end
        case 'tid4'; % ABX
            summary{size(summary,1)+1,1} = 'For information on test settings open test series and go to ''edit -> test section -> edit procedure properties''';
        case 'tid5' % SAQI
            summary{size(summary,1)+1,1} = 'For information on test settings open test series and go to ''edit -> test section -> edit procedure properties''';
        case 'tid6' % ABC/HR & MUSHRA
            summary{size(summary,1)+1,1} = '';
            if TSP.sections{i,4}{1,4}==1
                summary{size(summary,1)+1,1} = 'Test type: ITU-R Rec. BS.1116-1 (ABC/HR)';
            else
                summary{size(summary,1)+1,1} = 'Test type: ITU-R Rec. BS.1534-1 (MUSHRA)';
            end
            summary{size(summary,1)+1,1} = ['Scale steps: ' num2str(TSP.sections{i,4}{1,3}{9})];
            summary{size(summary,1)+1,1} = 'Scale label:';
            for m = 1:TSP.sections{i,4}{1,3}{9}
                summary{size(summary,1)+1,1} = [num2str(m-1) TSP.sections{i,4}{1,3}{8}{m}];
            end
            if TSP.sections{i,4}{1,3}{17}==2
                summary{size(summary,1)+1,1} = 'Group randomization: on';
            else
                summary{size(summary,1)+1,1} = 'Group randomization: off';
            end
            if TSP.sections{i,4}{1,3}{18}==2
                summary{size(summary,1)+1,1} = 'Condition randomization: on';
            else
                summary{size(summary,1)+1,1} = 'Condition randomization: off';
            end
            summary{size(summary,1)+1,1} = '';
            summary{size(summary,1)+1,1} = 'For more information open test series and go to ''edit -> test section -> edit procedure properties''';
    end
    summary{size(summary,1)+1,1}='';
    summary{size(summary,1)+1,1}='';
    summary{size(summary,1)+1,1}='';
    summary{size(summary,1)+1,1}='';
 end
 
end

fid = fopen([PP.path filesep 'testseries.info'], 'w');
for i=1:size(summary, 1)
    fprintf(fid, '%s;', summary{i,1:end-1}); %
    if iscell (summary{i, end})
        % old code (cell2mat(summary{i, end});) was prone to errors
        % changed 01/2017 - fbrinkmann
        for ii = 1:size(summary{i, end},1)
            txt = summary{i, end}{ii};
            fprintf(fid, '%s\r\n', txt); % letzte Spalte Zeilenumbuch setzen
        end
    else
        fprintf(fid, '%s\r\n', summary{i, end}); % letzte Spalte Zeilenumbuch setzen
    end
end
fclose(fid);

%nur zu Testzwecken
% %winopen([PP.path filesep 'testseries.info'])

