fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
n = size(A, 1);

cardsRanked = zeros(n, 11);

for i = 1:n
    s = A{i};
    hand = s(1:5);

    repetitions = sum(sum((hand' == ('AKQJT98765432'))) == (5:-1:1)', 2)';
    handNums = (14:-1:2) * (hand == ('AKQJT98765432')');
    bid = str2double(s(7:end));
    cardsRanked(i, :) = [repetitions, handNums, bid];

end

cardsRanked = sortrows(cardsRanked);

winnings = dot(cardsRanked(:, end), 1:n)