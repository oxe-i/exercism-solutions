#pragma once

#include <vector>
#include <string>

namespace lasagna_master {

struct amount {
    int noodles;
    double sauce;
};

auto preparationTime(const std::vector<std::string>&, int time_per_layer = 2) -> int;
auto quantities(const std::vector<std::string>&) -> amount;
auto addSecretIngredient(std::vector<std::string>&, const std::vector<std::string>&) -> void;
auto addSecretIngredient(std::vector<std::string>&, std::string) -> void;
auto scaledQuantities(const std::vector<double>&, int) -> std::vector<double>;
}  // namespace lasagna_master
