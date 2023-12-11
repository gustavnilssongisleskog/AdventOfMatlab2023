fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
A = cell2mat(A);
[n, m] = size(A);

expandedRows = char([]);
for i = 1:n
    expandedRows(end + 1, :) = A(i, :);

    if all(A(i, :) == '.')
        expandedRows(end + 1, :) = A(i, :);
    end
end

expanded = char([]);
for i = 1:m
    expanded(:, end + 1) = expandedRows(:, i);

    if all(expandedRows(:, i) == '.')
        expanded(:, end + 1) = expandedRows(:, i);
    end
end

[y, x] = find(expanded == '#');
nGalaxies = length(x);

[n, m] = size(expanded);

tot = 0;
for i = 1:nGalaxies
    for j = i+1:nGalaxies
        tot = tot + abs(x(i) - x(j)) + abs(y(i) - y(j));
    end
end

tot