#include "power_of_troy.h"

namespace troy {

void give_new_artifact(human& owner, const std::string& artifact_name) {
    owner.possession = std::make_unique<artifact>(artifact_name);
}

void exchange_artifacts(std::unique_ptr<artifact>& p1, std::unique_ptr<artifact>& p2) {
    std::swap(p1, p2);    
}

void manifest_power(human& owner, const std::string& power_name) {
    owner.own_power = std::make_shared<power>(power_name);
}

void use_power(human& caster, human& target) {
    target.influenced_by = caster.own_power;
}

int power_intensity(human& owner) {
    return owner.own_power.use_count();
}

}  // namespace troy
