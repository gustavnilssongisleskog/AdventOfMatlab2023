fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
A = cell2mat(A);

A(2:end + 1, 2:end + 1) = A;
A(1, :) = '#';
A(:, 1) = '#';
A(end + 1, :) = '#';
A(:, end + 1) = '#';

d = dictionary;

i = 0;
while true

    for j = 1:4
        A = rollUp(A);
        A = spinClockwise(A);
    end

    i = i + 1;

    if i > 1 && isKey(d, {A})
        cycleLen = i - d({A});
        left = 1000000000 - i;
        spins = mod(left, cycleLen);

        break;
    else
        d({A}) = i;
    end

end

for i = 1:spins
    for j = 1:4
        A = rollUp(A);
        A = spinClockwise(A);
    end
end

A = A(2:end - 1, 2:end - 1);
n = size(A, 1);

dot(sum(A == 'O', 2), n:-1:1)

function A = spinClockwise(A)
    A = A(end:-1:1, :)';
end

function A = rollUp(A)
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

end