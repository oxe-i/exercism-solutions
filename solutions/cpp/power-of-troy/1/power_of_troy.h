#pragma once

#include <string>
#include <memory>

namespace troy {

struct artifact {
    // constructors needed (until C++20)
    artifact(std::string name) : name(name) {}
    std::string name;
};

struct power {
    // constructors needed (until C++20)
    power(std::string effect) : effect(effect) {}
    std::string effect;
};

struct human {
    std::unique_ptr<artifact> possession {};
    std::shared_ptr<power> own_power {};
    std::shared_ptr<power> influenced_by {};
};

auto give_new_artifact(human&, std::string) -> void;
auto exchange_artifacts(std::unique_ptr<artifact>&, std::unique_ptr<artifact>&) -> void;
auto manifest_power(human&, std::string) -> void;
auto use_power(const human&, human&) -> void;
auto power_intensity(const human&) -> int;

}  // namespace troy
