fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
n = size(A, 1);

tot = 0;

for i = 1:n
    
    l = split(A{i});
    s = l{1};
    s = [s '?' s '?' s '?' s '?' s];
    nums = l{2};
    nums(nums == ',') = ' ';
    nums = str2double(split(convertCharsToStrings(nums))');
    nums = [nums nums nums nums nums];
    
    x = numWays(s, nums);

    tot = tot + x;

end

int2str(tot)


function x = numWays(s, lens)

    n = length(s);
    m = length(lens);

    
    % dp(i, j) = numWays(s(i:n), lens(j:m))
    dp = zeros(n + 2, m + 1);

    for i = n+2:-1:1
        for j = m+1:-1:1


            if i >= n + 1
                dp(i, j) = j == m + 1;
                continue;
            end

            if j == m + 1
                dp(i, j) = all(s(i:end) ~= '#');
                continue;
            end


            if n - i + 1 < lens(j)
                continue;
            end
        

            if s(i) ~= '#'
                dp(i, j) = dp(i + 1, j);
            end


            if all(s(i:lens(j) + i - 1) ~= '.') && ((n + 1 == lens(j) + i) || s(i + lens(j)) ~= '#')
                dp(i, j) = dp(i, j) + dp(i + lens(j) + 1, j + 1);
            end

        end
    end

    x = dp(1, 1);

end