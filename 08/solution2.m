fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
n = size(A, 1);

instructions = A{1};


L = dictionary;
R = dictionary;

curs = ['000'];


for i = 3:n
    s = A{i};
    node = (s(1:3));

    if s(3) == 'A'
        curs(end+1, :) = node;
    end

    l = (s(8:10));
    r = (s(13:15));

    L(node) = l;
    R(node) = r;
end

curs = curs(2:end, :);
nCurs = size(curs, 1);

i = 1;
initSteps = numEntries(R)*length(instructions);

for steps = 1:initSteps

    inst = instructions(i);
    
    for c = 1:nCurs
        if inst == 'L'
            curs(c, :) = L(curs(c, :));
        else
            curs(c, :) = R(curs(c, :));
        end
    end

    i = mod(i, length(instructions)) + 1;
end

cycleLen = ones(nCurs, 1);
cycleZ = cell(nCurs, 1);


startI = mod(initSteps, length(instructions)) + 1;
for c = 1:nCurs

    i = startI;
    startNode = convertCharsToStrings(curs(c, :));
    cur = startNode;

    cycle = startNode;

    while true
        
        if instructions(i) == 'L'
            cur = L(cur);
        else
            cur = R(cur);
        end

        i = mod(i, length(instructions)) + 1;
        
        if i == startI && startNode == cur
            break;
        end
        
        cycle(end+1) = cur;
        cycleLen(c) = cycleLen(c) + 1;
    
    end

    zs = cell2mat(convertStringsToChars(cycle'));

    zs = find(zs(:, 3) == 'Z')';
    cycleZ{c} = zs;



end

cycleZ = cell2mat(cycleZ) - 1;

addSteps = crt(cycleZ', cycleLen');

tot = addSteps + initSteps;
int2str(tot)


