require 'tictactoe'

describe 'tictactoe#confirm_winner' do
  it 'return 0 at start of game' do
    expect(Tictactoe.new.confirm_winner('000000000')).to eql 0
  end

  it 'return 0 when no player has won yet' do
    expect(Tictactoe.new.confirm_winner('101202101')).to eql 0
    expect(Tictactoe.new.confirm_winner('121212210')).to eql 0
  end

  it 'return player number when a player wins by vertical / horizontal / diagonal' do
    expect(Tictactoe.new.confirm_winner('111121221')).to eql 1
    expect(Tictactoe.new.confirm_winner('122102101')).to eql 1
    expect(Tictactoe.new.confirm_winner('100010001')).to eql 1
  end

  it 'return the player number when a player occupied a horizontal row' do
    expect(Tictactoe.new.confirm_horizontal_winner('111121221')).to eql 1
    expect(Tictactoe.new.confirm_horizontal_winner('222121121')).to eql 2
    expect(Tictactoe.new.confirm_horizontal_winner('121111000')).to eql 1
    expect(Tictactoe.new.confirm_horizontal_winner('121222000')).to eql 2
    expect(Tictactoe.new.confirm_horizontal_winner('121121111')).to eql 1
  end

  it 'return player number when a player occupied a vertical column' do
    expect(Tictactoe.new.confirm_vertical_winner('122102101')).to eql 1
    expect(Tictactoe.new.confirm_vertical_winner('022122121')).to eql 2
    expect(Tictactoe.new.confirm_vertical_winner('001121121')).to eql 1
  end

  it 'return player number when a player occupied a diagonal column' do
    expect(Tictactoe.new.confirm_diagonal_winner('100010001')).to eql 1
    expect(Tictactoe.new.confirm_diagonal_winner('102020201')).to eql 2
  end
end

describe 'confirm_draw' do
  it "confirm a draw when no other moves available and no winner' " do
    expect(Tictactoe.new.confirm_draw('112221112')).to eql true
  end
end

describe 'display grid' do
  it "display an empty grid when given a string '000000000' " do
    expect(Tictactoe.new.display_grid('000000000')).to eql ". . .\n. . .\n. . ."
  end

  it "display player one as X' " do
    expect(Tictactoe.new.display_grid('100100100')).to eql "X . .\nX . .\nX . ."
  end

  it "display player two as O' " do
    expect(Tictactoe.new.display_grid('200020002')).to eql "O . .\n. O .\n. . O"
  end
end

describe 'input_is_valid?' do
  it 'return true if game_board is empty and player selects 1' do
    game_board = '000000000'
    expect(Tictactoe.new.input_is_valid?(game_board, 1)).to eql true
  end

  it 'return false if game_board is occupied at position 1 and player selects 1' do
    game_board = '200000000'
    expect(Tictactoe.new.input_is_valid?(game_board, 1)).to eql false
  end

  it 'return false if invalid move made outside of 1-9 range' do
    game_board = '110000000'
    expect(Tictactoe.new.input_is_valid?(game_board, 11)).to eql false
    expect(Tictactoe.new.input_is_valid?(game_board, 0)).to eql false
    expect(Tictactoe.new.input_is_valid?(game_board, -5)).to eql false
    expect(Tictactoe.new.input_is_valid?(game_board, 'abc')).to eql false
  end
end

describe 'ask for user input' do
  it 'ask player one to input his move' do
    tictactoe = Tictactoe.new

    allow(tictactoe).to receive(:gets).and_return('1')

    expect do
      tictactoe.ask_for_player_move
    end.to output("#{tictactoe.name1} please input your next move ( a number from 1 to 9 )\n").to_stdout
  end

  it "if it is player two's turn, ask player two to input his move" do
    tictactoe = Tictactoe.new
    tictactoe.change_player  # switch player

    allow(tictactoe).to receive(:gets).and_return('1')

    expect do
      tictactoe.ask_for_player_move
    end.to output("#{tictactoe.name2} please input your next move ( a number from 1 to 9 )\n").to_stdout
  end
end

describe 'insert move' do
  it 'insert 1 to the 5th position of the board if player1 select 5 as their move' do
    tictactoe = Tictactoe.new
    game_board_before = '000000000'
    game_board_after = tictactoe.update_board_and_switch_player(game_board_before, 5)
    expect(game_board_after).to eql '000010000'
  end
end

