#ifndef KNAPSACK_H
#define KNAPSACK_H

#include <vector>

namespace knapsack
{

struct Item
{
    int weight;
    int value;
};

struct List
{
    std::vector<Item>::const_iterator pos;
    std::vector<Item>::const_iterator end;

    List(std::vector<Item>::const_iterator begin, std::vector<Item>::const_iterator end) : pos{begin}, end{end} {}
    List(const std::vector<Item>& items) : pos{items.cbegin()}, end{items.cend()} {}
};

auto maximum_value(int max_weight, List items) -> int;

} // namespace knapsack

#endif // KNAPSACK_H
