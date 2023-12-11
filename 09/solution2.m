fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
n = size(A, 1);

tot = 0;

for i = 1:n
    s = convertCharsToStrings(A{i});
    nums = str2double(split(s))';

    firsts = nums(1);

    cur = nums;

    while nnz(cur) > 0
        
        cur = cur(2:end) - cur(1:end - 1);
        firsts(end + 1) = cur(1);

    end

    preds = zeros(size(firsts));

    for j = length(preds) - 1:-1:1
        preds(j) = firsts(j) - preds(j + 1);
    end

    tot = tot + preds(1);



end

int2str(tot)