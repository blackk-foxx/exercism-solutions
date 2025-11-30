#include <string>
#include <vector>
#pragma once


typedef std::vector<std::string> StringVector;

namespace lasagna_master {

struct amount {
    int noodles;
    double sauce;
};

int preparationTime(const StringVector& layers, int averagePrepTime = 2);

amount quantities(const StringVector& layers);

void addSecretIngredient(StringVector& myIngredients, const StringVector& theirIngredients);

void addSecretIngredient(StringVector& myIngredients, const std::string& newIngredient);

std::vector<double> scaleRecipe(const std::vector<double>& quantities, int multiplier);

}  // namespace lasagna_master
