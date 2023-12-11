fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
n = size(A, 1);

tot = 0;

for i = 1:n
    s = convertCharsToStrings(A{i});
    nums = str2double(split(s))';

    lasts = nums(end);

    cur = nums;

    while nnz(cur) > 0
        
        cur = cur(2:end) - cur(1:end - 1);
        lasts(end + 1) = cur(end);

    end

    preds = zeros(size(lasts));

    for j = length(preds) - 1:-1:1
        preds(j) = lasts(j) + preds(j + 1);
    end

    tot = tot + preds(1);



end

int2str(tot)