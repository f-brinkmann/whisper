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
% Author :   André Wlodarski, student at FG Audiokommunikation, TU Berlin
% Email  :   awlodarski AT gmx DOT de
% Date   :   16-Nov-2008
%
% =========================================================================


function write_to_log(logstring)
 
global PP TSD

subject_id = TSD{PP.run_number+1,2};
session    = TSD{PP.run_number+1,3};
filename=[PP.path filesep 'logfiles' filesep 'run' num2str(PP.run_number) '_subjectID', subject_id, '_session', session, '.txt'];
fid=fopen(filename,'at+');
fprintf(fid, '\r\n');
fprintf(fid,'%s',logstring);
fclose(fid);

