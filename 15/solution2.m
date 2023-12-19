fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
A = cell2mat(A);
A(A == ',') = ' ';
A = convertCharsToStrings(A);
A = split(A);

n = size(A, 1);

nums = cell(256, 1);
labels = cell(256, 1);

for i = 1:256
    x = "";
    x = x([]);
    labels{i} = x;
end

for i = 1:n
    s = convertStringsToChars(A(i));
    m = length(s);

    breakPoint = find(s == '=' | s == '-');
    label = s(1:breakPoint - 1);
    

    hash = mod(17 .^ (breakPoint - 1:-1:1) * double(label)', 256);

    label = convertCharsToStrings(label);

    numList = nums{hash + 1};
    labelList = labels{hash + 1};

    labelPoint = labelList == label;

    if s(breakPoint) == '-'
        
        numList = numList(~labelPoint);
        labelList = labelList(~labelPoint);

    else
        focal = str2double(s(breakPoint + 1));
        
        if nnz(labelPoint)
            numList(labelPoint) = focal;
        else
            labelList(end + 1) = label;
            numList(end + 1) = focal;
        end
    end


    nums{hash + 1} = numList;
    labels{hash + 1} = labelList;
    

end


tot = 0;
for i = 1:256
    numList = nums{i};
    
    if ~isempty(numList)
        tot = tot + i * dot(numList, 1:length(numList));
    end
end
tot





