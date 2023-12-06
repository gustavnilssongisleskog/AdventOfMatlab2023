fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
n = size(A, 1);

A = convertCharsToStrings(A);
breakInds = find(A == "", Inf)';
breakInds(end + 1) = n + 1;

mappings = cell(7, 1);

for i = 1:7
    mappings{i} = str2double(split(A(breakInds(i) + 2: breakInds(i + 1) - 1)));
    mappings{i} = sortrows(mappings{i}, 2);
end

seeds = A(1);
seeds = convertStringsToChars(seeds);
seeds = seeds(8:end);
seeds = convertCharsToStrings(seeds);
seeds = str2double(split(seeds))';

ranges = [seeds(1:2:end); seeds(1:2:end) + seeds(2:2:end) - 1];

for i = 1:7
    newRanges = [];
    mapping = mappings{i}';
    
    r = 1;
    while r <= size(ranges, 2)

        range = ranges(:, r);
        matched = false;

        for map = mapping
            dest = map(1);
            source = map(2);
            len = map(3);

            if range(2) < source
                continue;
            end

            if range(1) >= source + len
                continue;
            end

            matched = true;

            minInclude = max(range(1), source);
            maxInclude = min(range(2), source + len - 1);

            diffs = [minInclude, maxInclude] - source;
            newRanges(:, end + 1) = dest + diffs;

            if minInclude > range(1)

                ranges(:, end + 1) = [range(1); minInclude - 1];

            end

            if maxInclude < range(2)

                ranges(:, end + 1) = [maxInclude + 1; range(2)];

            end

            break;
        end

        if ~matched
            newRanges(:, end + 1) = range;
        end


        r = r + 1;
    end

    ranges = newRanges;


end

min(ranges, [], "all")