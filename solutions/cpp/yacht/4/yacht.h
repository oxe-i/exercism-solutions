#pragma once

#include <array>
#include <functional>
#include <type_traits>

namespace yacht {
    using dice_t = std::array<int, 5>;

    template <typename Function, typename... Args>
    constexpr auto curry(Function fun, Args... args) {
        if constexpr (std::is_invocable_v<Function, Args...>)
            return std::invoke(fun, args...);
        else
            return [fun, args...] (auto... new_args) {
                return curry(fun, args..., new_args...);
            };
    }

    constexpr auto number_categories(int number, const dice_t& roll) {
        auto sum = 0;
        for (const auto& die : roll)
            sum += number * (die == number);
        return sum;
    }

    constexpr auto get_dice_frequency(const dice_t& roll) {
        auto map_of_frequencies = std::array<int, 6>{};
        for (const auto& die : roll)
            map_of_frequencies[die - 1]++;
        return map_of_frequencies;
    }

    constexpr auto conditional_sum = curry([](auto condition, auto sum_logic, const dice_t& roll) {
        const auto frequencies = get_dice_frequency(roll);
        auto sum = 0;
    
        for (auto number = 1; number <= 6; ++number) {
            const auto frequency = frequencies[number - 1];
            if (condition(number, frequency)) return 0;
            sum = sum_logic(number, frequency, sum);
        }    
        
        return sum;
    });

    constexpr auto ones = curry(number_categories, 1);
    constexpr auto twos = curry(number_categories, 2);
    constexpr auto threes = curry(number_categories, 3);
    constexpr auto fours = curry(number_categories, 4);
    constexpr auto fives = curry(number_categories, 5);
    constexpr auto sixes = curry(number_categories, 6);

    constexpr auto full_house = conditional_sum(
                                    [](int, int frequency){return frequency and (frequency > 3 or frequency < 2);},
                                    [](int number, int frequency, int sum){return sum + (number * frequency);});

    constexpr auto four_of_a_kind = conditional_sum(
                                        [](int, int frequency){return frequency > 1 and frequency < 4;},
                                        [](int number, int frequency, int sum) {return frequency >= 4 ? number * 4 : sum;});

    constexpr auto little_straight = conditional_sum(
                                        [](int number, int frequency) {return number < 6 and frequency != 1;},
                                        [](int, int, int) {return 30;});

    constexpr auto big_straight = conditional_sum(
                                    [](int number, int frequency){return number > 1 and frequency != 1;},
                                    [](int, int, int) {return 30;});

    constexpr auto choice = curry([](const dice_t& roll) {
        const auto frequencies = get_dice_frequency(roll);

        auto sum = 0;
        for (auto number = 1; number <= 6; ++number)
            sum += (number * frequencies[number - 1]);
        return sum;
    });

    constexpr auto yacht = conditional_sum(
                                [](int, int frequency){return frequency and frequency != 5;},
                                [](int, int, int) {return 50;});

    constexpr auto compare(const char* fst, const char* snd) -> bool {
        return (*fst == '\0' and *snd == '\0') or
            (*fst == *snd and compare(fst + 1, snd + 1));
    }

    constexpr auto score(const dice_t& roll, const char* category) -> int {
        if (compare(category, "ones")) return ones(roll);
        if (compare(category, "twos")) return twos(roll);
        if (compare(category, "threes")) return threes(roll);
        if (compare(category, "fours")) return fours(roll);
        if (compare(category, "fives")) return fives(roll);
        if (compare(category, "sixes")) return sixes(roll);
        if (compare(category, "full house")) return full_house(roll);
        if (compare(category, "four of a kind")) return four_of_a_kind(roll);
        if (compare(category, "little straight")) return little_straight(roll);
        if (compare(category, "big straight")) return big_straight(roll);
        if (compare(category, "choice")) return choice(roll);
        return yacht(roll);
    }
}  // namespace yacht
