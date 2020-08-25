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
% Date   :   24-Oct-2008
% Updated:   25-Oct-2008 20:00 Ciba, calculation of CI now done as suggested
%                                    by Treutwein (1995, eq. 23) + comments
%            17-Nov-2008 00:20 Ciba, metadata/comments, minor changes (no 
%                                    effect on output), values of parameter
%                                    averagetype changed
%            26-Nov-2008 01:00 Ciba, independence of statistic toolbox (call
%                                    of function 'normpdf' removed)
%            
% =========================================================================
%
% This is an implementation of the adaption and estimation mechanism of a
% maximum likelihood/bayesian adaptive procedure based on the Best-PEST
% procedure by Lieberman & Pentland (1982). The algorithm includes some ex-
% tensions: at first it uses no logarithmised Likelihood but one normalised
% to the area beneath the graph. Furthermore averaging (which affects both
% the next stimulus'placement and the final estimation of the threshold) 
% can be performed using two different methods. These are either the max-
% imum-likelihood-method or a bayesian approach using the mean of the
% a-posteriori distribution (i.e. the normalized likelihood) (cp. King-Smith
% et. al., 1994). Also the initialization of the procedure is possible either
% by using implicit trials (original way), assuming a gaussion a priori 
% density (cp. Watson & Pelli, 1983) or a non-informative uniform (rectangular)
% one. Prior information may be excluded from the calculation of the final 
% estimate - if desired. Termination can be achieved either by a fixed 
% number of trials (original) or by setting an upper limit for the confidence
% interval of the final estimate (cp. Treutwein, 1995, 1997). For a compre-
% hensive description of the different features one is directed to 
% Treutwein (1995).
% 
%
% bibliography:
%
% Lieberman, H.; Pentland, A. (1982). Microcomputer-based estimation of 
% psychophysical thresholds: The Best PEST. Behavioral Research Methods & 
% Instrumentation, 14, Nr. 1, S. 21–25.
%
% King-Smith, P. E.; Grigsby, S. S.; Vingrys, A. J.; Benes, S. C.; Supowit, 
% A. (1994). Efficient and Unbiased Modifications of the QUEST Threshold 
% Method: Theory, Simulations, Experimental Evaluation and Practical Imple-
% mentation. Vision Research, 34, Nr. 7, S. 885–912.
%
% Treutwein, B. (1995). Adaptive Psychophysical Procedures. Vision Research,
% 35, Nr. 17, S. 2503–2522.
%
% Treutwein, B. (1997). YAAP: yet another adaptive procedure. Spatial Vision,
% 11, Nr. 1, S. 129–134.
% 
% Watson, A. B.; Pelli, D. (1983). QUEST: A Bayesian adaptive psychometric 
% method. Perception & Psychophysics, 33, Nr. 2, S. 113–120.
% 
% -------------------------------------------------------------------------
%
% [x_next, x_est, finalLike] =
%
% MLBayes(x_hist, r_hist, range, psyfunctype, beta, lambda, n_or_gamma, epsilon, priortype, mu, sigma, A, B, t, C, averagetype, exclude, termtype, ConCoeff, CI_max)
% 
% -------------------------------------------------------------------------
%
% Ausgabe:
%   x_next (Integer): Reizstärkenwert für die Darbietung im nächsten Trial.
%   x_est (Integer/
%          Double) :  Abschließende Schätzung der Schwelle auf Basis der 
%                     Reizstärken in x_hist, zugehörigen Antworten in r_hist
%                     und ggf. A-priori-Information (vgl. exclude).
%                     -> Für x_est = 0 wurde das Verfahren noch nicht ter-
%                     miniert. 
%
% Eingabe: 
%   x_hist (Integer-Array): enthält die Reizstärkenwerte sämtlicher bisher
%                           dargebotener Stimuli
%   r_hist (Integer-Array): enthält die zugehörigen Antworten 
%                           (+1: positiv, -1: negativ)
%   range (Integer): legt den Wertebereich [1:range] der
%                    Reizstärke fest. Die minimale Schrittweite ist mit 1 
%                    vorgegeben.
%
%   psyfunctype (Integer):
%
%   beta (Double):   Spread-Parameter beta
%
%   lambda (Double): Lapsing-Rate (aus [1 - gamma])
%
%   n_or_gamma (Integer or double): Festlegung des Antwortparadigmas 
%                                   (Werte größer gleich 2:  Anzahl n der 
%                                   Intervalle beim nAFC-Paradigma,
%                                   Werte aus [0, 1]: "False-Alarm-Rate" 
%                                   (gamma) für ja/nein-Paradigma.)
%                   Hinweis: im ersten Fall (nAFC-Paradigma) wird gamma
%                   ("guessing rate") auf 1/n gesetzt (s. Code)
%    
%   epsilon (Double):
%
%   priortype: Gibt an, auf welche Art A-priori-Information berücksichtigt 
%              werden soll. Mögliche Werte sind:
%                    1: implizite Trials nach Lieberman & Pentland (1982),
%                    2: gaussförmige Dichte,
%                    sonst: "non-informative prior", d.h. konstante/recht-
%                    eckförmige Dichte, erste Reizdarbietung in der Mitte.
%
%   mu    (Double):  Mittelwert der gaussförmigen a-priori-Likelihood
%   sigma (Double):  Standardabweichung der gaussförmigen a-priori-Likelihood
%   -> mu und sigma werden nur benötigt, falls priortype == 2. Sonst genügen
%      Dummy-Werte.
%
%   A (Double): insgesamte Höhe der hyp. PDF (interagiert mit B und C).
%
%   B (Double): Steigung des unteren Abschnitts der hyp. PDF.
% 
%   t (Double): 'Thresholdwahrscheinlichkeit der hyp. PDF (verschiebt diese
%               entlang der x-Achse).
%
%   C (Double): Steigung des oberen Abschnitts der hyp. PDF.
%
%   averagetype: Gibt an, nach welcher Methode die Mittelwertbildung
%                erfolgt: 1: Modalwert (Maximum-Likelihood-Methode), 2: 
%                arithmetischer Mittelwert.
%
%   exclude: Gibt an, ob A-priori-Information von der Berechnung der
%            abschließenden Schätzung ausgeschlossen werden soll. Mögliche
%            Werte: 1: Ausschluss, sonst: kein Ausschluss
%   termtype: Gibt an, auf welche Weise das Verfahren terminiert wird.
%             Mögliche Werte sind: 0: Terminierung per vorgegebenem Konfi-
%             denzintervall, ganzzahlige Werte größer als 1: Terminierung 
%             nach einer fest vorgegebenen Anzahl an Trials. Diese
%             entspricht dann gleichzeitig dem Wert dieses Parameters (!).
%   ConCoeff (Double): Konfidenzkoeffizient. Werte aus [0, 1] zulässig.
%   CI_max (Double)  : Obere Schranke für das Konfidenzintervall, bei deren
%                      Erreichen bzw. Unterschreiten das Verfahren terminiert
%                      wird. Werte müssen positiv und sollten sinnvoller
%                      Weise ganzzahlig sein. 
%   -> ConCoeff und CI_max müssen nur übergeben werden, falls termtype == 0.
%
% -------------------------------------------------------------------------
%
% Hinweis: Den Anfangswert des Reizstärkenindex x erhält man, indem man die
% Funktion aufruft und für x_hist und r_hist leere Vektoren, d.h. x_hist=[]
% und r_hist=[] übergibt.
%
%--------------------------------------------------------------------------


