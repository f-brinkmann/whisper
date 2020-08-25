function oscsend(u,path,varargin)
% Sends a Open Sound Control (OSC) message through a UDP connection
%
%----------------------------------------------------------
% Note by Alexander Lindau
% TU Berlin, audio communication group, 2014
%
% ATTENTION: In order to work properly this script needs 
% Matlabs Instrument Control Toolbox (udp-functionality!)
%
%----------------------------------------------------------
%
% oscsend(u,path)
% oscsend(u,path,types,arg1,arg2,...)
% oscsend(u,path,types,[args])
%
% u = UDP object with open connection.
% path = path-string
% types = string with types of arguments,
%    supported:
%       i = integer
%       f = float
%       s = string
%       N = Null (ignores corresponding argument)
%       I = Impulse (ignores corresponding argument)
%       T = True (ignores corresponding argument)
%       F = False (ignores corresponding argument)
%       B = boolean (not official: converts argument to T/F in the type)
%    not supported:
%       b = blob
%
% args = arguments as specified by types.
%
% EXAMPLE
%       u = udp('127.0.0.1',7488);  
%       fopen(u);
%       oscsend(u,'/test','ifsINBTF', 1, 3.14, 'hello',[],[],false,[],[]);
%       fclose(u);
%
% See http://opensoundcontrol.org/ for more information about OSC.


% MARK MARIJNISSEN 10 may 2011 (markmarijnissen@gmail.com)
    
    %figure out little endian for int/float conversion
    [trash1, trash2, endian] = computer;
    littleEndian = endian == 'L';

    % set type
    if nargin >= 2,
        types = oscstr([',' varargin{1}]);
    else
        types = oscstr(',');
    end;
    
    % set args (either a matrix, or varargin)
    if nargin == 3 && length(types) > 2
        args = varargin{2};
    else
        args = varargin(2:end);
    end;

    % convert arguments to the right bytes
    data = [];
    for i=1:length(args)
        switch(types(i+1))
            case 'i'
                data = [data oscint(args{i},littleEndian)];
            case 'f'
                data = [data oscfloat(args{i},littleEndian)];
            case 's'
                data = [data oscstr(args{i})];
            case 'B'
                if args{i}
                    types(i+1) = 'T';
                else
                    types(i+1) = 'F';
                end;
            case {'N','I','T','F'}
                %ignore data
            otherwise
                warning(['Unsupported type: ' types(i+1)]);
        end;
    end;
    
    %write data to UDP
    data = [oscstr(path) types data];
    fwrite(u,data);
end

%Conversion from double to float
function float = oscfloat(float,littleEndian)
   if littleEndian
        float = typecast(swapbytes(single(float)),'uint8');
   else
        float = typecast(single(float),'uint8');
   end;
end

%Conversion to int
function int = oscint(int,littleEndian)
   if littleEndian
        int = typecast(swapbytes(int32(int)),'uint8');
   else
        int = typecast(int32(int),'uint8');
   end;
end

%Conversion to string (null-terminated, in multiples of 4 bytes)
function string = oscstr(string)
    string = [string 0 0 0 0];
    string = string(1:end-mod(length(string),4));
end
