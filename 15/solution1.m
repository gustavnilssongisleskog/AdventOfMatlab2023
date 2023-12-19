fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
A = cell2mat(A);
A(A == ',') = ' ';
A = convertCharsToStrings(A);
A = split(A);

n = size(A, 1);
tot = 0;
for i = 1:n
    s = convertStringsToChars(A(i));
    m = length(s);

    hash = mod(17 .^ (m:-1:1) * double(s)', 256);
    tot = tot + hash;

end


tot
