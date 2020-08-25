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
    1 'difference' 0 1 0 0;...
    2 'tone color bright-dark' 0 0 1 0;...
    3 'high-frequency tone color' 0 0 1 0 ;...
    4 'mid-frequency tone color' 0 0 1 0;...
    5 'low-frequency tone color' 0 0 1 0;...
    6 'sharpness' 0 0 1 0;...
    7 'roughness' 0 0 1 0;...
    8 'comb filter coloration' 0 0 1 0;...
    9 'metallic tone color' 0 0 1 0;...
    10 'tonalness' 0 0 2 0;...
    11 'pitch' 0 0 2 0;...
    12 'doppler effect' 0 0 2 0;...
    13 'horizontal direction' 0 0 3 1;...
    14 'vertical direction' 0 0 3 1;...
    15 'front-back position' 1 1 3 0;...
    16 'distance' 0 0 3 0;...
    17 'depth' 0 0 3 0;...
    18 'width' 0 0 3 0;...
    19 'height' 0 0 3 0;...
    20 'externalization' 0 0 3 0;...
    21 'localizability' 0 0 3 0;...
    22 'spatial disintegration' 0 0 3 0;...
    23 'level of reverberation' 0 0 4 0;...
    24 'duration of reverberation' 0 0 4 0;...
    25 'envelopment (by reverberation)' 0 0 4 0;...
    26 'pre-echoes' 0 0 5 0;...
    27 'post-echoes' 0 0 5 0;...
    28 'temporal disintegration' 0 0 5 0;...
    29 'crispness' 0 0 5 0;...
    30 'speed' 0 0 5 0;...
    31 'sequence of events' 0 1 5 0;...
    32 'responsiveness' 0 0 5 0;...
    33 'loudness' 0 0 6 0;...
    34 'dynamic range' 0 0 6 0;...
    35 'dynamic compression effects' 0 0 6 0;...
    36 'pitched artifact' 0 0 7 0;...
    37 'impulsive artifact' 0 0 7 0;...
    38 'noise-like artifact' 0 0 7 0;...
    39 'alien source' 0 0 7 0;...
    40 'ghost source' 0 0 7 0;...
    41 'distortion' 0 0 7 0;...
    42 'tactile vibration' 0 0 7 0;...
    43 'clarity' 0 0 8 0;...
    44 'speech intelligibility' 0 0 8 0;...
    45 'naturalness' 0 0 8 0;...
    46 'presence' 0 0 8 0;...
    47 'degree-of-liking' 0 0 8 0;...
    48 'other' 0 0 0 0;...
    };
