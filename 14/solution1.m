fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
A = cell2mat(A);

A(2:end + 1, :) = A;
A(1, :) = '#';
A(end + 1, :) = '#';

[n, m] = size(A);

for i = 1:n - 1
    for j = 1:m
        
        if A(i, j) == '#'
            last = find(A(i + 1:end, j) == '#', 1, "first") - 1 + i;

            rocks = nnz(A(i + 1:last, j) == 'O');
            if rocks == 0
                continue;
            end

            A(i + 1:i + rocks, j) = 'O';
            A(i + rocks + 1:last, j) = '.';
        end
    end
end

A = A(2:end - 1, :);
dot(sum(A == 'O', 2), n - 2:-1:1)