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
while nextLetter ~= 'S'
    

    nextConnections = letterConnections(nextLetter);
    travelDir = logical(nextConnections - circshift(travelDir, 2));


    coordDir = coordDirs(travelDir, :);
    i = i + coordDir(1);
    j = j + coordDir(2);

    nextLetter = A(i, j);
    len = len + 1;
end

(len + 1) / 2

