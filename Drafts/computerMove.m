% make the best move of computer

function game = computerMove(game)
	bestScore = -inf;
	bestMove = 0;

	for i = 1:9
		if game(i) == 0; % if valid

			game(i) = 1; % try it
            
			nowScore = miniMax(game,-1); % get score
			if nowScore > bestScore;
				bestScore = nowScore; % keep the best score
				bestMove = i; % also the index of move
			end

			game(i) = 0; % revert the change

		end
	end

	if bestMove % best move exists
		game(bestMove) = 1; % take it!
	else % any accident that may occur occurred
		disp('WTF error.') % just to debug :)
	end
end