#include "scrabble_score.h"

const unsigned values[27] =
{
1, 3, 3, 2, 1, 4, 2, 4,
1, 8, 5, 1, 3, 1, 1, 3, 
10, 1, 1, 1, 1, 4, 4, 8, 
4, 10, 0
};

unsigned values_index(char letter)
{
    if (letter >= 'a' && letter <= 'z')
        return letter - 'a';
    if (letter >= 'A' && letter <= 'Z')
        return letter - 'A';
    return 26;
}

unsigned score(const char *word)
{
    unsigned sum = 0;
    unsigned index = 0;
    while (word[index] != '\0')
    {
        sum += values[values_index(word[index])];
        ++index;
    }
    return sum;
}