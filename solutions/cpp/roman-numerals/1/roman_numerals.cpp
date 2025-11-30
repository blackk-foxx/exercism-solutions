#include "roman_numerals.h"
#include <map>

namespace roman_numerals {

struct {
    std::string symbol;
    unsigned symbol_value;
    unsigned next_value;
    unsigned order;
} table[] = {
    {"I", 1, 5, 1},
    {"V", 5, 10, 1},
    {"X", 10, 50, 10},
    {"L", 50, 100, 10},
    {"C", 100, 500, 100},
    {"D", 500, 1000, 100},
    {"M", 1000, 5000, 1000},
};

constexpr size_t TABLE_SIZE = sizeof(table)/sizeof(table[0]);

std::string convert(unsigned int n) {
    if (n == 0)
        return "";

    for (size_t i = 0; i < TABLE_SIZE; ++i) {
        if (n < table[i].next_value - table[i].order)
            return 
                table[i].symbol + 
                convert(n - table[i].symbol_value);
        if (n < table[i].next_value)
            return 
                convert(table[i].order) + 
                convert(table[i].next_value) + 
                convert(n - (table[i].next_value - table[i].order));
    }
    return "";
}

}  // namespace roman_numerals
