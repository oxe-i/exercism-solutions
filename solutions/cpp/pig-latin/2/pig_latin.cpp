#include "pig_latin.h"

namespace pig_latin {
    using namespace play;

    auto does_it_begin_in_vowel(const String& text)
    {
        return contains({"aeiou"}, car(text)) or
            begins({"xr"}, text) or begins({"yt"}, text);
    }

    auto transform_consonant_word(const String& word) -> String
    {
        const auto sliced_by_middle_vowel = slice(
            [](char x){return contains({"aeiouy"}, x);},
            cdr(word)
        );

        if (is_empty(sliced_by_middle_vowel)) return append(word, {"ay"});

        const auto consonant_cluster = append(
                                        {car(word)}, 
                                        car(sliced_by_middle_vowel));

        
        if (ends({'q'}, consonant_cluster) and begins({'u'}, car(cdr(sliced_by_middle_vowel))))
            return append(
                drop(1, car(cdr(sliced_by_middle_vowel))),
                consonant_cluster,
                String{"uay"}
            );
        
        return append(
            car(cdr(sliced_by_middle_vowel)),
            consonant_cluster,
            String{"ay"}
        );
    }

    auto translate_word(const String& word) -> String
    {
        if (is_empty(word)) return {};
        if (does_it_begin_in_vowel(word)) return append(word, {"ay"});
        return transform_consonant_word(word);
    }

    auto translate(const String& text) -> String
    {
        if (is_empty(text)) return {};      
        return phrase(fmap(translate_word, extract(text)));
    }
}  // namespace pig_latin