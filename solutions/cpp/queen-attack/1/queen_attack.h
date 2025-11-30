#pragma once
#include <utility>

namespace queen_attack {

typedef std::pair<int, int> position;

class chess_board {
public:
    chess_board(const position& white, const position& black);
    bool can_attack() const;
    const position& white() const {return _white;}
    const position& black() const {return _black;}
private:
    position _white, _black;
};

}  // namespace queen_attack
