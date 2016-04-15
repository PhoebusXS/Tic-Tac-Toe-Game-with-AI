% the body of minimax algorithm
% get the score of a certain move

function score = miniMax(game,player)

	if winCheck(game) ~= 0 % a winner exists
		score = winCheck(game);
		return;
    end
    
    eog = 1; % end of game

	maxScore = -inf;
	minScore = +inf;

	for i = 1:9
		if game(i) == 0 % if valid

			eog = 0;
			game(i) = player; % try it

			nowScore = miniMax(game,-player);
			maxScore = max(nowScore,maxScore);
			minScore = min(nowScore,minScore);

			game(i) = 0; % revert the change

		end
	end

	if eog == 1 % means it's a draw game
		score = 0;
		return;
	end;

	if player == 1
		score = maxScore;
	else
		score = minScore;
	end

end