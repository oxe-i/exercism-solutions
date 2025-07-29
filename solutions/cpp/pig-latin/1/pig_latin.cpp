#include "pig_latin.h"

#include <tuple>
#include <vector>
#include <algorithm>
#include <cctype>
#include <numeric>

namespace pig_latin {
    auto is_vowel(char letter) {
        return letter == 'a' or letter == 'e' or
            letter == 'i' or letter == 'o' or letter == 'u';
    }

    auto compound_beginning_vowel(std::string_view word) {
        return (word[0] == 'x' and word[1] == 'r') or
            (word[0] == 'y' and word[1] == 't');
    }

    auto beggining_vowel(std::string_view word) {
        return (not word.empty() and is_vowel(word.front())) or 
            (word.size() > 1 and compound_beginning_vowel(word));
    }

    auto middle_vowel_sound(char letter) {
        return is_vowel(letter) or (letter == 'y');
    }

    auto get_consonant_cluster(std::string_view word) {
        auto consonant_cluster = std::string{word[0]};
        auto index {1U};
        auto size {static_cast<unsigned>(word.size())};

        while (index < size and not middle_vowel_sound(word[index])) {        
            consonant_cluster += word[index];
            ++index;
        }

        return std::pair{consonant_cluster, index};
    }

    auto ends_in_qu(std::string_view word, unsigned index) {
        return index < static_cast<unsigned>(word.size()) and
            word[index] == 'u' and word[index - 1] == 'q';
    }

    auto translate_word(std::string_view word) -> std::string {
        if (beggining_vowel(word)) return std::string{word} + "ay";

        const auto [consonant, index] = get_consonant_cluster(word);

        return ends_in_qu(word, index) ?
            std::string{word.begin() + index + 1, word.end()} + 
                        consonant + 'u' + "ay" :
            std::string{word.begin() + index, word.end()} + 
                        consonant + "ay"; 
    }

    auto is_blank(char letter) -> bool {
        return std::isblank(letter);
    }

    auto translate(std::string_view text) -> std::string {
        auto list_of_words = std::vector<std::string_view> {};

        auto blank = std::find_if(
                        text.begin(), 
                        text.end(), 
                        is_blank);
        
        if (blank == text.end()) return translate_word(text);

        auto begin = text.begin();

        while (true) {
            list_of_words.emplace_back(
                                begin, 
                                std::distance(begin, blank));

            if (blank == text.end()) break;

            begin = blank + 1;
            blank = std::find_if(
                        blank + 1, 
                        text.end(), 
                        is_blank);
        }

        return std::accumulate(
                    list_of_words.begin() + 1,
                    list_of_words.end(),
                    translate_word(list_of_words.front()),
                    [](auto&& acc, auto word) {
                        return acc + " " + translate_word(word);});
    }
}  // namespace pig_latin
