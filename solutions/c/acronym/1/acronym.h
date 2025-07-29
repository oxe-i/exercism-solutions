#ifndef ACRONYM_H
#define ACRONYM_H

#include <stdint.h>

int is_separator(char val);
int is_alpha(char val);
uint32_t string_length(const char *string);

char *abbreviate(const char *phrase);

#endif
