fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
n = size(A);

tot = 0;

colors = ["red", "green", "blue"];
limits = [12, 13, 14];

for i = 1:n
    s = A{i};
    s = s(s ~= ';' & s ~= ',');
    s = convertCharsToStrings(s);
    words = split(s);

    valid = true;
    for j = 1:3
        colorInds = find(words == colors(j));
        nums = str2double(words(colorInds - 1));
        if max(nums, [], "all") > limits(j)
            valid = false;
        end

    end

    valid

    if valid
        tot = tot + i;
    end
end

tot