fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};

A = cell2mat(A);
[n, m] = size(A);

[si, sj] = find(A == 'S');

coordDirs = [-1, 0; 0, 1; 1, 0; 0, -1];

connections = logical([
    1 1 0 0; % L
    1 0 1 0; % |
    1 0 0 1; % J
    0 1 1 0; % F
    0 1 0 1; % -
    0 0 1 1]);% 7

symbols = 'L|JF-7';
letterConnections = @(letter) connections(letter == symbols, :);



for d = 1:4
    i = si + coordDirs(d, 1);
    j = sj + coordDirs(d, 2);
    
    letter = A(i, j);

    dir = logical(full(sparse(1, d, 1, 1, 4)));
    if nnz(letterConnections(letter) .* circshift(dir, 2))
        travelDir = dir;
        nextLetter = letter;
        
        break;
    end
end

len = 0;
isPipe = zeros(n, m);
isPipe(i, j) = 1;

while nextLetter ~= 'S'
    

    nextConnections = letterConnections(nextLetter);
    travelDir = logical(nextConnections - circshift(travelDir, 2));


    coordDir = coordDirs(travelDir, :);
    i = i + coordDir(1);
    j = j + coordDir(2);

    nextLetter = A(i, j);
    len = len + 1;

    isPipe(i, j) = 1;
end

nExp = 2 * n;
mExp = 2 * m;
expandedGrid = char(ones(nExp, mExp) * '.');
expandedGrid(2:2:nExp, 2:2:mExp) = A;
expandedPipes = zeros(nExp, mExp);
expandedPipes(2:2:nExp, 2:2:mExp) = isPipe;

for i = 2:2:nExp
    for j = 2:2:nExp
        if ~isPipe(i / 2, j / 2)
            continue;
        end
        
        letter = expandedGrid(i, j);
        if letter == 'S'
            continue;
        end

        conns = logical(letterConnections(letter));
        for d = 1:4
            if ~conns(d)
                continue;
            end

            ii = i + dirs(d, 1);
            jj = j + dirs(d, 2);
            if mod(d, 2) == 1
                fillLetter = '|';
            else
                fillLetter = '-';
            end

            expandedGrid(ii, jj) = fillLetter;
            expandedPipes(ii, jj) = 1;

        end


    end
end


% dfs
stack = [];
vis = zeros(nExp, mExp);
for i = 1:nExp
    for j = [1, mExp]
        if ~expandedPipes(i, j)
            stack(end+1, :) = [i, j];
            vis(i, j) = 1;
        end
    end
end

for i = [1, nExp]
    for j = 2:mExp-1
        if ~expandedPipes(i, j)
            stack(end+1, :) = [i, j];
            vis(i, j) = 1;
        end
    end
end

stackEnd = length(stack);
while stackEnd > 0
    i = stack(stackEnd, 1);
    j = stack(stackEnd, 2);

    toAdd = [];

    for d = 1:4
        ii = i + dirs(d, 1);
        jj = j + dirs(d, 2);
        
        if ii < 1 || ii > nExp || jj < 1 || jj > mExp
            continue;
        end

        if vis(ii, jj) || expandedPipes(ii, jj)
            continue;
        end

        vis(ii, jj) = 1;
        toAdd(end+1, :) = [ii, jj];

    end

    nAdded = size(toAdd, 1);

    stack(stackEnd:stackEnd + nAdded - 1, :) = toAdd;
    stackEnd = stackEnd + nAdded - 1;

end

inside = 1 - (vis + expandedPipes);
contractedInside = inside(2:2:nExp, 2:2:mExp);

nnz(contractedInside)
