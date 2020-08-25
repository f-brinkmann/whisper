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
% Author :   Matthias Herder, student at FG Audiokommunikation, TU Berlin
% Email  :   mherder AT gmx DOT de
% Date   :   18-May-2010
%
% =========================================================================
%
%
% This file contains a method to iteratively find an optimum value
% "epsilon" of a given Weibull distribution psychometric function (with
% guessing rate gamma, lapsing rate lambda and slope beta provided
% beforehand by the user), so as to for the calculated epsilon to correct
% the psychometric function to have its "ideal sweat factor" (Taylor71) at
% point T, the threshold.
%
% Bibliography:
%
%
%
% =========================================================================
% Usage: 
%   [epsilon, pThreshold] = find_epsilon_for_ideal_sweat_factor (gamma, lambda, beta, range) 
%
%
%
% Output variable(s):
%       epsilon    (double) - The optimized value for epsilon as explained above.
%       pThreshold (double) - probability of answers at the optimized threshold
%
% Input variable(s):
%       gamma   (double)  - "guessing rate" gamma
%       lambda  (double)  - "lapsing rate" lambda
%       beta    (double)  - slope of this here Weibull distribution 
%                   psychometric function
%       (range  (int)     - optional: provide a threshold to calculate with; 
%                  if not provided, this will be initialized to 100. Note: 
%                  Higher values do not seem to yield higher precision in
%                  calculating epsilon.)
%                  
% =========================================================================

function [epsilon,pThreshold] = find_epsilon_for_ideal_sweat_factor (gamma, lambda, beta, range)

% Auflösung (optional) vorgeben (ACHTUNG: Schrittweiten von integer
% 1 sind in allen in dieser Implementation verwendeten Indizes vorausgesetzt 
% und somit obligatorisch!)
if ~exist ('range','var')
    range=100;
end
x = 1:2*range;

% default-Schrittgröße variiert mit der Steilheit der Kurve -> je flacher,
% desto größere initiale Schrittgröße.
if beta < 3.5
    stepsize = 0.01 + (3.5 - beta)/10;
else
    stepsize = 0.01 + ((3.5 - beta)/1000);
end

% Die (später) iterative Schrittgröße ist adaptiv.
plusminus=0.5;

% epsilon mit "0" initialisieren (von hier aus wird später iteriert)
epsilon = 0;

x_ep=x(1)-0.5:x(end)+0.5; %wird später gebraucht, siehe Punkt 1.

targetrange = range;
% Die Schleife läuft mindestens einmal, wiederholt nur, wenn epsilon (nach
% weiter unten durchgeführtem Inkrement/Dekrement) von Null abweicht
done=0;
while ~done
    
    % Psychometrische Funktion (Weibull Verteilung)
    PsyFunc = 1 - lambda - ((1-gamma-lambda)./(exp(10.^((beta/20)*(x-range+epsilon)))));

    % "ideal sweat factor" berechnen
    % 1. Schritt: Da die Matlab-Approximierung der Ableitung (n-1) Elemente einer
    % (n) Elemente enthaltenden Funktion zurückgibt, extrapolieren wir die
    % ursprüngliche PsyFunc vorm Differenzieren auf die zwischen den
    % aktuellen liegenden Werte
    PsyFunc_ep = interp1(x,PsyFunc,x_ep,'cubic');

    % 2.Schritt: Ableitung approximieren
    dPsyFunc = diff(PsyFunc_ep)./diff(x_ep);

    % 3.Schritt: "sweat factor" berechnen
    SweatFac = (PsyFunc.*(1-PsyFunc))./(dPsyFunc.^2);

    % 4.Schritt: "ideal sweat factor" ist dessen Minimum, uns interessiert, wo
    % auf der x-Achse dieser liegt.
    isf_pos = find(SweatFac==min(SweatFac));

    % Wo liegt der "ideal sweat factor" im Vergleich zum x-Ort des Threshold? 
    if isf_pos < targetrange  
        %0.1/(plusminus/2)
        epsilon = epsilon - stepsize;%/(plusminus/2)
        plusminus = plusminus - 2;
        last_direction = 'up';
    elseif isf_pos > targetrange  
        %0.1/(plusminus/2)        
        epsilon = epsilon + stepsize;%/(plusminus/2)
        plusminus = plusminus + 2;
        last_direction = 'down';
    else % i.e. isf_pos == targetrange, das gewünschte Ergebnis, also..
        % ...wenn wir direkt getroffen haben
        if ~exist('last_direction','var')
            epsilon1 = epsilon;
            break
        end
        % Ansonsten: beim 1. Durchlauf nochmal weitersuchen bis nächster Index überschritten
        if targetrange == range
            switch last_direction
                case 'up'
                    targetrange = range + 1;
                case 'down'
                    targetrange = range - 1;
            end
            plusminus = 1;
            epsilon1 = epsilon;
        % beim 2. Erreichen der (neuen) targetrange Schluss
        else
            epsilon2 = epsilon;
            done=1;        
        end
    end    
end


% Approximieren des "wahren" epsilon: arith. Mittel von
% "unterem" und "oberem" epsilon;
epsilon2 = epsilon;
epsilon = (epsilon1 + epsilon2)/2;

% Ausgabe der Antwortwahrscheinlichkeit der psychometr. Funktion am Ort des
% nun mithilfe von epsilon optimierten Threshold
PsyFunc = 1 - lambda - ((1-gamma-lambda)./(exp(10.^((beta/20)*(x-range+epsilon)))));
pThreshold = PsyFunc(range);






