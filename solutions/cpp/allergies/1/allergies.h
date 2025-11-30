#pragma once
#include <string>
#include <unordered_set>

namespace allergies {

class allergy_test {
public:
    allergy_test(unsigned code);
    bool is_allergic_to(const std::string& allergen) const;
    std::unordered_set<std::string> get_allergies() const {return allergens;};
private:
    std::unordered_set<std::string> allergens;
};

}  // namespace allergies
