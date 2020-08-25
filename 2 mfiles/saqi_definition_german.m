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
% Author :   Martina Vrhovnik and Fabian Brinkmann,
%            Audio Communication Group, TU Berlin
% Email  :   fabian.brinkmann at tu-berlin dot de
% Date   :   Oct. 2013
% Updated: 
%             
% =========================================================================

SAQI_definition = ...
    {...
    1 'Existenz eines wahrnehmbaren Unterschieds.';...
    2 ['Klangeindruck, der durch das Verh' char(228) 'ltnis hoher zu tiefer Frequenzanteile bestimmt wird.'];...
    3 ['Klangliche Ver' char(228) 'nderungen in einem begrenzten Frequenzbereich.'];...
    4 ['Klangliche Ver' char(228) 'nderungen in einem begrenzten Frequenzbereich.'];...
    5 ['Klangliche Ver' char(228) 'nderungen in einem begrenzten Frequenzbereich.'];...
    6 {['Klangeindruck, der z.B. auf den Kraftaufwand schlie' char(223) 'en l' char(228) 'sst, mit dem eine Klangquelle angeregt wird.'];...
      'Beispiele:';... 
      '- hart/weich angeschlagene Perkussionsinstrumente';... 
      '- hart/weich gezupfte Saiteninstrumente (klassische Gitarre, Harfe)';...
      ['- Eine ' char(220) 'berbetonung hoher Frequenzen kann einen "scharfen" Klangeindruck f' char(246) 'rdern.']};...
    7 {'Klangeindruck heftiger oder aggressiver Modulation/Vibration,';...
       'wobei Einzelschwingungen kaum mehr unterscheidbar sind.';... 
       'Oft als unangenehm bewertet.'};...
    8 {'Oft tonal wirkende Klangverfrbung. "Hohler" Klang.';... 
      'Beispiel: Sprechen durch ein Rohr.'};...
    9 {['Klangverf' char(228) 'rbung, die von schmalbandig-resonierenden Anteilen gepr' char(228) 'gt ist, h' char(228) 'ufig als Resultat einer geringen Eigenfrequenzdichte.'];... 
      ['H' char(228) 'ufig bei Anregung von metallenen Gegenst' char(228) 'nden wie z.B. Gongs, Glocken, scheppernde Blechdosene h' char(246) 'rbar.'];... 
      'Anwendbar auch auf Raumsimulationen, Plattenhall, Hallfolie u..'};...
    10 {['Wahrnehmbarkeit einer Tonh' char(246) 'he in einem Klang.'];... 
       'Beispiele tonhaltiger Signale:';... 
       '- Stimmhafte Sprachanteile,';... 
       ['- Piept' char(246) 'ne.']};...
    11 ['Die Tonh' char(246) 'henwahrnehmung erlaubt die Anordnung tonhaltiger Signale entlang einer Skala: "h' char(246) 'her - tiefer".'];...
    12 {['Ver' char(228) 'nderung der Tonh' char(246) 'he. Oft als "kontinuierliche Verstimmung" wahrgenommen.'];... 
       'Beispiel: "Verstimmter" Klang der Sirene eines schnell vorbeifahrenden Krankenwagens.'};...
    13 'Richtung von Schallquellen in der Horizontalebene.';...
    14 'Richtung von Schallquellen in der Vertikalebene.';...
    15 {['Meint nur die Lage vor bzw. hinter dem H' char(246) 'rer.'];... 
        ['Eindruck des Positionsunterschieds einer Schallquelle, der bei Positionsspiegelung an der durch den H' char(246) 'rer gehend gedachten Frontalebene zustande kommt.']};...
    16 'Wahrgenommene Distanz einer Schallquelle.';...
    17 'Wahrgenommene Ausdehnung einer Schallquelle in radialer Richtung.';...
    18 'Wahrgenommene Ausdehnung einer Schallquelle in horizontaler Richtung.';...
    19 'Wahrgenommene Ausdehnung einer Schallquelle in vertikaler Richtung.';...
    20 {['Beschreibt die Deutlichkeit, mit der eine Schallquelle - unabh' char(228) 'ngig von ihrer Distanz - innerhalb oder auerhalb des Kopfes wahrgenommen wird.'];... 
        ['Fachlich oft auch zwischen Ph' char(228) 'nomenen "Im-Kopf-Lokalisation" und "Au' char(223) 'er-Kopf-Lokalisation" eingegrenzt.'];... 
        'Beispiele:';... 
        ['- Schlecht/nicht externalisiert = wahrgenommener Schallquellenort bei diotischer Schallpr' char(228) 'sentation per Kopfh' char(246) 'rer;'];... 
        ['- Gut/stark externalisiert = wahrgenommener Schallquellenort beim H' char(246) 'ren einer nat' char(252) 'rlichen Schallquelle in nachhallbehafteter Umgebung unter Zulassen von Bewegungen des H' char(246) 'rers.']};...
    21 {['Bei geringer Lokalisierbarkeit sind r' char(228) 'umliche Ausdehnung und Ort einer Schallquelle schlecht absch' char(228) 'tzbar bzw. erscheinen diffus.'];... 
        'Bei hoher Lokalisierbarkeit erscheint eine Schallquelle dagegen klar umgrenzt.';... 
        ['Geringe bzw. groe Lokalisierbarkeiten gehen oft mit gro' char(223) 'er bzw. geringer wahrgenommener Ausdehnung einer Schallquelle einher.'];... 
        'Beispiel: Schallquellen in stark diffusen Schallfeldern sind schlecht lokalisierbar.'};...
    22 {['Schallquellen, die erfahrungsgem eine einheitliche r' char(228) 'umliche Gestalt haben sollten, erscheinen r' char(228) 'umlich separiert.'];... 
        ['M' char(246) 'gliche Ursache:'];... 
        ['Teile der Schallquelle werden verschiedentlich synthetisiert/simuliert und zwischen den Syntheseverfahren/-engines besteht ein f' char(228) 'lschlicher oder ungewollter Versatz bzgl. r' char(228) 'umlicher Parameter.'];... 
        'Beispiele:';... 
        ['- Griffger' char(228) 'usche und T' char(246) 'ne einer Instrumentenquelle kommen nicht vom selben Ort'];... 
        ['- Frikative und Vokale eines Sprechers werden getrennt synthetisiert und dann f' char(228) 'lschlich r' char(228) 'umlich versetzt wiedergegeben']};...
    23 {['Wahrnehmung starker Raumanteile, ausgel' char(246) 'st durch ein hohes Verh' char(228) 'ltnis von reflektierter zu direkter Schallenergie. F' char(252) 'hrt bei stationrer Anregung zum Eindruck hoher Diffusit' char(228) 't (im Sinne eines geringen D/R-Ver' char(228) 'hltnisses).'];... 
       ['Beispiel: Die empfundene Nachhallst' char(228) 'rke unterscheidet sich wesentlich zwischen eher kleinen und sehr gro' char(223) 'en R' char(228) 'umen, wie z.B. zwischen Wohnzimmern und Kirchen.']};...
    24 ['Dauer des Nachhall-Ausklangvorgangs. Vor allem am Ende von Signalen h' char(246) 'rbar.'];...
    25 {['Wahrnehmung des "vom-Nachhall-r' char(228) 'umlich-umh' char(252) 'llt-Seins". Bei hoher Nachhallumhllung kann dem Nachhall nur schwer ein spezifischer Ort, eine begrenzte Ausdehnung oder eine Vorzugsrichtung zugewiesen werden. Eindrcke eher niedriger bzw. eher hoher Nachhallumh' char(252) 'llung entstehen z.B. bei diotisch vs. dichotisch (z.B. dekorreliert) pr' char(228) 'sentiertem verhallten Material.']};...
    26 'Kopien von Schallquellen mit meist geringerer Lautheit bereits vor Beginn des eigentlich intendierten Klangeinsatzes.';...
    27 {'Kopien von Schallquellen mit meist abnehmender Lautheit nach Beginn des eigentlich intendierten Klangeinsatzes.';... 
       ['Beispiel: Wiederholung der eigenen Stimme durch Reflektion an Gebirgsw' char(228) 'nden.']};...
    28 {['Objekte, die erwartungsgem' char(228) char(223) ' eine einheitliche zeitliche Gestalt haben, erscheinen zeitlich separiert. Ursache analog zu "r' char(228) 'umliches Zerfallen", nur: hier zeitliche Vers' char(228) 'tze bei Synthese.'];... 
        ['Beispiel: Griffger' char(228) 'usche und T' char(246) 'ne einer Instrumentenquelle kommen nicht zur selben Zeit.']};...
    29 {['Eigenschaft, die durch die Impulstreue von Systemen beeinflusst wird. Wahrnehmung des Verlaufs von Einschwingvorg' char(228) 'ngen. K' char(246) 'nnen im Vergleich weicher/verschliffener/weniger pr' char(228) 'zise, aber auch umgekehrt schneller/pr' char(228) 'ziser/exakter sein.'];... 
        ['Beispiel f' char(252) 'r "verschliffenere" Transienten: Ein ' char(220) 'bertragungssystem, das starke Gruppenlaufzeitverzerrungen einf' char(252) 'gt.'];... 
        'Gegenbeispiel: Ergebnis einer auf Linearphasigkeit abzielenden Phasenentzerrung.'};...
    30 {['Eine Szene l' char(228) 'uft inhaltlich & klanglich identisch aber offensichtlich schneller oder langsamer ab. Muss nicht mit Tonh' char(246) 'hen' char(228) 'nderung einhergehen.'];... 
        'Beispiele technischer Ursachen:';... 
        '- Umdrehungsgeschwindigkeit';... 
        '- Sample Rate Conversion';... 
        '- Time Stretching';...
        ['- Ver' char(228) 'nderte Pausen zwischen Signaleins' char(228) 'tzen'];... 
        ['- Bewegungen laufen mit ver' char(228) 'nderter Geschwindigkeit ab']};...
    31 {'Reihenfolge oder Auftreten von Szenekomponenten.';... 
        ['Beispiel: Ein Hund bellt pl' char(246) 'tzlich am Schluss, anstatt - wie in der Referenz - zu Beginn.']};...
    32 ['Eigenschaft, die durch Latenzen im System beeinflusst wird. Zur Unterscheidung von einerseits mehr, andererseits weniger verz' char(246) 'gerten Reaktionen der Wiedergabeumgebung auf Nutzerinteraktionen.'];...
    33 {['Wahrgenommene Lautst' char(228) 'rke einer Schallquelle. Verschwinden von Objekten ist durch Lautheit = 0 abbildbar.'];... 
        ['Beispiel eines Lautheitsgegensatzes: Fl' char(252) 'stern vs. Schreien.']};...
    34 ['Gr' char(246) char(223) 'e der Lautheitsunterschiede zwischen lauten und leisen Passagen. Bei Signalen geringerer Dynamik unterscheiden sich laute und leise Passagen weniger von der durchschnittlichen Lautheit. Dagegen enthalten Signale mit hoher Dynamik sowohl sehr laute als auch sehr leise Passagen.'];...
    35 {['Klangver' char(228) 'nderungen jenseits des langfristigen Lautheitsverlaufs. Sammelkategorie f' char(252) 'r eine Vielzahl von durch Dynamikkompression hervorgerufenen Perzepten.'];...
        ['Beispiele: Kompakterer Klang eines summenkomprimierten Musiktracks gegen' char(252) 'ber dem unbearbeiteten Original.'];... 
        ['"Kompressorpumpen": Bei Signalenergiespitzen (Bassdrumeinstze, Plosivlaute) f' char(228) 'llt die Signallautheit pl' char(246) 'tzlich ab und kehrt nach einer sp' char(252) 'rbaren Zeitspanne wieder auf das vorherige Niveau zur' char(252) 'ck.']};...
    36 {['Ausbildung einer eigenst' char(228) 'ndigen, in der Szene eindeutig nicht intendierten Wahrnehmungsgestalt.'];... 
        ['Beispiel: Ein eindeutig nicht zur pr' char(228) 'sentierten Szene geh' char(246) 'riger St' char(246) 'rton, wie z.B. ein unerwarteter Piepton "aus der Technik".']};...
    37 {['Ausbildung einer eigenst' char(228) 'ndigen, in der Szene eindeutig nicht intendierten Wahrnehmungsgestalt.'];... 
        ['Beispiel: Ein eindeutig nicht zur pr' char(228) 'sentierten Szene geh' char(246) 'riges, kurzes St' char(246) 'rger' char(228) 'usch wie z.B. ein Knacksen "aus der Technik".']};...
    38 {['Ausbildung einer eigenst' char(228) 'ndigen, in der Szene eindeutig nicht intendierten Wahrnehmungsgestalt.'];... 
        ['Beispiel: Ein eindeutig nicht zur pr' char(228) 'sentierten Szene geh' char(246) 'riges Rauschen wie z.B. ein Hintergrundrauschen von L' char(252) 'ftern.']};...
    39 {['Ausbildung einer eigenst' char(228) 'ndigen, in der Szene eindeutig nicht intendierten Wahrnehmungsgestalt.'];... 
        'Beispiele:';... 
        '- ein eingekoppeltes Radiosignal';... 
        '- ein versehentlich nicht "stumm" geschalteter Mischpultkanal'};...
    40 {['R' char(228) 'umlich getrenntes, annhernd gleichzeitiges, nicht unbedingt identisches, Abbild einer Schallquelle.'];... 
        ['Eine Art ' char(246) 'rtliche Signalkopie: Eine Schallquelle taucht an einem oder mehreren zus' char(228) 'tzlichen Orten in der Szene auf.'];... 
        'Beispiele:';... 
        ['- Zwei Schallquellen geben f' char(228) 'lschlich denselben Audioinhalt wieder.'];... 
        ['- Doppelabbildung bei Mischungen mit Haupt-/St' char(252) 'tzmikrofonierung.'];... 
        ['- R' char(228) 'umliches Aliasing bei WFS: Schallquellen werden als richtungsmehrdeutig wahrgenommen.']};...
    41 {['Perzept infolge von nichtlinearen Verzerrungen, wie sie z.B. durch ' char(220) 'bersteuerungen entstehen. Kratziger oder "kaputter" Sound. Oft von Signalamplitude abhngig. Kann seine Qualit' char(228) 't je nach Art der ' char(220) 'bersteuerung stark ' char(228) 'ndern.'];... 
        ['Beispiel: Clipping bei ' char(220) 'bersteuerung von digitalen Eingangsstufen.']};...
    42 {['Wahrnehmung am Grenzbereich zwischen auditiver und taktiler Modalitt. Sp' char(252) 'rbarkeit von Vibrationen, die von einer Schallquelle verursacht werden, z.B. durch mechanische Ankopplung an Auflagef' char(228) 'lchen. '];... 
        'Beispiele:';... 
        '- Livekonzert: Bass "geht in den Magen".';... 
        ['- Kopfh' char(246) 'rerauflagen vibrieren sp' char(252) 'rbar auf Ohren/an Schl' char(228) 'fe.']};...
    43 ['Klarheit/Deutlichkeit beliebiger Szeneninhalte. Eindruck davon, wie klar Szeneninhalte voneinander unterschieden und wie gut verschiedenste Eigenschaften einzelner Szeneninhalte erkannt werden k' char(246) 'nnen. Der Begriff ist also weiter gefasst, als der in der Raumakustik durch das Klarheitsma' char(223) ' pr' char(228) 'dizierte Eindruck einer mit steigender Nachhallenergie sinkenden Transparenz.'];...
    44 {['Eindruck davon, wie gut die Worte eines Sprechers verstanden werden k' char(246) 'nnen.'];... 
        ['Typisch f' char(252) 'r geringe Sprachverst' char(228) 'ndlichkeit: Bahnhofsdurchsagen.'];... 
        ['Typisch f' char(252) 'r hohe Sprachverst' char(228) 'ndlichkeit: Nachrichtensprecher.']};...
    45 'Eindruck, dass ein Signal der Erwartung/Erfahrung an eine solches Signal entspricht.';...
    46 ['"In-der-Szene-Sein" im Sinne r' char(228) 'umlicher Pr' char(228) 'senz. Eindruck in einer pr' char(228) 'sentierten Szene vor Ort, in die Szene r' char(228) 'umlich integriert zu sein.'];...
    47 'Unterschied bzgl. Angenehmheit/Unangenehmheit.';...
    48 'Weiterer, bisher noch nicht erfasster Unterschied.';...
     };