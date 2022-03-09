class Tictactoe
  def start_game
    ask_for_user_name
    game_board = "000000000"
    
    while confirm_winner(game_board) == 0 and not(confirm_draw(game_board)) do
      puts display_grid(game_board)
      move = check_for_valid_move(game_board)
      game_board = insert_move(game_board,move)
    end
            
    winner = confirm_winner(game_board)
    if winner == 1 or winner == 2
        puts declare_winner(winner)
    else   # winner == 0 i.e. this is a draw
      puts declare_draw
    end
  end

  def start_human_vs_computer_game
    # ask_for_user_name
    game_board = "000000000"
    
    while confirm_winner(game_board) == 0 and not(confirm_draw(game_board)) do
      puts display_grid(game_board)

      if @current_player == 1
        puts "PLAYER's TURN"
        move = check_for_valid_move(game_board)  # player's turn
      else
        # computer's turn
        puts "COMPUTER's TURN"
        move = computers_move(game_board, 2)
      end
      game_board = insert_move(game_board, move)
    end
            
    winner = confirm_winner(game_board)
    if winner == 1 or winner == 2
        puts declare_winner(winner)
        puts display_grid(game_board)
    else   # winner == 0 i.e. this is a draw
      puts declare_draw
      puts display_grid(game_board)
    end
  end

  attr_reader :name1, :name2

  def initialize
    @current_player = 1
    @name1 = "player1"
    @name2 = "player2"
  end

  def confirm_horizontal_winner(game_board)
    if game_board[0, 3] == '111' or game_board[3, 3] == '111' or game_board[6, 3] == '111'
      return 1
    elsif game_board[0, 3] == '222' or game_board[3, 3] == '222' or game_board[6, 3] == '222'
      return 2
    else
      return 0
    end
  end

  def confirm_vertical_winner(game_board)
    if game_board[0] + game_board[3] + game_board[6] == '111' or game_board[1] + game_board[4] + game_board[7] == '111' or game_board[2] + game_board[5] + game_board[8] == '111'
      return 1
    elsif game_board[0] + game_board[3] + game_board[6] == '222' or game_board[1] + game_board[4] + game_board[7] == '222' or game_board[2] + game_board[5] + game_board[8] == '222'
      return 2
    else
      return 0
    end
    #   or game_board[0] + game_board[3] + game_board[6] == '222'
    #   return true
    # elsif game_board[1] + game_board[4] + game_board[7] == '111' or game_board[1] + game_board[4] + game_board[7] == '222'
    #   return true
    # elsif game_board[2] + game_board[5] + game_board[8] == '111' or game_board[2] + game_board[5] + game_board[8] == '222'
    #   return true
    # end

    # false
  end

  def confirm_diagonal_winner(game_board)
    if game_board[0] + game_board[4] + game_board[8] == '111' or game_board[2] + game_board[4] + game_board[6] == '111'  
      return 1
    elsif game_board[0] + game_board[4] + game_board[8] == '222' or game_board[2] + game_board[4] + game_board[6] == '222'
      return 2
    end

    0
  end

  def confirm_winner(game_board)
    if confirm_horizontal_winner(game_board) != 0 
        confirm_horizontal_winner(game_board)
    elsif  confirm_diagonal_winner(game_board) !=0
        confirm_diagonal_winner(game_board)
        
    elsif  confirm_vertical_winner(game_board) !=0
        confirm_vertical_winner(game_board)    
    else
        0
    end
