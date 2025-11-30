#include "lasagna_master.h"
#include <algorithm>

namespace lasagna_master {

int preparationTime(const StringVector& layers, int averagePrepTime) {
    return layers.size() * averagePrepTime;    
}

static int getIngredientCount(const StringVector& layers, const std::string& ingredient) {
    return std::count_if(
        layers.cbegin(), 
        layers.cend(), 
        [ingredient](const std::string& l){return l == ingredient;}
    );
}

amount quantities(const StringVector& layers) {
    amount result;
    constexpr int noodlesUnit = 50;
    constexpr double sauceUnit = 0.2;
    result.noodles = noodlesUnit * getIngredientCount(layers, "noodles");
    result.sauce = sauceUnit * getIngredientCount(layers, "sauce");
    return result;
}

void addSecretIngredient(StringVector& myIngredients, const StringVector& theirIngredients) {
    myIngredients.back() = theirIngredients.back();
}

void addSecretIngredient(StringVector& myIngredients, const std::string& newIngredient) {
    myIngredients.back() = newIngredient;
}

std::vector<double> scaleRecipe(
    const std::vector<double>& quantitiesForStandardPortionCount, int portionsNeeded
) {
    constexpr int standardPortionCount = 2;
    std::vector<double> result(quantitiesForStandardPortionCount.size());
    std::transform(
        quantitiesForStandardPortionCount.cbegin(), 
        quantitiesForStandardPortionCount.cend(), 
        result.begin(),
        [portionsNeeded](double quantity){return quantity * portionsNeeded / standardPortionCount;}
    );
    return result;
}

}  // namespace lasagna_master

