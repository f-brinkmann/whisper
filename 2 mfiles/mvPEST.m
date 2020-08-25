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
% Date   :   01-Sep-2008
% Updated:   17-Oct-2008 00:00, S.Ciba, max. step size, order of parameters
%            28 Oct 2008 23:00, S.Ciba, structure of parameters
%             7-Nov-2008 00:00, S.Ciba, metadata/comments
%
% =========================================================================
%
% This is an implementation of the adaption and estimation mechanism of the
% PEST procedure modified by Findlay (1978) called a "more virulent PEST".
%
%
% bibliography:
%
% Findlay, J. M. (1978). Estimates on probability functions: A more
% virulent PEST. Perception & Psychophysics, 23, Nr. 2, S. 181�185.
%
% Taylor, M. M.; Creelman, C. (1967). PEST: Efficient estimates on
% probability functions. Journal of the Acoustical Society of America, 41,
% Nr. 4, S. 782�787.
%
% -------------------------------------------------------------------------
%
% [x_next, x_est] = mvPEST(x_hist, r_hist, range, dx_ini, dx_max, P_t, M)
% 
% -------------------------------------------------------------------------
%
% Ausgabe:
%   x_next (Integer/  Reizst�rkenwert f�r die Darbietung im n�chsten Trial,
%           Double):  basierend auf dem Adaptionsmechansimus des PEST-Ver-
%                     fahrens in einer modifizierten Version (More-Virulent
%                     -PEST) nach Findlay(1978). (Nach dem letzten Funktions-
%                     aufruf ist dieser Wert gleich der Sch�tzung der 
%                     Schwelle in x_est.)
%   x_est  (Double):  Sch�tzung der Schwelle und gleichzeitig Indikator f�r
%                     Terminierung (x_est = 0: das Verfahren wurde noch 
%                     nicht terminiert, d.h. es liegt noch keine Sch�tzung 
%                     vor).
%
%
% Eingabe: 
%   x_hist (Integer-Array): enth�lt die Reizst�rkenwerte s�mtlicher bisher
%                           dargebotener Stimuli
%   r_hist (Integer-Array): enth�lt die zugeh�rigen Antworten 
%                           (+1: positiv, -1: negativ)
%   range (Integer): legt den Wertebereich [1:range] der
%                    Reizst�rke fest. Die minimale Schrittweite ist mit 1 
%                    vorgegeben.
%   dx_ini (Integer):Anfangswert der Schrittweite 
%   dx_max (Integer):Maximale Schrittweite, welche w�hrend des Verfahrens 
%                    zu keinem Zeitpunkt (auch nicht im ersten Schritt)
%                    �berschritten wird.
%
%   P_t (Double):    Konvergenzniveau des Tracks
%
%   M (Integer):     Parameter f�r Findlays 1.Modifikation
%
% -------------------------------------------------------------------------
%
% Hinweis: dx_ini und dx_max sollten sinnvoller Weise Zweierpotenzen sein. 
% Der Algorithmus "funktioniert" jedoch auch f�r beliebige reelle positive 
% Werte, da intern eine Rundung der Schrittweiten erfolgt (s.u.).
%
% -------------------------------------------------------------------------

function [x_next, x_est] = mvPEST(x_hist, r_hist, range, dx_ini, dx_max, P_t, M)

% Parameter
Ntrials = length(x_hist); % Anzahl bisher durchgef�hrter Trials

