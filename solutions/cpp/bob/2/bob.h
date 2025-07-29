#if !defined(BOB_H)
#define BOB_H

#include <string_view>

namespace bob 
{
constexpr auto question = "Sure.";
constexpr auto yell = "Whoa, chill out!";
constexpr auto yell_question = "Calm down, I know what I'm doing!";
constexpr auto silence = "Fine. Be that way!";
constexpr auto generic = "Whatever.";

constexpr auto is_space(char letter)
{
    return letter == ' ' or letter == '\f' or letter == '\n' or
        letter == '\r' or letter == '\t' or letter == '\v';
}

constexpr auto uppercase(char letter)
{
    return letter >= 'A' and letter <= 'Z';
}

constexpr auto lowercase(char letter)
{
    return letter >= 'a' and letter <= 'z';
}

//constexpr solution with string_view and c_style string
constexpr auto hey(std::string_view dialogue) -> std::string_view
{
    char formatted[100] {};
    unsigned formatted_size{};
    for (unsigned original_index{}; original_index < dialogue.size(); ++original_index)
    {
        if (is_space(dialogue[original_index])) continue;
        formatted[formatted_size++] = dialogue[original_index];
    }
    
    if (not formatted_size) return silence;

    bool is_yelling {};
    for (unsigned index{}; index < formatted_size; ++index)
    {
        const auto letter = formatted[index];
        if (lowercase(letter))
        {
            is_yelling = false;
            break;
        }
        if (uppercase(letter))
            is_yelling = true;
    }

    const auto last_letter = formatted[formatted_size - 1];
    if (is_yelling and last_letter == '?') return yell_question;
    if (is_yelling) return yell;
    if (last_letter == '?') return question;

    return generic;
}
}  // namespace bob

#endif // BOB_H