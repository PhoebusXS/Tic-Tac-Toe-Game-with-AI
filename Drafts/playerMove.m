% get input from player and make the move

function game=playerMove(game)
	x=input('input your move with a vector (row,column): ');
	move=3*(x(2)-1)+x(1); % convert x into a scalar coordinate

	if game(move)==0 && move>=1 && move<=9
	% check whether the move is valid
		game(move)=-1;
	else
		disp('invalid move');
		playerMove(game);
	end
end