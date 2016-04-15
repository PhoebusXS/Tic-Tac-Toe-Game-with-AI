% check whether there's a winner

function winner=winCheck(game)
	win = [1,2,3; 4,5,6; 7,8,9;
		   1,5,9; 3,5,7;
		   1,4,7; 2,5,8; 3,6,9];

	for i = 1:8
		if game(win(i,:)) == 1
			winner = 1;
			return;
		elseif game(win(i,:)) == -1
			winner = -1;
			return;
		else
			winner = 0;
		end
	end
end