function [x_next, x_est, finalLike] = MLBayes(x_hist, r_hist, range, psyfunctype, beta, lambda, n_or_gamma, epsilon, priortype, mu, sigma, A, B, t, C, averagetype, exclude, termtype, ConCoeff, CI_max)


% Parameter
Ntrials=length(x_hist); % Anzahl aller bisherig tatsächlich durchgeführten 
                        % Trials
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

% Initialsierung
PosProb = zeros(range, 1); % Vektor für die Wahrscheinlichkeit einer positi-
                           % ven Antwort
cleanLike = ones(range, 1); % "saubere" Likelihood-Funktion als Rechteckver-
                            % teilung
aprioriLike = ones(range, 1); % Initialisierung der a-priori-Likelihood als 
                            % Rechteckverteilung (zunächst)
x_est = 0; % Abschließende Schätzung

% Berechnung der psychometrischen Funktion und Speicherung in einem Vektor
PsyFunc = zeros(2*range, 1);  

x=1:2*range;
switch psyfunctype 
    case 1 % Logistische Funktion
        PsyFunc = gamma + ((1-gamma-lambda)./(1+exp(-(x-range)/beta))); 
        
    case 2 % Weibull Funktion
        PsyFunc = 1 - lambda - ((1-gamma-lambda)./(exp(10.^((beta/20)*(x-range+epsilon))))); 
