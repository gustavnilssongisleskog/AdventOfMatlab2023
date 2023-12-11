fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
A = cell2mat(A);
[n, m] = size(A);

emptyRows = string(A) == string(repmat('.', 1, m));
emptyCols = string(A') == string(repmat('.', 1, n));

[y, x] = find(A == '#');
nGalaxies = length(x);

expand = 1000000;

tot = 0;
for i = 1:nGalaxies
    for j = i+1:nGalaxies
        xmin = min(x(i), x(j));
        xmax = max(x(i), x(j));
        ymin = min(y(i), y(j));
        ymax = max(y(i), y(j));

        d = xmax - xmin + ymax - ymin;
        extra = (nnz(emptyRows(ymin:ymax)) + nnz(emptyCols(xmin:xmax))) * (expand - 1);

        tot = tot + d + extra;
    end
end

int2str(tot)