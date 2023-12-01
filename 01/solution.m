fileID = fopen('input.txt', 'r'); % Open the text file
A = textscan(fileID, '%s', 'Delimiter', '\n'); % Read all lines
fclose(fileID); % Close the file

A = A{1};
n = size(A);

tot = 0;

for i = 1:n
    s = A{i};
    isDigit = isstrprop(s, "digit");

    first = find(isDigit, 1, "first");
    last = find(isDigit, 1, "last");

    tot = tot + str2double(s([first, last]));

end

tot