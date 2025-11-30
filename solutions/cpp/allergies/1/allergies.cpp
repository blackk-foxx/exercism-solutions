#include "allergies.h"
#include <array>

namespace allergies {

const std::array<std::string, 8> all_allergens = {
    "eggs",
    "peanuts",
    "shellfish",
    "strawberries",
    "tomatoes",
    "chocolate",
    "pollen",
    "cats"
};
    
allergy_test::allergy_test(unsigned code) {
    for (unsigned i = 0; i < all_allergens.size(); ++i)
        if (code & (1 << i))
            allergens.insert(all_allergens[i]);
}

bool allergy_test::is_allergic_to(const std::string& allergen) const {
    return allergens.find(allergen) != allergens.end();    
}

}  // namespace allergies
