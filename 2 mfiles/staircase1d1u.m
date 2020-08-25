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
% Author :   Simon Ciba, student at FG Audiokommunikation, TU Berlin
% Email  :   sciba2 AT hotmail DOT com
% Date   :    1-Sep-2008
% Updated:   17-Oct-2008 00:00, S.Ciba, structure of parameters
%            14-Nov-2008 16:00, S.Ciba, metadata/comments, bug-fix
%                                       
% =========================================================================
%
% This is an implementation of the adaption and estimation mechanism of a
% simple staircase procedure following a 1-down/1-up rule, halving step 
% size after predefined reversals and estimating the threshold by calcula-
% ting "midrun estimates" for a predetermined number of last consecutive 
% reversals.
%
%
% bibliography:
%
% Cornsweet, T. N. (1962). The Staircase-Method in Psychophysics. American
% Journal of Psychology, 75, S. 485�491.
%
% Levitt, H. (1971). Transformed up-down methods in psychoacoustics. Journal
% of the Acoustical Society of America, 49, Nr. 2, S. 467�477.
% 
% -------------------------------------------------------------------------
%
% [x_next, x_est]
%
% = staircase1d1u(x_hist, r_hist, range, nrmax, halvings, numlastr)
%
% 
% -------------------------------------------------------------------------
% 
% Ausgabe:
%   x_next (Integer): Reizst�rkenwert f�r die Darbietung im n�chsten
%                     Trial einer 1-down/1-up Regel folgend. 
%
%   x_est (Integer):  Sch�tzung der Schwelle durch Mittelwertbildung der 
%                     Reizst�rkenwerte bei den numlastr letzten aufeinander-
%                     folgenden Reversals. (x_est = 0: das Verfahren wurde 
%                     noch nicht terminiert, d.h. es liegt noch keine 
%                     Sch�tzung vor.)
%
% Eingabe: 
%   x_hist (Integer-Array): enth�lt die Reizst�rkenwerte s�mtlicher bisher
%                           dargebotener Stimuli
%   r_hist (Integer-Array): enth�lt die zugeh�rigen Antworten 
%                           (+1: positiv, -1: negativ)
%   range (Integer): legt den Wertebereich [1:range] der
%                    Reizst�rke fest. Die minimale Schrittweite ist mit 1 
%                    vorgegeben.
%
%   nrmax (Integer): maximale Anzahl an Umkehrungen (Reversals) des Tracks,
%                    bei deren Erreichen das Verfahren terminiert wird.
%   halvings (Integer-Array): enth�lt die Indizes der Umkehrpunkte, bei 
%                             denen Halbierungen der Schrittweite erfolgen 
%                             sollen.
%   numlastr (Integer): Anzahl der letzten aufeinanderfolgenden Reversals, 
%                       welche in die Sch�tzung des Endergebnisses eingehen 
%                       sollen.  
%
% -------------------------------------------------------------------------
%
% Hinweis: F�r die Funktionalit�t des vorliegenden Algorithmus darf numlastr
% nrmax nicht �bersteigen. Aus methodischen Gr�nden sollte numlastr au�erdem 
% eine gerade (positive) Zahl sein (vgl. "mid-run estimates" Levitt, 1971).
% Es sollten ferner nur solche Reversals in die Mittelwertbildung einbezogen 
% werden, welche nach Erreichen der minimalen Schrittweite von 1 auftreten. 
%
% -------------------------------------------------------------------------



function [x_next, x_est] = staircase1d1u(x_hist, r_hist, range, nrmax, halvings, numlastr)


% Parameter
Ntrials = length(x_hist); % Anzahl bisher durchgef�hrter Trials
numhalv_total = length(halvings); % Anzahl der insgesamt vorgesehenen Halbierungen
dx_ini = 2^numhalv_total; % Anfangswert der Schrittweite

% Initialisierungen
latest_change = 0; % Indikator f�r zuletzt erfolgte Reizst�rken�nderung 
                   % (0: noch keine �nderung im bisherigen Verlauf,
                   % 1: Erh�hung, -1: Verminderung)
nr = 0; % Z�hler f�r Reversals des Tracks
numhalv = 0; % Z�hler f�r aktuell zu erfolgende Halbierungen
termflag = 0; % Indikator f�r Terminierung des Verfahrens mit dem aktuellen 
              % Trial, d.h. f�r das Erreichen der maximalen Anzahl nrmax an
              % Reversals. (1: beenden, 0: nicht beenden)
x_r = zeros(nrmax, 1); % Speicherung der Reizst�rkenwerte bei s�mtlichen Reversals
x_est = 0;



%                              * * * * *
%                     Analyse des bisherigen Tracks

for trial = 2:Ntrials

    % Reizst�rkenwechsel? (in jedem Trial, Ausnahme an den R�ndern!)
    if x_hist(trial) ~= x_hist(trial-1)
               
        % Art des Reizst�rkenwechsels
        if x_hist(trial) > x_hist(trial-1)
            change = 1; % Erh�hung
        else
            change = -1; % Verminderung
        end
        
    else
        change = 0; % bleibt gleich
    end
    
    % Reversal?
    if (change ~= 0) && (latest_change ~=0) && (latest_change ~= change)
       nr = nr + 1;
       x_r(nr) = x_hist(trial-1);
       latest_change = change;
       if isempty(find(halvings==nr))==0
           numhalv = numhalv + 1;
       end
    elseif (change ~= 0) && (latest_change == 0)
        latest_change = change;
    end

end% Ende Analyse

%                              * * * * * 
%                          N�chster Schritt

% Adaptionsregel: Entscheidung �ber die Richtung des n�chsten Schrittes
% (1-Down/1-UP)
if r_hist(Ntrials) == 1
    this_change = -1;
else
    this_change = +1;
end

% Reversal?
if (this_change ~= latest_change) && (latest_change ~=0) 
    nr = nr + 1;
    x_r(nr)=x_hist(Ntrials);
    if isempty(find(halvings==nr))==0
           numhalv = numhalv + 1;
    end
end

% Terminierung?
if nr >= nrmax
    termflag = 1;
end

% Berechnung der Gr��e des n�chsten Schrittes 
% x_hist(Ntrials)--> x_hist(Ntrials + 1)           
dx = round(dx_ini/(2^numhalv));

% Berechnung des n�chsten Reizst�rkenwertes
x_next = x_hist(Ntrials) + this_change * dx;

% Verhalten an den R�ndern
if x_next > range
    x_next = range;
end

if x_next < 1
    x_next = 1;
end

%                              * * * * *
%                 Berechnung der Schwellensch�tzung


if termflag == 1
    x_est = mean(x_r((nrmax-numlastr+1):nrmax));
end



