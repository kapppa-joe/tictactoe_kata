require 'tictactoe'

describe "tictactoe#confirm_winner" do
  it "return_false_at_start_of_game" do
    expect(Tictactoe.new.confirm_winner('000000000')).to eql false
  end

  it "return_false when no player has won yet" do
    expect(Tictactoe.new.confirm_winner('101202101')).to eql false
    expect(Tictactoe.new.confirm_winner('121212210')).to eql false
  end

  it "return true when a player wins by vertical / horizontal / diagonal" do
    expect(Tictactoe.new.confirm_winner('111121221')).to eql true
    expect(Tictactoe.new.confirm_winner('122102101')).to eql true
    expect(Tictactoe.new.confirm_winner('100010001')).to eql true
  end

  it "return_true_when_a_player_occupied_a_horizontal_row" do
    expect(Tictactoe.new.confirm_horizontal_winner('111121221')).to eql true
    expect(Tictactoe.new.confirm_horizontal_winner('222121121')).to eql true
    expect(Tictactoe.new.confirm_horizontal_winner('121111000')).to eql true
    expect(Tictactoe.new.confirm_horizontal_winner('121222000')).to eql true
    expect(Tictactoe.new.confirm_horizontal_winner('121121111')).to eql true
  end

  it "return true when a player occupied a vertical column" do
    expect(Tictactoe.new.confirm_vertical_winner('122102101')).to eql true
    expect(Tictactoe.new.confirm_vertical_winner('022122121')).to eql true
    expect(Tictactoe.new.confirm_vertical_winner('001121121')).to eql true
  end

  it "return true when a player occupied a diagonal column" do
    expect(Tictactoe.new.confirm_diagonal_winner('100010001')).to eql true
    expect(Tictactoe.new.confirm_diagonal_winner('102020201')).to eql true
    
  end
end

describe "display grid" do
  it "display an empty grid when given a string '000000000' " do
    expect(Tictactoe.new.display_grid('000000000')).to eql "   \n   \n   "
  end

  it "display player one as X' " do
    expect(Tictactoe.new.display_grid('100100100')).to eql "X  \nX  \nX  "
  end

  it "display player two as O' " do
    expect(Tictactoe.new.display_grid('200020002')).to eql "O  \n O \n  O"
  end
end

describe "check_input" do
  it "return true if game_board is empty and player selects 1" do
    game_board = "000000000"
    expect(Tictactoe.new.check_input(game_board, 1)).to eql true
  end

  it "return false if game_board is occupied at position 1 and player selects 1" do
    game_board = "200000000"
    expect(Tictactoe.new.check_input(game_board, 1)).to eql false
  end

  it "return false if invalid move made outside of 1-9 range" do
    game_board = "110000000"
    expect(Tictactoe.new.check_input(game_board, 11)).to eql false
    expect(Tictactoe.new.check_input(game_board, 0)).to eql false
    expect(Tictactoe.new.check_input(game_board, -5)).to eql false
    expect(Tictactoe.new.check_input(game_board, "abc")).to eql false
  end

end

describe "ask for user input" do
  it "record game_board" do
    tictactoe = Tictactoe.new

    allow(tictactoe).to receive(:gets).and_return("1")

    expect{ tictactoe.ask_for_user_input }.to output("please input your next move ( a number from 1 to 9 )\n").to_stdout

  end
end


describe "insert move" do
  it "insert 1 to the 5th position of the board if player1 select 5 as their move" do
    tictactoe = Tictactoe.new
    game_board_before = "000000000"    
    game_board_after = tictactoe.insert_move(game_board_before, 5)
    expect(game_board_after).to eql "000010000"

    
  end
end

describe "invalid input message" do
  it "accept player input if gameboard is empty, and then give back the user input" do
    game_board = "000000000"
    player_input = 1
    tictactoe = Tictactoe.new
    allow(tictactoe).to receive(:gets).and_return("1")
    expect(tictactoe.check_for_valid_move(game_board)).to eql player_input
  end

  it "if player input is not valid, ask player to input again" do
    game_board = "000000000"
    player_input = 10
    tictactoe = Tictactoe.new
    allow(tictactoe).to receive(:gets).and_return("10", "1")

    expected_message = a_string_including("Sorry, your input was not valid. Can you input again?")

    expect{ tictactoe.check_for_valid_move(game_board) }.to output(expected_message).to_stdout
  end

  it "if player input is not valid, ask player to input again and again until got a valid input" do
    game_board = "000000000"
    
    tictactoe = Tictactoe.new
    allow(tictactoe).to receive(:gets).and_return("10", "0", "1")

    expected_message = a_string_including("Sorry, your input was not valid. Can you input again?\n")

    expect(tictactoe).to receive(:gets).exactly(3).time
    expect{ tictactoe.check_for_valid_move(game_board) }.to output(expected_message).to_stdout
  end
  
  describe "start_game" do
    
    it "initiate game with user details" do
      tictactoe = Tictactoe.new
      expected_message = a_string_including("Enter username 1")
      expect{tictactoe.start_game}.to output(expected_message).to_stdout
    end
  end

end
    
