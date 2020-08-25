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

% This script holds all SAQI items and its properties, which are:
% Item id, item name, is_dichotom, is_unipolar, item category,is_degree_scale
SAQI_Items = ...
    {...
    1 'Unterschied'                                                             0 1 0 0;...
    2 'Klangfarbe hell-dunkel'                                                  0 0 1 0;...
    3 ['Klangfarbliche Auspr' char(228) 'gung im H' char(246) 'henbereich']    0 0 1 0 ;...
    4 ['Klangfarbliche Auspr' char(228) 'gung im Mittenbereich']                0 0 1 0;...
    5 ['Klangfarbliche Auspr' char(228) 'gung im Tiefenbereich']                0 0 1 0;...
    6 ['Sch' char(228) 'rfe']                                                   0 0 1 0;...
    7 'Rauigkeit'                                                               0 0 1 0;...
    8 'Kammfilterartigkeit'                                                     0 0 1 0;...
    9 'Metallische Klangfarbe'                                                  0 0 1 0;...
    10 'Tonhaltigkeit'                                                          0 0 2 0;...
    11 ['Tonh' char(246) 'he']                                                 0 0 2 0;...
    12 'Dopplereffekt'                                                          0 0 2 0;...
    13 'Richtung Azimut'                                                        0 0 3 1;...
    14 'Richtung Elevation'                                                     0 0 3 1;...
    15 'Vorn-Hinten-Lage'                                                       1 1 3 0;...
    16 'Entfernung'                                                             0 0 3 0;...
    17 'Tiefenausdehnung'                                                       0 0 3 0;...
    18 'Breitenausdehnung'                                                      0 0 3 0;...
    19 ['H' char(246) 'henausdehnung']                                         0 0 3 0;...
    20 'Externalisierungsgrad'                                                  0 0 3 0;...
    21 'Lokalisierbarkeit'                                                      0 0 3 0;...
    22 ['R' char(228) 'umliches Zerfallen']                                    0 0 3 0;...
    23 ['Nachhallst' char(228) 'rke']                                          0 0 4 0;...
    24 'Nachhalldauer'                                                          0 0 4 0;...
    25 ['Nachhallumh' char(252) 'llung']                                       0 0 4 0;...
    26 'Vorechos'                                                               0 0 5 0;...
    27 'Nachechos'                                                              0 0 5 0;...
    28 'Zeitliches Zerfallen'                                                   0 0 5 0;...
    29 'Knackigkeit'                                                            0 0 5 0;...
    30 'Wiedergabegeschwindigkeit'                                              0 0 5 0;...
    31 'Szenenablauf'                                                           0 1 5 0;...
    32 'Reaktionsschnelligkeit'                                                 0 0 5 0;...
    33 'Lautheit'                                                               0 0 6 0;...
    34 'Dynamik'                                                                0 0 6 0;...
    35 'Kompressoreffekte'                                                      0 0 6 0;...
    36 ['Tonhaltiges Fremdger' char(228) 'usch']                               0 0 7 0;...
    37 ['Impulshaftes Fremdger' char(228) 'usch']                              0 0 7 0;...
    38 ['Rauschhaftes Fremdger' char(228) 'usch']                              0 0 7 0;...
    39 'Fremdquelle'                                                            0 0 7 0;...
    40 'Geisterquelle'                                                          0 0 7 0;...
    41 'Verzerrungen'                                                           0 0 7 0;...
    42 'Vibration'                                                              0 0 7 0;...
    43 'Klarheit'                                                               0 0 8 0;...
    44 ['Sprachverst' char(228) 'ndlichkeit']                                  0 0 8 0;...
    45 ['Nat' char(252) 'rlichkeit']                                           0 0 8 0;...
    46 ['Pr' char(228) 'senz']                                                 0 0 8 0;...
    47 'Gefallen'                                                               0 0 8 0;...
    48 'Sonstiges'                                                              0 0 0 0;...
    };