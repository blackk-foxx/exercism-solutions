#include "secret_handshake.h"
#include <array>
#include <algorithm>

namespace secret_handshake {

const std::array actions{
    "wink",
    "double blink",
    "close your eyes",
    "jump"
};

std::vector<std::string> commands(int code) {
    std::vector<std::string> result;
    for (unsigned i = 0; i < actions.size(); ++i)
        if (code & (1 << i))
            result.push_back(actions[i]);
    if (code & 0x10)
        std::reverse(result.begin(), result.end());
    return result;
}

}  // namespace secret_handshake
