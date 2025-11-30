#include "reverse_string.h"
#include <deque>

namespace reverse_string {

std::string reverse_string(const std::string& s) {
    std::string result(s.rbegin(), s.rend());
    return result;
}

}  // namespace reverse_string
