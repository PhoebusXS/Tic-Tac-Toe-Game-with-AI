function varargout = MyTTT(varargin)
	gui_Singleton = 1;
	gui_State = struct('gui_Name',       mfilename, ...
					   'gui_Singleton',  gui_Singleton, ...
					   'gui_OpeningFcn', @MyTTT_OpeningFcn, ...
					   'gui_OutputFcn',  @MyTTT_OutputFcn, ...
					   'gui_LayoutFcn',  [] , ...
					   'gui_Callback',   []);
	if nargin && ischar(varargin{1})
		gui_State.gui_Callback = str2func(varargin{1});
	end
	if nargout
		[varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
	else
		gui_mainfcn(gui_State, varargin{:});
	end
end
function MyTTT_OpeningFcn(hObject, eventdata, handles, varargin)
	handles.output = hObject;
	guidata(hObject, handles);
	set(handles.StartAgain,'visible','off');
	for i = 1:9
		set(eval(['handles.pushbutton' int2str(i)]),'visible','off');
	end
	set(handles.mock,'visible','off');
	drawLines;
end
function varargout = MyTTT_OutputFcn(hObject, eventdata, handles) 
	varargout{1} = handles.output;
end

function pushbutton1_Callback(hObject, eventdata, handles)
	global game;
	playerMove(game,1);
	set(handles.pushbutton1,'visible','off');
	pause(eps);
	uiresume;
end
function pushbutton2_Callback(hObject, eventdata, handles)
	global game;
	playerMove(game,2);
	set(handles.pushbutton2,'visible','off');
	pause(eps);
	uiresume;
end
function pushbutton3_Callback(hObject, eventdata, handles)
	global game;
	playerMove(game,3);
	set(handles.pushbutton3,'visible','off');
	pause(eps);
	uiresume;
end
function pushbutton4_Callback(hObject, eventdata, handles)
	global game;
	playerMove(game,4);
	set(handles.pushbutton4,'visible','off');
	pause(eps);
	uiresume;
end
function pushbutton5_Callback(hObject, eventdata, handles)
	global game;
	playerMove(game,5);
	set(handles.pushbutton5,'visible','off');
	pause(eps);
	uiresume;
end
function pushbutton6_Callback(hObject, eventdata, handles)
	global game;
	playerMove(game,6);
	set(handles.pushbutton6,'visible','off');
	pause(eps);
	uiresume;
end
function pushbutton7_Callback(hObject, eventdata, handles)
	global game;
	playerMove(game,7);
	set(handles.pushbutton7,'visible','off');
	pause(eps);
	uiresume;
end
function pushbutton8_Callback(hObject, eventdata, handles)
	global game;
	playerMove(game,8);
	set(handles.pushbutton8,'visible','off');
	pause(eps);
	uiresume;
end
function pushbutton9_Callback(hObject, eventdata, handles)
	global game;
	playerMove(game,9);
	set(handles.pushbutton9,'visible','off');
	pause(eps);
	uiresume;
end
function ComputerStart_Callback(hObject, eventdata, handles)
	set(handles.ComputerStart,'visible','off');
	set(handles.PlayerStart,'visible','off');
	set(handles.StartAgain,'visible','on');
	for i = 1:9
		set(eval(['handles.pushbutton' int2str(i)]),'visible','on');
	end
	main(2);
end
function PlayerStart_Callback(hObject, eventdata, handles)
	set(handles.ComputerStart,'visible','off');
	set(handles.PlayerStart,'visible','off');
	set(handles.StartAgain,'visible','on');
	for i = 1:9
		set(eval(['handles.pushbutton' int2str(i)]),'visible','on');
	end
	main(1);
end
function StartAgain_Callback(hObject, eventdata, handles)
	close(gcbf);
	MyTTT;
end
% The End Of GUI Code


function main(player)
% Let the fun begin!

% for each cell: 
% blank is 0, player is -1, computer is 1
	handles = guidata(gcbo);
	global game;
	game = zeros(3);

	for turn = 1:9
		if winCheck(game) ~= 0
			break;
		end

		if mod(turn+player,2)
		% computer's turn
			if turn == 1
				game(1) = 1;
				draw(1,1);
				set(handles.pushbutton1,'visible','off');
			elseif turn == 2
				set(handles.text,'String','Let me think...');
				pause(eps);
				game = computerMove(game);
			else
				set(handles.text,'String','Let me think...');
				pause(0.5); % in case I'm playing too fast
				game = computerMove(game);
			end
		else
		% player's turn
			set(handles.text,'String','Your turn now');
			uiwait;
		end
	end

	for i = 1:9
		set(eval(['handles.pushbutton' int2str(i)]),'visible','off');
	end
	
	switch winCheck(game) % finally it's end
		case -1
			set(handles.text,'String','You Win. //WTF');
		case 0
			set(handles.text,'String','It''s a draw.');
			% use 2k*' to display k*' (k is an integer)
		case 1
			drawWinner;
			set(handles.StartAgain,'visible','off');
			set(handles.text,'String','I WIN.');
			set(handles.mock,'visible','on');
			pause(3);
			set(handles.mock,'visible','off');
			set(handles.StartAgain,'visible','on');
	end
end % main

function game = computerMove(game)
% make the best move of computer
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
		draw(bestMove,1);
		handles = guidata(gcbo);
		set(eval(['handles.pushbutton' int2str(bestMove)]),'visible','off');
	end
end % computerMove

function playerMove(game,move)
% get input from player and make the move
	global game;
	game(move) = -1; % make move to matrix
	draw(move,-1); % also to GUI
end % playerMove

function winner=winCheck(game)
% check whether there's a winner
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
end % winCheck

function score = miniMax(game,player)
% get the score of a certain move
	if winCheck(game) ~= 0 % a winner exists
		score = winCheck(game);
		return;
	end

	eog = 1; % end of game
	maxScore = -inf;
	minScore = +inf;

	for i = 1:9
		if game(i) == 0 % if valid

			eog = 0; % found a valid move
			game(i) = player; % try it

			nowScore = miniMax(game,-player); % get the score
			maxScore = max(nowScore,maxScore); % compare max
			minScore = min(nowScore,minScore); % compare min

			game(i) = 0; % revert the change

		end
	end

	if eog == 1 % means it's a draw game
		score = 0;
		return;
	end;

	if player == 1 % if it's computer's turn
		score = maxScore; % take the maximized move
	else
		score = minScore; % take the minimized move
	end
end % miniMax

function drawLines()
% draw the 4 lines to form the board
	X = [1/3,2/3];
	Y = [0,1];
	hold on;
	for i = 1:2
		plot([1,1]*X(i),Y,'k-');
		plot(Y,[1,1]*X(i),'k-');
	end
end % drawLines

function draw(move,player)
% draw the game in GUI (by a figure)
	centerX = [1/6, 1/2, 5/6;
			   1/6, 1/2, 5/6;
			   1/6, 1/2, 5/6];
	centerY = [5/6, 5/6, 5/6;
			   1/2, 1/2, 1/2;
			   1/6, 1/6, 1/6];

	if player == 1
		drawO([centerX(move),centerY(move)]);
	else
		drawX([centerX(move),centerY(move)]);
	end
end % draw

function drawO(center)
% draw an O (computer)
	hold on;
	r = 1/8;
	t = linspace(0,2*pi,10000);
	x = center(1) + r*cos(t);
	y = center(2) + r*sin(t);
	plot(x,y,'k-','LineWidth',10);
end % drawO

function drawX(center)
% draw an X (player)
	hold on;
	x = [center(1)-1/8,center(1)+1/8];
	y = [center(2)-1/8,center(2)+1/8];
	plot(x,y,'k-','LineWidth',10);
	x = [center(1)+1/8,center(1)-1/8];
	plot(x,y,'k-','LineWidth',10);
end % drawX

function drawWinner(center);
% highlight the winning move
	global game;
	win = [1,2,3; 4,5,6; 7,8,9;
		   1,5,9; 3,5,7;
		   1,4,7; 2,5,8; 3,6,9];
	centerX = [1/6, 1/2, 5/6;
			   1/6, 1/2, 5/6;
			   1/6, 1/2, 5/6];
	centerY = [5/6, 5/6, 5/6;
			   1/2, 1/2, 1/2;
			   1/6, 1/6, 1/6];
	center = zeros(3,2);

	for i = 1:8
		if game(win(i,:)) == 1
			center(:,1) = centerX(win(i,:));
			center(:,2) = centerY(win(i,:));
			break;
		end
	end

	hold on;
	r = 1/8;
	t = linspace(0,2*pi,10000);

	for i = 1:3
		x = center(i,1) + r*cos(t);
		y = center(i,2) + r*sin(t);
		plot(x,y,'g-','LineWidth',10);
	end
end % drawO