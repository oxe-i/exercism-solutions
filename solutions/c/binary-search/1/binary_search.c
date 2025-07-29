#include "binary_search.h"

const int *binary_search(int value, const int *arr, size_t length)
{
    if (!length) return NULL;
    
    size_t mid = (length - 1) >> 1;
    if (arr[mid] == value)
        return &arr[mid];
    if (arr[mid] > value)
        return binary_search(value, arr, length - mid - 1);
    return binary_search(value, &arr[mid + 1], length - mid - 1);
}
