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

% This script holds all scale labels/poles:
% Item id (see saqi_items), negative pole, positive pole
SAQI_scale_label = ...   
{...
1 'gar keiner' ['sehr gro' char(223) 'er']; ...
2 'dunkler' 'heller'; ...
3 ['H' char(246) 'hen abgesenkt'] ['H' char(246) 'hen angehoben']; ...
4 'Mitten abgesenkt' 'Mitten angehoben';...
5 'Tiefen abgesenkt' 'Tiefen angehoben';...
6 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
7 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
8 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
9 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
10 'weniger tonal' 'tonaler';...
11 'tiefer' ['h' char(246) 'her'];...
12 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
13 'entgegen dem Uhrzeigersinn versetzt' 'im Uhrzeigersinn versetzt';...
14 'nach unten versetzt' 'nach oben versetzt';...
15 'nicht vertauscht' 'vertauscht';...
16 ['n' char(228) 'her'] 'ferner';...
17 ['k' char(252) 'rzer'] 'tiefer';...
18 'schmaler' 'breiter';...
19 'niedriger' ['h' char(246) 'her'];...
20 'internalisierter' 'externalisierter';...
21 ['unpr' char(228) 'ziser'] ['pr' char(228) 'ziser'];...
22 'fusionierter' 'zerfallener';...
23 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
24 ['k' char(252) 'rzer'] ['l' char(228) 'nger'];...
25 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
26 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
27 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
28 'fusionierter' 'zerfallener';...
29 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
30 'verlangsamt' 'beschleunigt';...
31 ['unver' char(228) 'ndert'] ['stark ver' char(228) 'ndert'];...
32 'geringer' ['h' char(246) 'her'];...
33 'leiser' 'lauter';...
34 'geringer' ['h' char(246) 'her'];...
35 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
36 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
37 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
37 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
39 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
40 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
41 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
42 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
43 ['schw' char(228) 'cher ausgepr' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
44 'geringer' ['h' char(246) 'her'];...
45 ['unnat' char(252) 'rlicher'] ['nat' char(252) 'rlicher'];...
46 'geringer' ['h' char(246) 'her'];...
47 ['gef' char(228) 'llt weniger'] ['gef' char(228) 'llt mehr'];...
48 ['schw' char(228) 'cher ausgerp' char(228) 'gt'] ['st' char(228) 'rker ausgepr' char(228) 'gt'];...
};