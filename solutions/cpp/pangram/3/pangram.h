#if !defined(PANGRAM_H)
#define PANGRAM_H

namespace pangram 
{
    constexpr auto is_pangram(const char* sentence)
    {
        unsigned int mapper {0};
        auto pangram_helper = [&mapper] (auto pangram_helper, const char* letter)
        {
            if (*letter == '\0') 
                return mapper == ((1U << 26) - 1);
            if (*letter >= 'A' and *letter <= 'Z')
                mapper |= (1U << (*letter - 'A'));
            if (*letter >= 'a' and *letter <= 'z')
                mapper |= (1U << (*letter - 'a'));
            return pangram_helper(pangram_helper, letter + 1);
        };
        return pangram_helper(pangram_helper, sentence);
    }
}  // namespace pangram

#endif // PANGRAM_H