% Initialisierungen
latest_change = 0; % Kodierung f�r die zuletzt erfolgte Reizst�rken�nderung 
                   % (-1: Erniedrigung, +1: Erh�hung, 0: es ist im bis-
                   % herigen Verlauf noch keine Reizst�rken�nderung ein-
                   % getreten.                
doubling = 0; % merkt sich, wenn die Schrittweite verdoppelt, d.h. ner um 1
              % verringert wird
rule4 = 0; % Indikator f�r das Vorhandensein einer Verdopplung der Schritt-
           % weite vor der zuletzt erfolgten Richtungsumkehr (siehe Regel 4)   
termflag = 0; % Indikator f�r Terminierung (1: Terminierung erfolgt, 
              % 0: keine Terminierung)
ner = 0; % Initialisierung der number of effective reversals (ner)
nstep = 0;  % z�hlt bei Reizst�rken�nderungen alle Schritte in eine
            % gegebene Richtung

            
                  
%--------------------------------------------------------------------------
% Analyse des Tracks & Reizst�rkenwert f�r die n�chste Darbietung
%--------------------------------------------------------------------------

 
% Initialisierung des Signifikanztests
decision = 1;

for trial = 1:Ntrials

    
    %----------------------------------------------------------------------
    % Signifikanztest
    %----------------------------------------------------------------------
    
    % T z�hlt die Anzahl der Trials, die bei einer gleichbleibenden
    % Reizst�rke durchgef�hrt wurden
    % N_C z�hlt die positiven Antworten bei einer gleichbleibenden
    % Reizst�rke
    
    % Reset des Tests wenn im vorherigen Trial Entscheidung f�r �nderung
    % der Reizst�rke
    if decision ~= 0
        T = 0;
        N_C = 0;
    end
    
    T = T + 1; % Z�hlen s�mtlicher Trials bei derselben Reizst�rke
    if r_hist(trial) == +1
        N_C = N_C + 1; % Z�hlen positiver Antworten bei derselben Reizst�rke
    end
    
    %  *** Findlays 2. Modifikation: 
    % Das Deviation-Limit ist eine Funktion von ner
            if ner > 1
                W = ner / 2;
            else
                W = 0.5;
            end
    
       
    E = P_t * T; % erwartete Anzahl positiver Antworten nach T bei gleicher
                 % Reizst�rke durchgef�hrten Trials
    N_bu = E + W; % obere Grenze
    N_bl = E - W; % untere Grenze
    
    
    % Der eigentliche Kern des Tests
    % Die Richtung der Reizst�rken�nderung wird durch die Variable decision
    % ausgedr�ckt:
    %   decision = +1: Erh�hung 
    %   decision = -1: Verminderung
    %   decision =  0: keine �nderung
    
    if (N_C < N_bu) && (N_C > N_bl)
        x_next = x_hist(trial);
        decision = 0;
        continue % springe zum n�chsten Trial, wenn keine �nderung der 
                 % Reizst�rke erfolgt
    elseif N_C >= N_bu
            decision = -1; % Verminderung
    elseif N_C <= N_bl
            decision = +1; % Erh�hung
    end       
       
    
    
    
    %----------------------------------------------------------------------
    % Regeln zur �nderung der Schrittweite
    %----------------------------------------------------------------------
  
    %  *** Findlays 1. Modifikation:
    % erreicht T den Wert M oder jedes ganzzahlige Vielfache davon, 
    % so wir ner um 1 erh�ht *** 
    ner = ner + floor(T/M);    
    
    % 1. Bei jeder Richtungsumkehr erfolgt eine Halbierung der
    % Schrittweite, d.h. 'ner' (number of effective reversals) erh�ht sich
    % um 1
    
       
    if (latest_change ~= 0) && (latest_change ~= decision)
        
        % hat es vor dieser Richtungsumkehr eine Verdopplung der Reizst�rke
        % gegeben? (bedeutsam f�r Regel 4)
        if doubling == 1 
            rule4 = 1;   % ja
        else 
            rule4 = 0;   % nein
        end
        
        ner = ner + 1; % Halbierung der Schrittweite
        nstep = 0; % Zur�cksetzen des Z�hlers der Schritte in eine Richtung
        doubling = 0;
    end

    nstep = nstep + 1;
    
    % 2. Im zweiten Schritt in eine gegebene Richtung bleibt die Schritt-
    % weite und somit auch 'ner' unver�ndert.
    
    if nstep == 2
        doubling = 0;
    end
    
    % 3. Der vierte und die darauf folgenden Schritte in eine gegebene 
    % Richtung sind jeweils doppelt so gro� wie der ihnen vorher gehende.
    
    if nstep >= 4
        ner = ner - 1;
        doubling = 1;
    end
    
    % 4. Die Gr��e des dritten Schrittes in eine gegebene Richtung h�ngt von
    % den Schritten ab, welche zur letzten Richtungsumkehr f�hrten: Wenn der
    % Schritt, welcher dieser vorausging, aus einer Verdopplung der Schritt-
    % weite hervorgegangen war, dann wird die Schrittweite nicht verdoppelt
    % (sondern beibehalten). Falls dieser allerdings nicht das Ergebnis ei-
    % ner Verdopplung war, so wird die Schrittweite verdoppelt.
    
    if nstep == 3
        if rule4 == 1 % es hat eine Verdopplung gegeben
             % Schrittweite wird beibehalten
            doubling = 0;
        else % es hat keine Verdopplung gegeben
            ner = ner - 1; % die Schrittweite wird verdoppelt
            doubling = 1;
        end
    end
    
    
    latest_change = decision; % Setze den Indikator f�r die Richtungsumkehr


    %----------------------------------------------------------------------
    % Berechnung der aktuellen Schrittweite dx
    %----------------------------------------------------------------------
    dx = dx_ini/(2^ner);

   % Begrenzung der Schrittweite durch die maximale Schrittweite dx_max
    if dx > dx_max
        dx = dx_max;
    end

    %----------------------------------------------------------------------
    % Terminierung ja/nein?
    %----------------------------------------------------------------------

    if dx < 1
        termflag = 1;
    else
        termflag = 0;
        dx = round(dx); % soll den Fall abfangen, dass keine Zweierpotenz 
                        % f�r dx_ini bzw. dx_max eingegeben wurde
    end

    %----------------------------------------------------------------------
    % Berechnung des n�chsten Reizst�rkenwertes
    %----------------------------------------------------------------------

    if decision == 1 % Erh�hung der Reizst�rke
    x_next = x_hist(trial) + dx;
        if x_next >= range
            x_next = range; % Setze auf Rand, wenn Rand erreicht/�berschritten
            nstep = 0; % Am Rand werden die Schritte nicht weitergez�hlt, 
                       % sodass keine Verdopplungen der Schrittweite
                       % resultieren
        end
    end
   
    if decision == -1 % Erniedrigung der Reizst�rke
    x_next = x_hist(trial) - dx;
        if x_next <= 1 
            x_next = 1;
            nstep = 0; % s.o.
        end
    end    

    
end


%----------------------------------------------------------------------
% Ausgabe der abschlie�enden Schwellensch�tzung (falls terminiert)
%----------------------------------------------------------------------
    
if termflag == 1
    x_est = x_next;
else
    x_est = 0;
end
