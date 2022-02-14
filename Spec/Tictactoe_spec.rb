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


describe "user input requirements" do
  it "check input for validity" do
    expect(Tictactoe.new.check_input("1X")).to eql "100000000"
  end
end

require "stringio"

describe "ask for user input" do
    it "record moves" do
      input = StringIO.new("1\n")
      output = StringIO.new
      tictactoe = Tictactoe.new(input, output)

      tictactoe.ask_for_user_input

      expect(output).to eql "please input your next move ( a number from 1 to 9 )\n1"
    end
end