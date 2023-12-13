fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
n = size(A, 1);

for i = 1:n
    s = A{i};
    A{i} = convertCharsToStrings(s);
end

A = [A{:}]';
A = [""; A; ""];

empty = find(A == "");

tot = 0;

for i = 1:length(empty) - 1
    grid = A(empty(i) + 1:empty(i + 1) - 1);
    grid = cell2mat(convertStringsToChars(grid));

    x = 100 * rowReflections(grid)
    y = rowReflections(grid')
    
    tot = tot + x + y;

end

tot


function r = rowReflections(grid)
    r = 0;
    n = size(grid, 1);

    for i = 1:n - 1
        len = min(i, n - i);

        if all(grid(i:-1:i - len + 1, :) == grid(i + 1:i + len, :))

            r = r + i;
        end
    end

end