fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
A = cell2mat(A);

[n, m] = size(A);
B = zeros(n, m);

% set B
for i = 1:n
    j = 1;
    while j <= m
        if ~isstrprop(A(i, j), "digit")
            j = j + 1;
            continue
        end

        last = j;
        while last < m && isstrprop(A(i, last + 1), "digit")
            last = last + 1;
        end
       
        num = str2double(A(i, j:last));
        B(i, j:last) = num;        

        j = last + 1;
    end
end

tot = 0;
for i = 1:n
    for j = 1:m
        if A(i, j) ~= '*'
            continue
        end

        surrounding = B(i-1:i+1, j-1:j+1);
        nums = [];
        for k = 1:3
            curNum = false;
            for l = 1:3
                if surrounding(k, l) == 0
                    curNum = false;
                    continue
                end

                if ~curNum
                    curNum = true;
                    nums(end+1) = surrounding(k, l);
                end
            end
        end

        if length(nums) == 2
            tot = tot + prod(nums);
        end

        

    end
end

tot