end
% Weibull-Funktion



%--------------------------------------------------------------------------
% A-priori-Information
%--------------------------------------------------------------------------

switch priortype 
    
    case 1 % 1. Variante: Initialisierung per impliziter Trials nach 
           % Lieberman & Pentland (1982)
        
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
            % positive Antwort bei Darbietung x_im(i) unter Annahme verschiedener  
            % Schwellen theta = x, für x aus [1:range]
 
            PosProb(1:range) = PsyFunc(range+x_im(i)-1:-1:x_im(i));
    
            % Berechnung für negative Antwort
            NegProb = 1 - PosProb;
    
            if r_im(i)==1  %falls positive Antwort
                aprioriLike = aprioriLike.*PosProb;
            else    %falls negative Antwort
                aprioriLike = aprioriLike.*NegProb;
            end
            % Normierung auf Maximum
            aprioriLike = aprioriLike/max(aprioriLike);
            
    
        end
   
     
    case 2 % 2. Variante: Initialisierung des Verfahrens per Annahme einer 
           % Gauss-Funktion für die A-priori-Likelihood (vgl. z.B. QUEST)
        
        % Berechnung der A-priori-Likelihood als eine auf ihr Maximum normierte 
        % Normalverteilungsdichte
        x=1:range;
        temp = exp(-0.5 * ((x - mu)./sigma).^2);
        aprioriLike = temp'; 
    
    case 4 % Die PDF entspricht einer "modifizierten hyperbolischen Sekante" 
           % (siehe King-Smith et. al. 91, ZEST)
        
        x=1:range;
        temp = A ./ ((B*exp(-C*(x-t))) + (C*exp(B*(x-t))));
        aprioriLike = temp';
   
    
    otherwise % 3. Variante: Initialisierung des Verfahrens per Gleichverteilung
        % - kein weiterer Code nötig -
    
end

            
%--------------------------------------------------------------------------
% Berechnung der Likelihood-Funktion(en)
%--------------------------------------------------------------------------
                        

%                            **************

% Berechnung der "sauberen" Likelihood-Funktion, welche ausschließlich auf
% den tatsächlich durchgeführten Trials beruht

for i=1:Ntrials     
    % Berechnung des Vektors mit den Auftretenswahrscheinlichkeiten für eine 
    % positive Antwort bei Darbietung x_hist(i) unter Annahme verschiedener  
    % Schwellen theta = x, für x aus [1:range]
 
    PosProb(1:range) = PsyFunc(range+x_hist(i)-1:-1:x_hist(i));
    
    % Berechnung für negative Antwort
    NegProb = 1 - PosProb;
    
    if r_hist(i)==1  %falls positive Antwort
        cleanLike = cleanLike.*PosProb;
    else    %falls negative Antwort
        cleanLike = cleanLike.*NegProb;
    end
        
    % Normierung auf die Fläche unter dem Funktionsgrafen
    cleanLike = cleanLike/sum(cleanLike);
    
