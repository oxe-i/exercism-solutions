#include "binary.h"

int convert(const char *input) {
    int res = {0};
    while (*input >= '0' && *input <= '1')
        res = (res << 1) | (*input++ == '1');
    return (*input == '\0')? res : INVALID;
}