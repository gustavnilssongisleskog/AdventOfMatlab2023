fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
n = size(A);

A = convertCharsToStrings(A);

numCards = ones([1, n]);

for i = 1:n
    s = A(i);
    s = split(s, ":");
    s = s(2);
    winAndMy = split(s, "|");
    winS = winAndMy(1);
    myS = winAndMy(2);
    
    splitWin = split(winS);
    splitWin = splitWin(splitWin ~= "");

    splitMy = split(myS);
    splitMy = splitMy(splitMy ~= "");

    numMatch = nnz(splitMy' == splitWin);
    
    numCards(i+1:i+numMatch) = numCards(i+1:i+numMatch) + numCards(i);
end

sum(numCards)