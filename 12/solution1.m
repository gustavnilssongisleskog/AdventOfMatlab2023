fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
n = size(A, 1);

tot = 0;

for i = 1:n
    l = split(A{i});
    s = l{1};
    nums = l{2};
    nums(nums == ',') = ' ';
    nums = str2double(split(convertCharsToStrings(nums))');

    tot = tot + numWays(s, nums);

end

tot


function x = numWays(s, lens)

    x = 0;

    if isempty(lens)
        x = ~any(s == '#');
        return;
    end
    
    if length(s) < lens(1)
        x = 0;
        return;
    end

    if s(1) == '.'
        x = numWays(s(2:end), lens);
        return;
    end

    if s(1) == '?'
        x = numWays(s(2:end), lens);
    end

    if all(s(1:lens(1)) ~= '.') && (length(s) == lens(1) || s(lens(1) + 1) ~= '#')
        x = x + numWays(s(lens(1) + 2:end), lens(2:end));
    end


    
    
end