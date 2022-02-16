class Tictactoe
    def initialize
        @current_player = 1
    end

    def confirm_horizontal_winner(moves)
        if moves[0, 3] == "111" or moves[0, 3] == "222"
            return true
        elsif moves[3, 3] == "111" or moves[3, 3] == "222"
            return true
        elsif moves[6, 3] == "111" or moves[6, 3] == "222"
            return true
        end
        false
    end

    def confirm_vertical_winner(moves)
        if moves[0] + moves[3] + moves[6] == "111" or moves[0] + moves[3] + moves[6] == "222"
            return true
        elsif moves[1] + moves[4] + moves[7] == "111" or moves[1] + moves[4] + moves[7] == "222"
            return true
        elsif moves[2] + moves[5] + moves[8] == "111" or moves[2] + moves[5] + moves[8] == "222"
            return true
        end
        false
    end

    def confirm_diagonal_winner(moves)
        if moves[0] + moves[4] + moves[8] == "111" or moves[0] + moves[4] + moves[8] == "222"
            return true
        elsif moves[2] + moves[4] + moves[6] == "111" or moves[2] + moves[4] + moves[6] == "222"
            return true
        end
        false
    end

    def confirm_winner(moves)
        confirm_horizontal_winner(moves) or confirm_diagonal_winner(moves) or confirm_vertical_winner(moves) 
    end

    def display_grid(moves)
        # "   \n   \n   "
        player1x = moves.gsub("0", " ").gsub("1","X").gsub("2","O")
        with_newlines = player1x[0, 3] + "\n" + player1x[3, 3] + "\n" + player1x[6, 3]
    end

    def check_input(move)  # return true or false
        @board = "000000000"
        board_index = move - 1
        return @board[board_index] != 0
    end

    def ask_for_user_input
        puts "please input your next move ( a number from 1 to 9 )"
        input = gets.chomp
        puts input
    end

    def ask_for_user_name
        puts "Enter username 1"
        @name1 = gets.chomp
        puts "Hello " + @name1 +"!"
        puts "Enter username 2"
        @name2 = gets.chomp
        puts "Hello " + @name2 + "!"
    end

    # def record_moves
    #     puts "Enter #{@name1}'s move"
    #     @player1move = gets.chomp
    #     puts "Hello " + @name1 +"!"
    #     puts "Enter username 2"
    #     @name2 = gets.chomp
    #     puts "Hello " + @name2 + "!"
    # end


    def insert_move
        while confirm_winner = false do
        @player1_move_index = @player1_move.to_i-1
            @current_player 
        

            # after change the board

            if @current_player == 1
                @current_player = 2
            else
                @current_player = 1
            end
        end
    end

end

Tictactoe.new.ask_for_user_name