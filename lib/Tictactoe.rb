class Tictactoe
  def start_game
    ask_for_user_name
    # check_for_valid_move
  end

  def initialize
    @current_player = 1
  end

  def confirm_horizontal_winner(game_board)
    if game_board[0, 3] == '111' or game_board[0, 3] == '222'
      return true
    elsif game_board[3, 3] == '111' or game_board[3, 3] == '222'
      return true
    elsif game_board[6, 3] == '111' or game_board[6, 3] == '222'
      return true
    end

    false
  end

  def confirm_vertical_winner(game_board)
    if game_board[0] + game_board[3] + game_board[6] == '111' or game_board[0] + game_board[3] + game_board[6] == '222'
      return true
    elsif game_board[1] + game_board[4] + game_board[7] == '111' or game_board[1] + game_board[4] + game_board[7] == '222'
      return true
    elsif game_board[2] + game_board[5] + game_board[8] == '111' or game_board[2] + game_board[5] + game_board[8] == '222'
      return true
    end

    false
  end

  def confirm_diagonal_winner(game_board)
    if game_board[0] + game_board[4] + game_board[8] == '111' or game_board[0] + game_board[4] + game_board[8] == '222'
      return true
    elsif game_board[2] + game_board[4] + game_board[6] == '111' or game_board[2] + game_board[4] + game_board[6] == '222'
      return true
    end

    false
  end

  def confirm_winner(game_board)
    confirm_horizontal_winner(game_board) or confirm_diagonal_winner(game_board) or confirm_vertical_winner(game_board)
  end

  def display_grid(game_board)
    # "   \n   \n   "
    player1x = game_board.gsub('0', ' ').gsub('1', 'X').gsub('2', 'O')
    with_newlines = player1x[0, 3] + "\n" + player1x[3, 3] + "\n" + player1x[6, 3]
  end

  def check_input(game_board, move) # return true or false
    return false if move.is_a?(String) or move < 1 or move > 9

    board_index = move - 1
    game_board[board_index] == '0' or game_board[board_index].nil?
  end

  def ask_for_user_input
    puts 'please input your next move ( a number from 1 to 9 )'
    gets.chomp
  end

  def ask_for_user_name
    puts 'Enter username 1'
    @name1 = gets.chomp
    puts 'Hello ' + @name1 + '!'
    puts 'Enter username 2'
    @name2 = gets.chomp
    puts 'Hello ' + @name2 + '!'
  end

  # def record_game_board
  #     puts "Enter #{@name1}'s move"
  #     @player1move = gets.chomp
  #     puts "Hello " + @name1 +"!"
  #     puts "Enter username 2"
  #     @name2 = gets.chomp
  #     puts "Hello " + @name2 + "!"
  # end

  # def insert_move
  #     while confirm_winner = false do
  #     @player1_move_index = @player1_move.to_i-1
  #         @current_player

  #         # after change the board

  #         if @current_player == 1
  #             @current_player = 2
  #         else
  #             @current_player = 1
  #         end
  #     end
  # end

  def insert_move(game_board_before, move)
    # insert X into game_board using board index
    game_board = game_board_before.clone
    game_board[move - 1] = @current_player.to_s
    game_board
  end

  def check_for_valid_move(game_board)
    move = ask_for_user_input
    until check_input(game_board, move.to_i)
      puts 'Sorry, your input was not valid. Can you input again?'
      move = ask_for_user_input
    end
    move.to_i
  end

  def change_player(game_board)
    move = ask_for_user_input
    
  end
end

# Tictactoe.new.check_for_valid_move("000000000")
# Tictactoe.new.start_game
