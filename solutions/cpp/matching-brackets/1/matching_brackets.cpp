#include "matching_brackets.h"

#include <vector>

namespace matching_brackets {

    auto mismatching_bracket(const std::vector<char>& open, char closing)
    {
        return open.empty() or 
            (closing == ')' and not (open.back() == '(')) or
            (closing == ']' and not (open.back() == '[')) or
            (closing == '}' and not (open.back() == '{'));
    }

    auto check(const std::string& expression) -> bool {
        auto open = std::vector<char>{};

        for (auto& character : expression)
        {
            switch (character)
            {
                case '(':
                case '[':
                case '{':
                    open.emplace_back(character);
                    break;
                case ')':
                    if (mismatching_bracket(open, character))
                        return false;
                    open.pop_back();
                    break;
                case ']':
                    if (mismatching_bracket(open, character))
                        return false;
                    open.pop_back();
                    break;
                case '}':
                    if (mismatching_bracket(open, character))
                        return false;
                    open.pop_back();
                    break;                    
            }
        }

        return open.empty();
    }
}  // namespace matching_brackets
