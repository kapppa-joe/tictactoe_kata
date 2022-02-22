class Tictactoe
  def start_game
    ask_for_user_name
    game_board = "000000000"
    
    while not(confirm_winner(game_board)) and not(confirm_draw(game_board)) do
      puts display_grid(game_board)
      move = check_for_valid_move(game_board)
      game_board = insert_move(game_board,move)
    end
            
    if confirm_winner(game_board)
        if @current_player ==1
        puts declare_winner(2)
        elsif @current_player ==2
        puts declare_winner(1) 
        end
    else
      puts declare_draw
    end
  end

  attr_reader :name1, :name2

  def initialize
    @current_player = 1
    @name1 = "player1"
    @name2 = "player2"
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

  def confirm_draw(game_board)
    if not(game_board.include?("0")) and not confirm_winner(game_board)
      return true
    else
      return false
    end
  end

  def display_grid(game_board)
    # "   \n   \n   "
    player1x = game_board.gsub('0', '. ').gsub('1', 'X ').gsub('2', 'O ')
    with_newlines = player1x[0, 5] + "\n" + player1x[6, 5] + "\n" + player1x[12, 5]
  end

  def check_input(game_board, move) # return true or false
    return false if move.is_a?(String) or move < 1 or move > 9

    board_index = move - 1
    game_board[board_index] == '0' or game_board[board_index].nil?
  end

  def ask_for_user_input
    if @current_player == 1
      current_player_name = @name1
    else
      current_player_name = @name2
    end

    puts "#{current_player_name} please input your next move ( a number from 1 to 9 )"
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

  def insert_move(game_board_before, move)
    # insert X into game_board using board index
    game_board = game_board_before.clone
    game_board[move - 1] = @current_player.to_s
    change_player
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

  def change_player
    # after change the board
    if @current_player == 1
       @current_player = 2
    else
      @current_player = 1
    end  
  end

  def declare_winner(player_number)
    if player_number == 1
      return "#{@name1} has won the game!"
    else
      return "#{@name2} has won the game!"
    end
  end

  def declare_draw
    return "The game is a draw!"
  end

  def choose_game_mode
    puts 'Select one player or two players?'
    puts 'Enter 1 for one player'
    puts 'Enter 2 for two players'
    game_mode = gets.chomp
    confirm_game_mode(game_mode)
  end

  def confirm_game_mode(game_mode)
    if game_mode == "2"
        puts "You have selected a two player game"
        start_game
    elsif game_mode =="1"
        puts "You have selected a one player game"
    end
  end
end

# Tictactoe.new.check_for_valid_move("000000000")
Tictactoe.new.choose_game_mode
