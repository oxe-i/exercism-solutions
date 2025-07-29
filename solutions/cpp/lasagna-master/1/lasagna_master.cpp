#include "lasagna_master.h"

#include <algorithm>
#include <numeric>

namespace lasagna_master {

auto preparationTime(const std::vector<std::string>& layers, int time_per_layer) -> int
{
    return time_per_layer * layers.size();
}

auto quantities(const std::vector<std::string>& layers) -> amount
{
    constexpr auto weight_per_noodles = 50;
    constexpr auto volume_per_sauce = 0.2;

    return std::accumulate(
        layers.begin(), layers.end(), amount{}, 
        [](amount& answer, const std::string& layer)
        {
            answer.noodles += weight_per_noodles * (layer == "noodles");
            answer.sauce += volume_per_sauce * (layer == "sauce");
            return answer;
        });
}

auto addSecretIngredient(std::vector<std::string>& mine, const std::vector<std::string>& other) -> void
{
    mine.back() = other.back();
}

auto addSecretIngredient(std::vector<std::string>& mine, std::string auntie) -> void
{
    mine.back() = auntie;
}

auto scaledQuantities(const std::vector<double>& quantities, int factor) -> std::vector<double>
{
    auto scaled = std::vector<double>(quantities.size());
    std::transform(
        quantities.begin(), quantities.end(), scaled.begin(),
        [factor](double amount)
        {
            return amount * factor;
        });
    return scaled;
}
}  // namespace lasagna_master
