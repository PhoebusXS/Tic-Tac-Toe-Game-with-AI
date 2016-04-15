% Let the fun begin!

% for each cell: 
% blank is 0, player is -1, computer is 1

game = zeros(3);

disp('Computer: O');
disp('You: X');
fst = input('Do you want to start first? (y/n) ','s');
if fst == 'y'
	player = 1;
else
	player = 2;
end

for turn = 1:9
	if winCheck(game) ~= 0
		break;
	end

	if mod(turn+player,2)
	% computer's turn
		if turn == 1
			game(1) = 1;
		else
			game = computerMove(game);
		end
	else
	% player's turn
		disp(game);
		game = playerMove(game);
	end
end

disp(game);
switch winCheck(game) % finally it's end
	case -1
		disp('Player Wins! //WTF it''s not possible!');
	case 0
		disp('It''s a draw.'); % use 2k*' to display k*' (k is an integer)
	case 1
		disp('I WIN.');
		disp('You human! Too young too simple.')
end