% script for replacing old header in all whisper m-files
% by new header in "fileheader.txt"
%
% has to be executed from this folder to run correctly
%
% omit: oscsend.m, setfigdocked.m (not whisPER files)
%
%
%A .Lindau (C) 2014
%-------------------------------------------------------------------%
clc; clear all; close all


%----------------------
% determine size of old header
%
% number of lines of old header
oh_lines = 15;

%-------------------------
% 2. read in new header
%
% new header file
filename = fullfile(pwd,'fileheader.txt');

%determine num. of lines in new header file
fid = fopen(filename, 'rb');
fseek(fid, 0, 'eof');
fileSize = ftell(fid);
frewind(fid);
data = fread(fid, fileSize, 'uint8');
numLines = sum(data == 10) + 1;
fclose(fid);

% get all lines of new header file
fid = fopen(filename,'r');
new_header= cell(1, numLines);
for k = 1:numLines
    new_header{k} = fgetl(fid);
end
fclose(fid);

%---------------------------
% get names of all m-files in whisper source code folder
file_list = dir([cd(cd('..')),filesep,'*.m']);

parentpath = cd(cd('..'));

for  i = 1:size(file_list,1)
    clc
    i
        
    if ~(strcmp(file_list(i).name,'oscsend.m') ||  strcmp(file_list(i).name,'setfigdocked.m'))
                % current file to be changed
        filename = fullfile(parentpath,file_list(i).name);
        
        % determine num. of lines in file to be changed
        fid = fopen(filename, 'rb');
        fseek(fid, 0, 'eof');
        fileSize = ftell(fid);
        frewind(fid);
        data = fread(fid, fileSize, 'uint8');
        numLines = sum(data == 10) + 1;
        fclose(fid);
        
        % get all lines of file to be changed
        fid = fopen(filename,'r');
        file_tbc = cell(1, numLines);
        for k = 1:numLines
            file_tbc{k} = fgetl(fid);
        end
        fclose(fid);
        
        % eliminate old header from file to be changed
        file_tbc = file_tbc(1,oh_lines+1:end);
        
        % add new header to beginning of file
        file_tbc = [new_header file_tbc];
        
        % overwrite file with new header
        fid = fopen(filename, 'w');
        fprintf(fid, '%s\n', file_tbc{:});
        fclose(fid);
    end
end

