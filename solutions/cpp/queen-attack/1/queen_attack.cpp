#include "queen_attack.h"
#include <stdexcept>

namespace queen_attack {

void validate(const position& p) {
    if (p.first < 0 || p.second < 0 || p.first > 7 || p.second > 7)
        throw std::domain_error("Out of range.");
}
    
chess_board::chess_board(const position& white, const position& black):
    _white(white), _black(black) {
    validate(white);
    validate(black);
    if (white == black)
        throw std::domain_error("Must be distinct.");
}

bool chess_board::can_attack() const {
    return 
        (_white.first == _black.first) ||
        (_white.second == _black.second) ||
        (_white.second - _white.first == _black.second - _black.first) ||
        (_white.second + _white.first == _black.second + _black.first);
}

}  // namespace queen_attack
