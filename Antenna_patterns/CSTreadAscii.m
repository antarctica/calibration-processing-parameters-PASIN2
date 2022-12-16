function cellOutput = CSTreadAscii(fileIn, separatorKind, separator)
% Reads content of ASCII file, after exporting processed data from CST.
%
% Each new set of data is made up by a line with text describing the
%   content, then a line with all '-' (ASCII=45), then the numerical data,
%   and ends with an empty line.
%
%   Input: fileIn: file with ASCII content
%          separatorKind: kind of separator to distinguish string labels:
%                     'none': get the whole string as a unique text
%                     'spaces': labels separated by K 'spaces'
%                                (string1     string2    stringN)
%                     'units': labels separated by symbol 'S'
%                               (Amp[v]   Amp[dB]    Phase[rad]), 'S'=']'
%          separator: separator to distinguish string labels:
%                     K: number of 'spaces' (string1     string2    stringN)
%                     'S': units enclosed by symbol 'S'
%                          (Amp[v]   Amp[dB]    Phase[rad]), 'S' = ']'
%
%   Flags: -
%
%   Output: cellOutput: cell with the content of the file, with dimensions
%                       {2,N}, being N the number of different results
%                       found. First row contents the text description, and
%                       second row the numerical data.
%
%   Invocation: cellOutput = CSTreadAscii(fileIn)
%               cellOutput = CSTreadAscii(fileIn, 'none')
%               cellOutput = CSTreadAscii(fileIn, 'spaces', 3)
%               cellOutput = CSTreadAscii(fileIn, 'units', ']')
%
%   Dependencies:
%           Called by: -
%           Calls: -
%
%   Date: 16.12.2016
%
%   Author: A.Arenas. UCL

fid = fopen(fileIn,'r');
delChar = double(uint8('-'));
if nargin==1
    separatorKind = 'none';
end
N = 0;
tline = fgetl(fid);
while tline ~= -1
    % current block of data
    N = N + 1; 
    % get labels for data coordinates
    tline = strtrim(tline);
    switch lower(strtrim(separatorKind))
        case 'none'
            stringCell = tline;
        case 'spaces' % '(string1     string2    stringN)'
           findKSpace = strfind(tline,double(uint8(' '))*ones(1,separator));
            if isempty(findKSpace) % only one label in current data block
                iniOfString = 1;
                endOfString = length(tline);
            else % 2 or more labels per data block
                findKJumpSpace = find(diff(findKSpace)>1);
                iniOfString = [1 findKSpace([1 findKJumpSpace+1])];
                endOfString = [findKSpace([1 findKJumpSpace+1])-1 length(tline)];
            end
            stringCell = cell(1,length(iniOfString));
            for k=1:length(iniOfString)
                stringCell{k} = strtrim(tline(iniOfString(k):endOfString(k)));
            end
        case 'units' % (Amp[v]   Amp[dB]    Phase[rad]), separator = ']'
            findS = strfind(tline,separator);
            if isempty(findS) % only one label in current data block
                iniOfString = 1;
                endOfString = length(tline);
            else % 2 or more labels per data block
                iniOfString = [1 findS(1:end-1)+1];
                endOfString = [findS(1:end-1) length(tline)];
            end
            stringCell = cell(1,length(iniOfString));
            for k=1:length(iniOfString)
                stringCell{k} = strtrim(tline(iniOfString(k):endOfString(k)));
            end
        otherwise % 'none'
            stringCell = tline;
    end
    cellOutput{2,N} = stringCell;
    % line with '--------...--------'
    tline = fgetl(fid);
    if any(tline-delChar)
        disp('Not expected delimiter (''-'') from strings to numbers');
    end
    % start lines with numbers
    tline = fgetl(fid);
    matrixNumbers = [];
    while (~isempty(tline) & tline ~= -1) % after numbers, an empty line or end of file is expected
        matrixNumbersLine = sscanf(tline, '%g').';
        matrixNumbers = [matrixNumbers; matrixNumbersLine];
        tline = fgetl(fid);
    end
    cellOutput{1,N} = matrixNumbers;
    % empty line
    tline = fgetl(fid);
    % block finished
end
fclose(fid);