#pragma once

namespace sublist 
{
    struct List
    {
        int* node;
        List* tail;

        ~List() {delete node; delete tail;}
        List() : node{}, tail{} {}
        template <typename... Ts> 
        List(int val, Ts... vals) : node{new int{val}}, tail{new List{vals...}} {}
    };

    enum class List_comparison 
    {
        equal, sublist, superlist, unequal
    };

    auto sublist(List fst, List snd) -> List_comparison;
}  // namespace sublist
