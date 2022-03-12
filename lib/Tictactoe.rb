class Tictactoe
  attr_reader :name1, :name2

  def initialize
    @current_player = 1
    @name1 = 'player1'
    @name2 = 'player2'
  end

  def start_two_players_game
    ask_for_user_name
    game_board = '000000000'

    while no_one_has_won_yet?(game_board) and not board_is_full?(game_board)
      print_game_board(game_board)
      move = ask_player_until_got_valid_move(game_board)
      game_board = update_board_and_switch_player(game_board, move)
    end

    display_game_result(game_board)
  end

  def start_human_vs_computer_game
    ask_for_user_name(two_players: false)
    game_board = '000000000'

    while no_one_has_won_yet?(game_board) and not board_is_full?(game_board)
      print_game_board(game_board)

      if @current_player == 1
        puts "PLAYER's TURN"
        move = ask_player_until_got_valid_move(game_board)
      else
        puts "COMPUTER's TURN"
        move = computers_move(game_board, 2)
      end
      game_board = update_board_and_switch_player(game_board, move)
    end

    display_game_result(game_board)
  end

  def no_one_has_won_yet?(game_board)
    confirm_winner(game_board) == 0
  end

  def confirm_winner(game_board)
    # return 0 if no one has won yet,
    #        1 if player 1 has won,
    #        2 if player 2 has won
    check_results = [
      confirm_horizontal_winner(game_board),
      confirm_vertical_winner(game_board),
      confirm_diagonal_winner(game_board)
    ]
    if check_results.all?(0)
      0
    else
      check_results.find { |winner| winner > 0 }
    end
  end

  def confirm_horizontal_winner(game_board)
    start_of_rows = [0, 3, 6]
    start_of_rows.each do |start_index|
      row = game_board[start_index, 3]
      case row
        when '111' then return 1
        when '222' then return 2
      end
    end
    return 0
  end

  def confirm_vertical_winner(game_board)
    start_of_column = [0, 1, 2]
    start_of_column.each do |start_index|
      column = game_board[start_index] + game_board[start_index + 3] + game_board[start_index + 6]
      case column
        when '111' then return 1
        when '222' then return 2
      end
    end
    return 0
  end

  def confirm_diagonal_winner(game_board)
    diagonals = [
      game_board[0] + game_board[4] + game_board[8],
      game_board[2] + game_board[4] + game_board[6]
    ]

    diagonals.each do |diagonal|
      case diagonal
        when '111' then return 1
        when '222' then return 2
      end
    end
    return 0
  end

  def confirm_draw(game_board)
    board_is_full?(game_board) and confirm_winner(game_board) == 0
  end

  def board_is_full?(game_board)
    !game_board.include?('0')
  end

  def empty_at_index?(board, index)
    board[index] == '0'
  end

  def input_is_valid?(game_board, move)
    return false if move.is_a?(String) or move < 1 or move > 9

    board_index = move - 1
    empty_at_index?(game_board, board_index)
  end

  def ask_for_player_move
    current_player_name = @current_player == 1 ? @name1 : @name2

    puts "#{current_player_name} please input your next move ( a number from 1 to 9 )"
    gets.chomp
  end

  def ask_player_until_got_valid_move(game_board)
    move = ask_for_player_move.to_i
    while not input_is_valid?(game_board, move.to_i)
      puts 'Sorry, your input was not valid. Can you input again?'
      move = ask_for_player_move
    end
    move.to_i
  end

  def ask_for_user_name(two_players: true)
    puts 'Enter the name for player 1'
    @name1 = gets.chomp
    puts 'Hello ' + @name1 + '!'

    if two_players
      puts 'Enter the name for player 2'
      @name2 = gets.chomp
      puts 'Hello ' + @name2 + '!'
    end
  end

  def update_board_and_switch_player(game_board, player_move)
    cell_index = player_move - 1
    new_board = update_board(game_board, cell_index, @current_player)
    change_player
    new_board
  end

  def update_board(game_board, cell_index, player_number)
    # insert X into game_board using board index. return the game board
    new_board = game_board.clone
    new_board[cell_index] = player_number.to_s
    new_board
  end

  def change_player
    @current_player = opponent_of(@current_player)
  end

  def opponent_of(player_number)
    player_number == 1 ? 2 : 1
  end

  def display_grid(game_board)
    board_in_X_and_O = game_board.gsub('0', '. ').gsub('1', 'X ').gsub('2', 'O ')
    with_newlines = board_in_X_and_O[0, 5] + "\n" + board_in_X_and_O[6, 5] + "\n" + board_in_X_and_O[12, 5]
  end

  def print_game_board(game_board)
    puts display_grid(game_board)
  end

  def display_game_result(game_board)
    winner = confirm_winner(game_board)
    if winner == 0
      puts declare_draw
    else
      puts declare_winner(winner)
    end
    print_game_board(game_board)
  end

  def declare_winner(player_number)
    if player_number == 1
      "#{@name1} has won the game!"
    else
      "#{@name2} has won the game!"
    end
  end

  def declare_draw
    'The game is a draw!'
  end

  def choose_game_mode
    puts 'Select one player or two players?'
    puts 'Enter 1 for one player (play against computer)'
    puts 'Enter 2 for two players'
    game_mode = gets.chomp
    start_chosen_game(game_mode)
  end

  def start_chosen_game(game_mode)
    if game_mode == '2'
      puts 'You have selected a two players game'
      start_two_players_game
    elsif game_mode == '1'
      puts 'You have selected a one player game (play against computer)'
      start_human_vs_computer_game
    end
  end

  def calculate_score(game_board, player_number)
    winner = confirm_winner(game_board)
    if winner == player_number
      return 1 # win the game
    elsif winner == opponent_of(player_number)
      return -1 # lose the game
    elsif winner == 0 and board_is_full?(game_board)
      return 0 # draw game
    end

    # when the game is not ended yet
    calculate_score_for_future_moves(game_board, player_number)
  end

  def calculate_score_for_future_moves(game_board, player_number)
    available_cells = (0..8).select { |index| game_board[index] == '0' }

    future_boards = []
    available_cells.each do |move|
      future_boards.push(update_board(game_board, move, player_number))
    end

    scores_of_future_boards = []
    future_boards.each do |future_board|
      scores_of_future_boards.push(calculate_score(future_board, opponent_of(player_number)))
    end

    # use .min here because it is about minimizing opponent's score
    combined_score = scores_of_future_boards.min
    # because the score got here was opponent's viewpoint, so multiply by -1
    combined_score * -1
  end

  def computers_move(game_board, player_number)
    available_cells = (0..8).select { |index| game_board[index] == '0' }
    possible_scores = {}

    available_cells.each do |cell_index|
      future_board = update_board(game_board, cell_index, player_number)
      possible_scores[cell_index] = calculate_score(future_board, opponent_of(player_number))

      if confirm_winner(future_board) == player_number
        return cell_index + 1 # add 1 here because player move use range 1-9
      end
    end

    # use .min here for best score because it is about minimizing opponent's score
    best_score = possible_scores.values.min
    best_move = possible_scores.key(best_score) + 1 # add 1 here because player move use range 1-9
  end
end


if __FILE__ == $PROGRAM_NAME
  Tictactoe.new.choose_game_mode
end