describe 'invalid input message' do
  it 'accept player input if gameboard is empty, and then give back the user input' do
    game_board = '000000000'
    player_input = 1
    tictactoe = Tictactoe.new
    allow(tictactoe).to receive(:gets).and_return('1')
    allow(tictactoe).to receive(:puts).and_return('')
    expect(tictactoe.ask_player_until_got_valid_move(game_board)).to eql player_input
  end

  it 'if player input is not valid, ask player to input again' do
    game_board = '000000000'
    player_input = 10
    tictactoe = Tictactoe.new
    allow(tictactoe).to receive(:gets).and_return('10', '1')

    expected_message = a_string_including('Sorry, your input was not valid. Can you input again?')

    expect { tictactoe.ask_player_until_got_valid_move(game_board) }.to output(expected_message).to_stdout
  end

  it 'if player input is not valid, ask player to input again and again until got a valid input' do
    game_board = '000000000'

    tictactoe = Tictactoe.new
    allow(tictactoe).to receive(:gets).and_return('10', '0', '1')

    expected_message = a_string_including("Sorry, your input was not valid. Can you input again?\n")

    expect(tictactoe).to receive(:gets).exactly(3).time
    expect { tictactoe.ask_player_until_got_valid_move(game_board) }.to output(expected_message).to_stdout
  end
end

describe 'start_two_players_game' do
  it 'initiate game with user details' do
    tictactoe = Tictactoe.new
    expected_message = a_string_including('Enter the name for player 1')
    allow(tictactoe).to receive(:gets).and_return('Ted', 'Joe', '1', '4', '2', '5', '3')
    expect { tictactoe.start_two_players_game }.to output(expected_message).to_stdout

    expected_greeting_ted = a_string_including('Hello Ted!')
    allow(tictactoe).to receive(:gets).and_return('Ted', 'Joe', '1', '4', '2', '5', '3')
    expect { tictactoe.start_two_players_game }.to output(expected_greeting_ted).to_stdout
  end

  it "accept players' moves and declare when one player has won" do
    tictactoe = Tictactoe.new
    allow(tictactoe).to receive(:gets).and_return('Ted', 'Joe', '1', '4', '2', '5', '3')
    expected_message = a_string_including('Ted has won the game!')
    expect { tictactoe.start_two_players_game }.to output(expected_message).to_stdout
  end

  it "accept players' moves and declare player two the winner" do
    tictactoe = Tictactoe.new
    allow(tictactoe).to receive(:gets).and_return('Ted', 'Joe', '9', '1', '4', '2', '7', '3')
    expected_message = a_string_including('Joe has won the game!')
    expect { tictactoe.start_two_players_game }.to output(expected_message).to_stdout
  end

  it "accept players' moves and declare when the game ends with a draw" do
    tictactoe = Tictactoe.new
    allow(tictactoe).to receive(:gets).and_return('Ted', 'Joe', '1', '2', '5', '3', '6', '4', '7', '9', '8')
    expected_message = a_string_including('The game is a draw!')
    expect { tictactoe.start_two_players_game }.to output(expected_message).to_stdout
  end
end

describe 'update board' do
  it 'update the game board after each move has been made' do
    game_board_move_0 = '000000000'
    tictactoe = Tictactoe.new
    game_board_move_1 = tictactoe.update_board_and_switch_player(game_board_move_0, 1)
    game_board_move_2 = tictactoe.update_board_and_switch_player(game_board_move_1, 2)
    expect(game_board_move_1).to eql '100000000'
    expect(game_board_move_2).to eql '120000000'
    game_board_move_3 = tictactoe.update_board_and_switch_player(game_board_move_2, 3)
    game_board_move_4 = tictactoe.update_board_and_switch_player(game_board_move_3, 4)
    expect(game_board_move_3).to eql '121000000'
    expect(game_board_move_4).to eql '121200000'
  end
end

describe 'declare_winner' do
  it 'take a number 1 or 2 and declare the winner' do
    tictactoe = Tictactoe.new
    expect(tictactoe.declare_winner(1)).to eql "#{tictactoe.name1} has won the game!"
    expect(tictactoe.declare_winner(2)).to eql "#{tictactoe.name2} has won the game!"
  end
end

describe 'declare_draw' do
  it 'where there is no winner and no further moves available declare a draw' do
    tictactoe = Tictactoe.new
    expect(tictactoe.declare_draw).to eql 'The game is a draw!'
  end
end

describe 'choose_game_mode' do
  it 'give player the option of playing against AI or another player' do
    tictactoe = Tictactoe.new
    allow(tictactoe).to receive(:gets).and_return('2', 'Ted', 'Joe', '1', '4', '2', '5', '3')
    expected_message = a_string_including('Select one player or two players?')

    expect { tictactoe.choose_game_mode }.to output(expected_message).to_stdout
  end

  it 'enters two player mode if player input 2' do
    tictactoe = Tictactoe.new

    allow(tictactoe).to receive(:gets).and_return('2', 'Ted', 'Joe', '1', '4', '2', '5', '3')

    expected_message = a_string_including('You have selected a two players game')
    expect { tictactoe.choose_game_mode }.to output(expected_message).to_stdout
  end
end

