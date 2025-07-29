#include "speedywagon.h"

namespace speedywagon {

// Enter your code below:
bool connection_check(pillar_men_sensor* sensor) { return sensor; }
int activity_counter(pillar_men_sensor* arr, unsigned capacity) { return capacity ? arr->activity + activity_counter(arr + 1, capacity - 1) : 0; }
bool alarm_control(pillar_men_sensor* sensor) { return connection_check(sensor) and sensor->activity > 0; }
bool uv_alarm(pillar_men_sensor* sensor) { return connection_check(sensor) and uv_light_heuristic(&sensor->data) > sensor->activity; }
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

}  // namespace speedywagon
