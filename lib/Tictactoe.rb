class Tictactoe
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

    
    
    end
    def confirm_diagonal_winner(moves)
        if moves[0] + moves[4] + moves[8] == "111" or moves[0] + moves[4] + moves[8] == "222"
            return true
        
        
        end
    end


end

