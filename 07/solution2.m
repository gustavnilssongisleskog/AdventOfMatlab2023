fileID = fopen('input.txt', 'r'); 
A = textscan(fileID, '%s', 'Delimiter', '\n'); 
fclose(fileID); 

A = A{1};
n = size(A, 1);

cardsRanked = zeros(n, 11);

for i = 1:n
    s = A{i};
    hand = s(1:5);

    repetitions = [sum(sum((hand' == ('AKQT98765432'))) == (5:-1:1)', 2)', 1];
    jokers = nnz(hand == 'J');

    best = find(repetitions, 1);
    repetitions(best - jokers) = repetitions(best - jokers) + 1;
    repetitions(best) = repetitions(best) - 1;
    repetitions = repetitions(1:5);


    handNums = (14:-1:2) * (hand == ('AKQT98765432J')');
    bid = str2double(s(7:end));
    cardsRanked(i, :) = [repetitions, handNums, bid];

end

cardsRanked;

cardsRanked = sortrows(cardsRanked);

winnings = dot(cardsRanked(:, end), 1:n)