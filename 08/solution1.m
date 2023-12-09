fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
n = size(A, 1);

instructions = A{1};

L = dictionary;
R = dictionary;

for i = 3:n
    s = A{i};
    node = convertCharsToStrings(s(1:3));
    l = convertCharsToStrings(s(8:10));
    r = convertCharsToStrings(s(13:15));

    L(node) = l;
    R(node) = r;
end

i = 1;
steps = 0;
cur = "AAA";
while cur ~= "ZZZ"
    
    steps = steps + 1;

    inst = instructions(i);

    if inst == 'L'
        cur = L(cur);
    else
        cur = R(cur);
    end

    i = mod(i, length(instructions)) + 1;

end
i
steps