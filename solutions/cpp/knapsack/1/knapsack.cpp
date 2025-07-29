#include "knapsack.h"

namespace knapsack
{
    auto maximum_value(int max_weight, List items) -> int
    {
        if (items.pos == items.end or max_weight == 0) return 0;

        if (items.pos->weight > max_weight)
            return maximum_value(max_weight, {items.pos + 1, items.end});

        return std::max(
                items.pos->value + maximum_value(
                                        max_weight - items.pos->weight,
                                        {items.pos + 1, items.end}),
                maximum_value(max_weight, {items.pos + 1, items.end}));
    }
} // namespace knapsack

