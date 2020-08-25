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
% Date   :   07-Nov-2008
% Updated:   --
%                   
%
% =========================================================================
%
% Die Funktion plottet die Form der psychometrischen Funktion über einen
% gegebenen Range. Die Lage theta ist dabei auf die Mitte des Range 
% (d.h.(1+Range)/2 ) fixiert.
%
% -------------------------------------------------------------------------
%
% function []=plot_psyfunc(psyfuntype, range, n_or_gamma, beta, lambda, epsilon)
%
% Eingabe:
%   psyfuntype: Schaltet zwischen den verschiedenen psychometrischen
%   Funktionen um; 1: logistische, 2: Weibull.
%
%   range (Integer): Legt den Bereich [1, range] der Abszissenachse 
%                    (Reizstärke) fest. Dieser wird in Schritten von 1 
%                    aufgelöst.
%   n_or_gamma (Integer/Double): Festlegung des Antwortparadigmas 
%                                (Werte größer oder gleich 2: Anzahl n der 
%                                Intervalle beim nAFC-Paradigma, Werte aus 
%                                [0, 1]: "False-Alarm-Rate" gamma für 
%                                ja/nein-Paradigma).
%                   Hinweis: im ersten Fall (nAFC-Paradigma) wird gamma
%                   ("guessing rate") auf 1/n gesetzt (s. Code)
%
%   beta (Double): Spread-Parameter.
%   lambda (Double): Lapsing-Rate (aus [0, 1-gamma]).
%   epsilon (Double): Thresholdkorrektur der Weibullfunktion.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function []=plot_psyfunc(psyfuntype, range, n_or_gamma, beta, lambda, epsilon)


% Welches Antwortparadigma liegt vor? Wie groß ist dementsprechend die
% Ratewahrscheinlichkeit/False-Alarm-Rate GAMMA zu wählen?
if (n_or_gamma >=0) && (n_or_gamma <=1) % ja/nein-Paradigma
    gamma = n_or_gamma;
elseif (n_or_gamma >=2) % nAFC-Paradigma
    gamma = 1/n_or_gamma;
else
    error('You have cosen an invalid response paradigm');
end                   


theta = (1+range)/2;
% Berechnung der psychometrischen Funktion und Speicherung in einem Vektor
PsyFunc = zeros(range, 1);    
x=1:range;
switch psyfuntype
    case 1 % logistische
        PsyFunc = gamma + ((1-gamma-lambda)./(1+exp(-(x-theta)/beta)));  
    case 2 % Weibull
        PsyFunc = 1 - lambda - ((1-gamma-lambda)./(exp(10.^((beta/20)*(x-theta+epsilon)))));
end        


figure;
plot(PsyFunc, 'LineWidth', 1.5);
grid on
title('shape of underlying psychometric function', 'FontSize', 10);
axis([1 range 0 1.05]);
xlabel('stimulus intensity x');
switch psyfuntype
    case {1,2}
        ylabel('$\textstyle{\hat{\psi}(x)}$', 'Interpreter', 'LaTex', 'FontSize', 12);
end
