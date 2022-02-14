require 'tictactoe'

describe "" do
#   it "return_false_at_start_of_game" do
#     expect(Tictactoe.new.confirm_winner('')).to eql false
#   end

  it "return_true_when_a_player_occupied_a_horizontal_row" do
    expect(Tictactoe.new.confirm_horizontal_winner('111121221')).to eql true
    expect(Tictactoe.new.confirm_horizontal_winner('222121121')).to eql true
    expect(Tictactoe.new.confirm_horizontal_winner('121111')).to eql true
    expect(Tictactoe.new.confirm_horizontal_winner('121222')).to eql true
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
