#if !defined(QUEEN_ATTACK_H)
#define QUEEN_ATTACK_H

#include <utility>
#include <stdexcept>
#include <cstdint>
#include <type_traits>

namespace std {
	auto operator==(const pair<int, int>& fst, const pair<uint8_t, uint8_t>& sec) -> bool;
}

namespace queen_attack {

    template<typename T>    
    class chess_board {
    private:
        std::pair<uint8_t, uint8_t> white_queen;
        std::pair<uint8_t, uint8_t> black_queen;
    public:
        chess_board(std::pair<T, T> white, std::pair<T, T> black) {
		if (white.first < 0 or white.first > 7
		    or white.second < 0 or white.second > 7
		    or (not std::is_integral_v<decltype(white.first)>)
		    or (not std::is_integral_v<decltype(white.second)>)) {
		    throw std::domain_error("Invalid position for white queen");
		}
		else if (black.first < 0 or black.first > 7
		    or black.second < 0 or black.second > 7
		    or (not std::is_integral_v<decltype(black.first)>)
		    or (not std::is_integral_v<decltype(black.second)>)) {
		    throw std::domain_error("Invalid position for black queen");
		}
		else if (white.first == black.first and white.second == black.second) {
		    throw std::domain_error("Queens must be in different positions");
		}

		chess_board::white_queen = std::pair<uint8_t, uint8_t>{white.first, white.second};
		chess_board::black_queen = std::pair<uint8_t, uint8_t>{black.first, black.second};
        }
        
        auto white() const -> std::pair<uint8_t, uint8_t> {
        	return white_queen;
        }
        
        auto black() const -> std::pair<uint8_t, uint8_t> {
        	return black_queen;
        }
        
        auto can_attack() const -> bool {
        	const auto same_row = white_queen.first == black_queen.first;
        	const auto same_column = white_queen.second == black_queen.second;
        	const auto same_diagonal = std::abs(white_queen.first - black_queen.first) == std::abs(white_queen.second - black_queen.second);
        	
        	return same_row or same_column or same_diagonal;
        }     
    };
}  // namespace queen_attack

#endif // QUEEN_ATTACK_H
