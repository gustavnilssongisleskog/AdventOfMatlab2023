fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
n = size(A);

tot = 0;

colors = ["red", "green", "blue"];

for i = 1:n
    s = A{i};
    s = s(s ~= ';' & s ~= ',');
    s = convertCharsToStrings(s);
    words = split(s);

    prod = 1;

    valid = true;
    for j = 1:3
        colorInds = find(words == colors(j));
        nums = str2double(words(colorInds - 1));
       
        prod = prod * max(nums, [], "all");

    end

    tot = tot + prod;
end

tot