fileID = fopen('input.txt', 'r'); % Open the text file
A = textscan(fileID, '%s', 'Delimiter', '\n'); % Read all lines
fclose(fileID); % Close the file

A = A{1};
n = size(A);

tot = 0;

search = ["1", "2", "3", "4", "5", "6", "7", "8", "9"; "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];

for i = 1:n
    s = A{i};

    firstVal = -1;
    firstInd = 1000;
    lastVal = -1;
    lastInd = 0;
    
    for j = 1:2
        for k = 1:9
            inds = strfind(s, search(j, k));
            if nnz(inds) == 0
                continue
            end
    
            if inds(1) < firstInd
                firstInd = inds(1);
                firstVal = k;
            end

            if inds(end) > lastInd
                lastInd = inds(end);
                lastVal = k;
            end
        end
    end

    tot = tot + 10 * firstVal + lastVal;

end

tot