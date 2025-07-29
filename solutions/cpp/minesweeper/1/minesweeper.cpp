#include "minesweeper.h"

#include <algorithm>

namespace minesweeper {
    auto is_bomb(char square)
    {
        return square == '*';
    }

    auto is_empty(char square)
    {
        return square == ' ';
    }

    enum class square_position 
    {
        single_square,
        line_left, 
        line_right, 
        line_middle, 
        col_top,
        col_bottom,
        col_middle,
        middle, 
        top_left, 
        top_right, 
        top_middle, 
        bottom_left, 
        bottom_right, 
        bottom_middle
    };

    auto check_position(std::size_t row_index, std::size_t col_index, std::size_t num_of_rows, std::size_t num_of_cols)
    {
        const auto is_top {row_index == 0};
        const auto is_bottom {row_index == num_of_rows - 1};
        const auto is_left {col_index == 0};
        const auto is_right {col_index == num_of_cols - 1};

        if (is_top and is_bottom)
        {
            if (is_left and is_right) return square_position::single_square;
            if (is_left) return square_position::line_left;
            if (is_right) return square_position::line_right;
            return square_position::line_middle;
        }

        if (is_left and is_right)
        {
            if (is_top) return square_position::col_top;
            if (is_bottom) return square_position::col_bottom;
            return square_position::col_middle;
        }

        if (is_top)
        {
            if (is_left) return square_position::top_left;
            if (is_right) return square_position::top_right;
            return square_position::top_middle;
        }

        if (is_bottom)
        {
            if (is_left) return square_position::bottom_left;
            if (is_right) return square_position::bottom_right;
            return square_position::bottom_middle;
        }

        return square_position::middle;
    }

    auto count_bombs(const std::vector<std::string>& board, std::size_t num_of_cols, std::size_t row_index, std::size_t col_index) -> std::size_t
    {
        const auto num_of_rows = board.size();        
        const auto position = check_position(row_index, col_index, num_of_rows, num_of_cols);

        switch (position)
        {
            case square_position::single_square :
                return 0;

            case square_position::line_middle :
                return is_bomb(board[row_index][col_index + 1]) +
                    is_bomb(board[row_index][col_index - 1]);

            case square_position::line_left :
                return is_bomb(board[row_index][col_index + 1]);

            case square_position::line_right :
                return is_bomb(board[row_index][col_index - 1]);

            case square_position::col_middle :
                return is_bomb(board[row_index - 1][col_index]) +
                    is_bomb(board[row_index + 1][col_index]);

            case square_position::col_top :
                return is_bomb(board[row_index + 1][col_index]);

            case square_position::col_bottom :
                return is_bomb(board[row_index - 1][col_index]);
            
            case square_position::middle :
                return is_bomb(board[row_index - 1][col_index - 1]) +
                    is_bomb(board[row_index - 1][col_index]) +
                    is_bomb(board[row_index - 1][col_index + 1]) +
                    is_bomb(board[row_index][col_index - 1]) +
                    is_bomb(board[row_index][col_index + 1]) +
                    is_bomb(board[row_index + 1][col_index - 1]) +
                    is_bomb(board[row_index + 1][col_index]) +
                    is_bomb(board[row_index + 1][col_index + 1]);
            
            case square_position::top_left :
                return is_bomb(board[row_index][col_index + 1]) +
                    is_bomb(board[row_index + 1][col_index]) +
                    is_bomb(board[row_index + 1][col_index + 1]);
            
            case square_position::top_right :
                return is_bomb(board[row_index][col_index - 1]) +
                    is_bomb(board[row_index + 1][col_index - 1]) +
                    is_bomb(board[row_index + 1][col_index]);
            
            case square_position::top_middle :
                return is_bomb(board[row_index][col_index - 1]) +
                    is_bomb(board[row_index][col_index + 1]) +
                    is_bomb(board[row_index + 1][col_index - 1]) +
                    is_bomb(board[row_index + 1][col_index]) +
                    is_bomb(board[row_index + 1][col_index + 1]);

            case square_position::bottom_left :
                return is_bomb(board[row_index - 1][col_index]) +
                    is_bomb(board[row_index - 1][col_index + 1]) +
                    is_bomb(board[row_index][col_index + 1]);
            
            case square_position::bottom_right :
                return is_bomb(board[row_index - 1][col_index - 1]) +
                    is_bomb(board[row_index - 1][col_index]) +
                    is_bomb(board[row_index][col_index - 1]);
            
            case square_position::bottom_middle :
                return is_bomb(board[row_index - 1][col_index]) +
                    is_bomb(board[row_index - 1][col_index + 1]) +
                    is_bomb(board[row_index][col_index + 1]) +
                    is_bomb(board[row_index - 1][col_index - 1]) +
                    is_bomb(board[row_index][col_index - 1]);
        }

        return 0;
    }

    auto annotate(std::vector<std::string> board) -> std::vector<std::string>
    {
        if (board.empty()) return board;
        
        std::for_each
        (
            board.begin(), 
            board.end(), 
            [&] (std::string& row)
            {
                const std::size_t row_index = std::distance(&board[0], &row);
                const std::size_t num_of_cols = board[row_index].size();
                
                std::transform
                (
                    row.begin(),
                    row.end(),
                    row.begin(),
                    [&](char& square)
                    {
                        const std::size_t col_index = std::distance(&row[0], &square);

                        if (is_empty(square))
                            if (const std::size_t number_of_bombs {count_bombs(board, num_of_cols, row_index, col_index)})
                                return static_cast<char>('0' + number_of_bombs);

                        return square;
                    }
                );
            }
        );     

        return board;
    }
}  // namespace minesweeper
