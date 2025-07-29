#include "acronym.h"

#include <stdlib.h>
#include <string.h>

int is_separator(char val) {
    char separator[5] = {9, 10, 13, 32, '-'};
    for (int i = 0; i < 5; ++i) {
        if (val == separator[i]) { return 1; }
    }
    return 0;
}

int is_alpha(char val) {
    return (val >= 'a' && val <= 'z') ||
           (val >= 'A' && val <= 'Z');
}

uint32_t string_length(const char *string) {
    uint32_t length = 0;
    while (string[length] != '\0') { length++; }
    return length;
}

char *abbreviate(const char *phrase) {
    if (!phrase) return NULL;

    const uint32_t phrase_length = string_length(phrase);

    if (!phrase_length) return NULL;
    
    char abbreviation[phrase_length];
    
    uint32_t abbreviation_length = 0;
    int is_start = 1;
    
    for (uint32_t idx = 0; idx < phrase_length; ++idx) {
        if (is_start && is_alpha(phrase[idx])) { 
            abbreviation[abbreviation_length++] = phrase[idx] <= 'Z'? phrase[idx] : phrase[idx] - 'a' + 'A'; 
            is_start = 0;
            continue;
        }

        if (is_separator(phrase[idx])) { is_start = 1; }
    }

    char *answer = malloc(sizeof(char) * abbreviation_length);
    memcpy(answer, abbreviation, sizeof(char) * abbreviation_length);
    answer[abbreviation_length] = '\0';
    
    return answer;
}