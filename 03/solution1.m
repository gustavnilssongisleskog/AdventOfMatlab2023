fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
A = cell2mat(A);

[n, m] = size(A);

tot = 0;

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

        up = max(1, i - 1);
        down = min(n, i + 1);
        left = max(1, j - 1);
        right = min(m, last + 1);

        surrounding = A(up:down, left:right);
        if ~all(surrounding == '.' | isstrprop(surrounding, "digit"), "all")
            num = str2double(A(i, j:last));
            tot = tot + num;
        end

        j = last + 1;
    end
end

tot
        
