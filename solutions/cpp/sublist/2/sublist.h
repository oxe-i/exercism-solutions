#pragma once

#include <optional>
#include <memory>

namespace sublist 
{
    struct List
    {
        std::optional<int> node;
        std::unique_ptr<List> tail;

        List() : node{}, tail{} {}
        template <typename... Ints> 
        List(int val, Ints... vals) : node{val}, tail{new List{vals...}} {}
    };

    enum class List_comparison 
    {
        equal, sublist, superlist, unequal
    };

    auto sublist(List fst, List snd) -> List_comparison;
}  // namespace sublist
