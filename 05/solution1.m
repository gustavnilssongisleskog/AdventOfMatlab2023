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
end

seeds = A(1);
seeds = convertStringsToChars(seeds);
seeds = seeds(8:end);
seeds = convertCharsToStrings(seeds);
seeds = str2double(split(seeds))';

lowLocation = Inf;
for seed = seeds
    for i = 1:7
        mapping = mappings{i};
        for j = 1:size(mapping, 1)
            if seed >= mapping(j, 2) && seed < mapping(j, 2) + mapping(j, 3)
                diff = seed - mapping(j, 2);
                seed = mapping(j, 1) + diff;
                break;
            end
        end
    end

    lowLocation = min(lowLocation, seed);

end

lowLocation