describe 'calculate_score' do
  it 'return score as + 1 when the player has win the game' do
    tictactoe = Tictactoe.new
    game_board = '111200220'
    player_number = 1
    score = tictactoe.calculate_score(game_board, player_number)

    expect(score).to eql 1
  end

  it 'return score as 0 when the game is draw' do
    tictactoe = Tictactoe.new
    game_board = '112221112'
    player_number = 1
    score = tictactoe.calculate_score(game_board, player_number)

    expect(score).to eql 0
  end

  it 'return score as -1 when player has lose the game' do
    tictactoe = Tictactoe.new
    game_board = '111200220'
    player_number = 2
    score = tictactoe.calculate_score(game_board, player_number)

    expect(score).to eql(-1)
  end

  it 'return score as 0 when the next move will result in a draw' do
    tictactoe = Tictactoe.new
    game_board = '112221102'
    player_number = 1
    score = tictactoe.calculate_score(game_board, player_number)

    expect(score).to eql 0
  end

  it 'return score as zero when two moves are available and a draw is inevitable' do
    tictactoe = Tictactoe.new
    game_board = '012211120'
    player_number = 2
    score = tictactoe.calculate_score(game_board, player_number)

    expect(score).to eql 0
  end

  it 'return score as +1 when the next move will result in a win' do
    tictactoe = Tictactoe.new
    game_board = '212221110'
    player_number = 1
    score = tictactoe.calculate_score(game_board, player_number)

    expect(score).to eql 1
  end

  it 'return score as +1 when two moves are available and the player will wins by player either moves' do
    tictactoe = Tictactoe.new
    game_board = '212001211'
    player_number = 2
    score = tictactoe.calculate_score(game_board, player_number)

    expect(score).to eql 1
  end

  it 'return score as -1 when two moves are available and the player will inevitably lose' do
    tictactoe = Tictactoe.new
    game_board = '112002121'
    player_number = 2
    score = tictactoe.calculate_score(game_board, player_number)

    expect(score).to eql(-1)
  end

  it 'computer to select best outcome with two moves available (win or draw)' do
    tictactoe = Tictactoe.new
    game_board = '211010221'
    player_number = 2
    score = tictactoe.calculate_score(game_board, player_number)

    expect(score).to eql 1
  end

  it 'computer to select best outcome with two moves available (draw or lose)' do
    tictactoe = Tictactoe.new
    game_board = '102011122'
    player_number = 2
    score = tictactoe.calculate_score(game_board, player_number)

    expect(score).to eql 0
  end

  it 'computer to select best outcome with two moves available (win or lose)' do
    tictactoe = Tictactoe.new
    game_board = '201201112'
    player_number = 2
    score = tictactoe.calculate_score(game_board, player_number)

    expect(score).to eql 1
  end

  it 'return score as +1 when 3 moves available, all of them leads to winning the game' do
    tictactoe = Tictactoe.new
    game_board = '110212200'
    player_number = 1
    score = tictactoe.calculate_score(game_board, player_number)

    expect(score).to eql 1
  end

  it 'return score as +1 when 3 moves available with one winning move, select winning move' do
    tictactoe = Tictactoe.new
    game_board = '102220101'
    player_number = 1
    score = tictactoe.calculate_score(game_board, player_number)

    expect(score).to eql 1
  end

  it 'return score as 0 for test case with two empty cells, one is draw and one is lose' do
    tictactoe = Tictactoe.new
    game_board = '212120120'
    player_number = 1
    score = tictactoe.calculate_score(game_board, player_number)

    expect(score).to eql 0
  end

  it 'return score as +1 when 5 moves available, win the game' do
    tictactoe = Tictactoe.new
    game_board = '100000221'
    player_number = 1
    score = tictactoe.calculate_score(game_board, player_number)

    expect(score).to eql 1
  end

  it 'return score as 0 when the board is empty' do
    tictactoe = Tictactoe.new
    game_board = '000000000'
    player_number = 1
    score = tictactoe.calculate_score(game_board, player_number)

    expect(score).to eql 0
  end
end

describe 'computers_move' do
  it 'when the board only have one empty cell, it should return the index of that cell' do
    tictactoe = Tictactoe.new
    game_board = '121212210'
    player = 1

    expect(tictactoe.computers_move(game_board, player)).to eq 9
  end

  describe 'computers_penultimate_move' do
    it 'when the board has three empty cells, it should return the index of the cell that leads to an optimal outcome' do
      tictactoe = Tictactoe.new
      game_board = '102220101'
      player = 1

      expect(tictactoe.computers_move(game_board, player)).to eq 8
    end

    it 'when the board has five empty cells, and one move eventually leads to win, it will choose that move' do
      tictactoe = Tictactoe.new
      game_board = '121200000'
      player = 1

      expect(tictactoe.computers_move(game_board, player)).to eq 5
    end

    it 'when the board has four empty cells, and one of the available moves wins the game, it will choose that move' do
      tictactoe = Tictactoe.new
      game_board = '120021001'
      player = 2

      expect(tictactoe.computers_move(game_board, player)).to eq 8
    end
  end
end
