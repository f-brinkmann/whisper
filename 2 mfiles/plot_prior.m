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
% Updated:   26-Nov-2008 01:00 Ciba, independence of statistic toolbox (call
%                                    of function 'normpdf' removed),
%            24-Mai-2010 Herder, Plotting for mod. hyp. PDF added.
%                   
%
% =========================================================================
%
% Die Funktion plottet die A-priori-Likelihood-Funktion für drei
% verschiedene Varianten der Initialisierung (siehe priortype)
%
% -------------------------------------------------------------------------
%
% function []=plot_prior(range, n_or_gamma, psyfuntype, priortype, beta, lambda, epsilon, mu, sigma, A, B, t, C)
%
% Eingabe:
%   range (Integer): Legt den Bereich [1, range] der Abszissenachse 
%                    (Reizstärke) fest. Dieser wird in Schritten von 1
%                    aufgelöst.
%   n_or_gamma (Integer/Double): Festlegung des Antwortparadigmas (Werte 
%                             größer oder gleich 2: Anzahl n der Intervalle
%                             beim nAFC-Paradigma, Werte aus [0, 1]: "False-
%                             Alarm-Rate" gamma für ja/nein-Paradigma).
%                   Hinweis: im ersten Fall (nAFC-Paradigma) wird gamma
%                   ("guessing rate") intern auf 1/n gesetzt (s. Code)
%
%   psyfuntype: gibt an, welche psychometrische Funktion (für die Berechnung
%               der Apriori-PDF anhand impliziter Trials) verwendet werden
%               soll: 1: Logistische Funktion, 2: Weibull-Verteilung
%
%   priortype: gibt an, nach welchem Verfahren die a-priori-Likelihood
%              berechnet werden soll; 1: implizite Trials nach Lieberman & 
%              Pentland (1982), 2: Gaussförmige Verteilung (vgl. Watson & 
%              Pelli, 1983), 3 (bzw. sonst): Gleichverteilung (siehe 
%              Treutwein, 1995), 4: Modifizierte hyperbolische PDF (siehe
%              ....)
%              
%
%   beta (Double): Spread-Parameter.
%
%   lambda (Double): Lapsing-Rate (aus [0, 1-gamma]).
%
%   epsilon (Double): Thresholdkorrekturfaktor der Weibull-Funktion.
%
%   mu (Double)  : Mittelwert der gaussförmigen a-priori-Likelihood
%   sigma (Double): Standardabweichung der gaussförmigen a-priori-Likelihood
%
%   !! mu und sigma müssen nur übergeben werden, falls priortype == 2 (vgl.
%   oben)!!
%   
%   A (Double)   : insgesamte Höhe der hyper. PDF
%
%   B (Double)   : Steigung des "unteren" Abschnitts der hyp. PDF
%
%   t (Double)   : Wahrscheinlichkeit des Threshold der hyp. PDF
%
%   C (Double)   : Steigung des "oberen" Abschnitts der hyp. PDF
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function []=plot_prior(range, n_or_gamma, psyfuntype, priortype, beta, lambda, epsilon, mu, sigma, A, B, t, C)

% Initialsierung der Variablen
PosProb = zeros(range, 1); % Initialisierung des Vektors für die Wahrschein-
                           % lichkeit einer positiven Antwort
aprioriLike=ones(range, 1); % Initialisierung der a-priori-Likelihood
                            % als Gleichverteilung (zunächst)

                            
% Welches Antwortparadigma liegt vor? Wie groß ist dementsprechend die
% Ratewahrscheinlichkeit/False-Alarm-Rate GAMMA zu wählen?
if (n_or_gamma >=0) && (n_or_gamma <=1) % ja/nein-Paradigma
    paradigm = 0;
    gamma = n_or_gamma;
elseif (n_or_gamma >=2) % nAFC-Paradigma
    paradigm = 1;
    n = n_or_gamma;
    gamma = 1/n;
else
    error('You have cosen an invalid response paradigm');
end                            

switch priortype
    
    case 1
        % 1. Variante: Initialisierung per impliziter Trials nach Lieberman & Pent-
        % land (1982)

        % Berechnung der psychometrischen Funktion und Speicherung in einem Vektor
        PsyFunc = zeros(2*range, 1);  
        
        x=1:2*range;
        switch psyfuntype            
            case 1 %logistische            
                PsyFunc = gamma + ((1-gamma-lambda)./(1+exp(-(x-range)/beta))); 
                
            case 2 %Weibull
                PsyFunc = 1 - lambda - ((1-gamma-lambda)./(exp(10.^((beta/20)*(x-range+epsilon)))));
        end
    
        % Definition der impliziten Trials   
            if paradigm == 0 % ja/nein-Paradigma
                x_im(1)=1;
                r_im(1)=-1;
                x_im(2)=range;
                r_im(2)=+1;
            end

            if paradigm == 1 % nAFC-Paradigma
                for i=1:n
                    x_im(i)=1;
                    r_im(i)=-1;
                end
                r_im(1)=+1; % genau eine positive Antwort
            end

        % Berechnung der a-priori-Likelihood
            for i=1:length(x_im)    
            % Berechnung des Vektors mit den Auftretenswahrscheinlichkeiten für eine 
            % positive Antwort bei Darbietung x_ini(i) unter Annahme verschiedener  
            % Schwellen theta = x, für x aus [1:range]

                PosProb(1:range) = PsyFunc(range+x_im(i)-1:-1:x_im(i));

            % Berechnung für negative Antwort
                NegProb = 1 - PosProb;

                if r_im(i)==1  %falls positive Antwort
                    aprioriLike = aprioriLike.*PosProb;
                else    %falls negative Antwort
                    aprioriLike = aprioriLike.*NegProb;
                end

            % Normierung auf das Maximum
                aprioriLike = aprioriLike/max(aprioriLike);

            end



    case 2
        % 2. Variante: Initialisierung des Verfahrens per Annahme einer 
        % Gauss-Funktion für die A-priori-Likelihood (vgl. z.B. QUEST)

           % Berechnung der A-priori-Likelihood als eine auf ihr Maximum normierte 
           % Normalverteilungsdichte
           x=1:range;
           temp = exp(-0.5 * ((x - mu)./sigma).^2);
           aprioriLike = temp';
        
    case 4
        % 3. (!) Variante (gemäß der Reihenfolge im GUI, codiert als
        % priortype=4 wg. Kompatibilität zu älteren Whisper-Messungen):
        % modifizierte hyperbolische PDF (z.B. bei ZEST)
        
            x=1:range;
            temp = A ./ ((B.*exp(-C.*(x-t))) + (C.*exp(B.*(x-t))));
            aprioriLike = temp';        
        
    otherwise
        % 3. Variante: Initialisierung des Verfahrens per Gleichverteilung
        % - kein weitere Code nötig - 
        
end

figure;
plot(aprioriLike, 'LineWidth', 1.5);
grid on
title('a-priori Likelihood', 'FontSize', 10);
axis([1 range 0 1.05]);
xlabel('stimulus intensity x');
ylabel('L_p_r_i_o_r(x)');
