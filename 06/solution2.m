fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
n = size(A, 1);

A = cell2mat(A);

A = A(:, 10:end);
times = A(1,:);
times = times(find(isstrprop(times, "digit"), 1, "first"):end);
times = times(times ~= ' ');
times = str2double(times);

dists = A(2,:);
dists = dists(find(isstrprop(dists, "digit"), 1, "first"):end);
dists = dists(dists ~= ' ');
dists = str2double(dists);

tries = 1:times;
possibleDists = times * tries - tries .^ 2;
prod(sum(possibleDists > dists, 2))