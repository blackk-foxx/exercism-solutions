#include "speedywagon.h"

namespace speedywagon {

// Enter your code below:

// Please don't change the interface of the uv_light_heuristic function
int uv_light_heuristic(std::vector<int>* data_array) {
    double avg{};
    for (auto element : *data_array) {
        avg += element;
    }
    avg /= data_array->size();
    int uv_index{};
    for (auto element : *data_array) {
        if (element > avg) ++uv_index;
    }
    return uv_index;
}

bool connection_check(const pillar_men_sensor* sensor) {
    return sensor != nullptr;
}

int activity_counter(const pillar_men_sensor* sensors, int count) {
    int result = 0;
    auto s = sensors;
    for (auto i = 0; i < count; i++, s++) {
        result += s->activity;
    }
    return result;
}

bool alarm_control(const pillar_men_sensor* sensor) {
    if (sensor == nullptr)
        return false;
    return sensor->activity > 0;
}

bool uv_alarm(pillar_men_sensor* sensor) {
    if (sensor == nullptr)
        return false;
    return uv_light_heuristic(&sensor->data) > sensor->activity;
}

}  // namespace speedywagon
