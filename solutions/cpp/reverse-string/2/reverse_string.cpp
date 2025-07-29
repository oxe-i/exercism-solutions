#include "reverse_string.h"

namespace reverse_string {
    //the most straightforward solution uses std::reverse, which has the same efficiency of the following approach
    auto reverse_string(std::string sequence) -> std::string {
        auto begin_iterator = sequence.begin();
        auto end_iterator = sequence.end() - 1;

        while (begin_iterator < end_iterator) {
            std::iter_swap(begin_iterator, end_iterator); //similar to std::swap, but doesn't need to explicitly dereference iterator
            begin_iterator++;
            end_iterator--;
        }

        return sequence;
    }
}  // namespace reverse_string