end


%                            **************

% Berechnung der gesamten Likelihood-Funktion, welche auch
% die a-priori-Information mit einschließt

Like = aprioriLike.*cleanLike;
Like = Like/sum(Like); % Normierung auf die Fläche unter dem Funktions-
                       % grafen

                       
%                            **************
                       
% Berechnung der Likelihood-Funktion, welche für die abschließende
% Schätzung der Schwelle verwendet werden soll

if exclude == 1
    finalLike = cleanLike;
else
    finalLike = Like;
end
finalLike = finalLike/sum(finalLike); % Normierung auf die Fläche unter dem
                                      % Grafen                         

% -------------------------------------------------------------------------
% Berechnung des nächsten Reizstärkenwertes x_next
%--------------------------------------------------------------------------    

switch averagetype
    
    
    case 1 % Maximum-Likelihood-Methode
                                     
        % wähle den (oder die) Stimulus/-i im Maximum der Likelihood-Funktion
        x_ml = find( Like ==  max( Like ) );
        % wähle einen Stimulus bei Gleichwahrscheinlichkeit mehrerer Alternativen
        x_next = round(mean(x_ml));

    case 2 % Arithmetischer Mittelwert
        
        x=1:range;
        x_mean = sum(x' .* Like);
        x_next = round(x_mean);
    otherwise
        error('You have choosen an invalid averaging method');

        
end
        
       
% -------------------------------------------------------------------------
% Terminierung
%--------------------------------------------------------------------------                       

if termtype == 0 % Terminierung wenn eine vorgegebene obere Grenze für das
                 % Konfidenzintervall unterschritten wurde
                 
% Die folgende Berechnung des aktuellen Konfidenzintervalls erfolgt wie be-
% schrieben bei Treutwein, 1995, Gl. 23 und umgesetzt im Modula-2-Code zu 
% YAAP, YAAP_mod.odc, 1993/12/01, Prozedur "ProbabilityInterval" 
                 
    i_low=1; % Index für Summation entspr. des "unteren Integrals"
    i_up=range; % Index Summe "oberes Integral"
    lowerProb = 0;
    upperProb = 0;
    k = (1 - ConCoeff)/2;
    while (  ( lowerProb < k ) || ( upperProb < k )  ) && (i_low <= i_up)
        if lowerProb < k
            lowerProb = lowerProb + finalLike(i_low);
            i_low = i_low + 1;
        end
        if upperProb < k
            upperProb = upperProb + finalLike(i_up);
            i_up = i_up - 1;
        end
    end
    
    CI = i_up - i_low;
    
    if CI <= CI_max
        termflag = 1;
    else
        termflag = 0;
    end
    
    
elseif termtype >= 1 % Terminierung nach einer vorgegebenen Anzahl an Trials
    
    if length(x_hist) == termtype
        termflag = 1;
    else
        termflag = 0;
    end
else
    error('You have cosen an invalid value for termtype');
end


% -------------------------------------------------------------------------
% Berechnung der abschließenden Schätzung x_est
%--------------------------------------------------------------------------
if termflag == 1
    switch averagetype
    
        case 1 % Maximum-Likelihood-Methode
        
        
            % wähle den (oder die) Stimulus/-i im Maximum der Likelihood-Funktion
            x_ml = find( finalLike ==  max( finalLike ) );
            % wähle einen Stimulus bei Gleichwahrscheinlichkeit mehrerer Alternativen
            x_est = round(mean(x_ml));
        
        case 2 % Arithmetischer Mittelwert
        
            x=1:range;
            x_mean = sum(x' .* finalLike);
            x_est = x_mean;
    end
        
end
