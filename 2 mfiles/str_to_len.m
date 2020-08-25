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
% Author :   Andr� Wlodarski, student at FG Audiokommunikation, TU Berlin
% Email  :   awlodarski AT gmx DOT de
% Date   :   15-Nov-2008
%
% =========================================================================
%
%
% Die Funktion wandelt einen String beliebiger L�nge in einen String
% vorgegebener L�nge. Dazu werden am Ende Zeichen abgeschnitten oder
% Leerzeichen erg�nzt.
%
% str_to_len(string, length)
%
% Bsp: str_to_len('Hallo', 4)
% liefert "Hall"
% Bsp: str_to_len('Hallo', 7)
% liefert "Hallo  "

function [newstring] = str_to_len(oldstring, newlen)
 
  oldlength=length(oldstring);
  for i=1:newlen
      if i<=oldlength
          newstring(i)=oldstring(i);
      else
          newstring(i)=' ';
      end
  end
  