end

  def confirm_draw(game_board)
    if not(game_board.include?("0")) and confirm_winner(game_board) == 0
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

  def insert_move_without_changing_player(game_board_before, move, player)
    # insert X into game_board using board index
    game_board = game_board_before.clone
    game_board[move] = player.to_s
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

  def calculate_score(game_board, player_number)
    
    if confirm_draw(game_board)
      return 0
    else
      winner=confirm_winner(game_board)
      if winner == player_number
        return 1
      elsif winner!=0
        return -1
      end
    end

    # when the game is not ended yet
   update_game_board_for_final_move(game_board, player_number)
   
  end

  def update_game_board_for_final_move(game_board, player_number)
    # game_board = "112221102"
    if game_board.count('0') == 1
      draw_board = game_board.gsub('0','1')
      calculate_score(draw_board, player_number) 
      

    elsif game_board.count('0') == 2
      available_cells = (0..8).select {|index| game_board[index] == '0' }
      move1, move2 = available_cells

      future_board_1 = insert_move_without_changing_player(game_board, move1, player_number)
      future_board_2 = insert_move_without_changing_player(game_board, move2, player_number)

      if player_number == 1 
        player_number_of_opponent = 2
      else
        player_number_of_opponent = 1
      end

      score_of_future_board_1_for_opponent = calculate_score(future_board_1, player_number_of_opponent)
      score_of_future_board_2_for_opponent = calculate_score(future_board_2, player_number_of_opponent)

      combined_score = [score_of_future_board_1_for_opponent, score_of_future_board_2_for_opponent].min
      combined_score = combined_score * -1 # because the score got here was opponent's viewpoint, so multiply by -1

      return combined_score

    elsif game_board.count('0') == 3
      available_cells = (0..8).select {|index| game_board[index] == '0' }
      move1, move2, move3 = available_cells

      future_board_1 = insert_move_without_changing_player(game_board, move1, player_number)
      future_board_2 = insert_move_without_changing_player(game_board, move2, player_number)
      future_board_3 = insert_move_without_changing_player(game_board, move3, player_number)

      if player_number == 1 
        player_number_of_opponent = 2
      else
        player_number_of_opponent = 1
      end

      score_of_future_board_1_for_opponent = calculate_score(future_board_1, player_number_of_opponent)
      score_of_future_board_2_for_opponent = calculate_score(future_board_2, player_number_of_opponent)
      score_of_future_board_3_for_opponent = calculate_score(future_board_3, player_number_of_opponent)


      combined_score = [score_of_future_board_1_for_opponent, score_of_future_board_2_for_opponent, score_of_future_board_3_for_opponent].min
      combined_score = combined_score * -1 # because the score got here was opponent's viewpoint, so multiply by -1

    else
      available_cells = (0..8).select {|index| game_board[index] == '0' }
      # move1, move2, move3 = available_cells

      future_boards = []
      available_cells.each do |move|
        future_boards.push(insert_move_without_changing_player(game_board, move, player_number))
      end

      # future_board_1 = insert_move_without_changing_player(game_board, move1, player_number)
      # future_board_2 = insert_move_without_changing_player(game_board, move2, player_number)
      # future_board_3 = insert_move_without_changing_player(game_board, move3, player_number)

      if player_number == 1 
        player_number_of_opponent = 2
      else
        player_number_of_opponent = 1
      end

      scores_of_future_boards = []
      future_boards.each do |future_board|
        scores_of_future_boards.push(calculate_score(future_board, player_number_of_opponent))
      end

      # score_of_future_board_1_for_opponent = calculate_score(future_board_1, player_number_of_opponent)
      # score_of_future_board_2_for_opponent = calculate_score(future_board_2, player_number_of_opponent)
      # score_of_future_board_3_for_opponent = calculate_score(future_board_3, player_number_of_opponent)


      combined_score = scores_of_future_boards.min
      combined_score = combined_score * -1 # because the score got here was opponent's viewpoint, so multiply by -1

      return combined_score
    end
  end
  
  def computers_move(game_board, player_number)
    available_cells = (0..8).select {|index| game_board[index] == '0' }
    possible_scores = {}

    if player_number == 1 
      player_number_of_opponent = 2
    else
      player_number_of_opponent = 1
    end
        
    available_cells.each do |cell_index|
      future_board = insert_move_without_changing_player(game_board, cell_index, player_number)
      possible_scores[cell_index] = calculate_score(future_board, player_number_of_opponent)

      if confirm_winner(future_board) == player_number
        return cell_index + 1   # add 1 here because player move use range 1-9
      end
    end

    # use .min here for best score because it is about minimizing opponent's score
    best_score = possible_scores.values.min
    
    possible_scores.key(best_score) + 1 # add 1 here because player move use range 1-9
  end

end

# Tictactoe.new.check_for_valid_move("000000000")
# Tictactoe.new.start_human_vs_computer_game
