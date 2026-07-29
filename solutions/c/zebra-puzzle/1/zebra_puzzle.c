#include "zebra_puzzle.h"

#include <stdint.h>
#include <stdlib.h>

static inline void swap(int8_t *a, int8_t *b) {
    int8_t t = *a;
    *a = *b;
    *b = t;
}

static inline void reset(int8_t *arr) {
    for (int8_t i = 0; i < 5; ++i) arr[i] = i;
}

static int next_permutation(int8_t *arr) {
    int i = 3;
    while (i >= 0 && arr[i] >= arr[i + 1]) {
        i--;
    }
    if (i < 0) return 0; 
    int j = 4;
    while (arr[j] <= arr[i]) {
        j--;
    }
    swap(&arr[i], &arr[j]);
    for (int l = i + 1, r = 4; l < r; l++, r--) { 
        swap(&arr[l], &arr[r]);
    }
    return 1;
}

typedef enum {
    Englishman,
    Spaniard,
    Ukrainian,
    Norwegian,
    Japanese
} nationality_t;

typedef enum {
    red,
    green,
    ivory,
    yellow,
    blue
} color_t;

typedef enum {
    dog,
    snail,
    fox,
    horse,
    zebra
} pet_t;

typedef enum {
    coffee,
    tea,
    milk,
    juice,
    water
} drink_t;

typedef enum {
    dancing,
    painting,
    reading,
    football,
    chess
} hooby_t;

typedef struct {
    int8_t color[5];
    int8_t nation[5];
    int8_t pet[5];
    int8_t drink[5];
    int8_t hobby[5];
} puzzle_t;

static const char *nations[] = {
    "Englishman",
    "Spaniard",
    "Ukrainian",
    "Norwegian",
    "Japanese"
};

solution_t solve_puzzle(void) {
    solution_t solution = {0};
    puzzle_t puzzle;
    reset(puzzle.color);
    do {
        if (puzzle.color[green] != puzzle.color[ivory] + 1) continue; // rule 6
        reset(puzzle.nation);
        do {
            if (puzzle.nation[Norwegian] != 0) continue; // rule 10
            if (puzzle.nation[Englishman] != puzzle.color[red]) continue; // rule 2
            if (abs(puzzle.nation[Norwegian] - puzzle.color[blue]) != 1) continue; //rule 15
            reset(puzzle.hobby);
            do {
                if (puzzle.hobby[painting] != puzzle.color[yellow]) continue; // rule 8
                if (puzzle.hobby[chess] != puzzle.nation[Japanese]) continue; // rule 14
                reset(puzzle.pet);
                do {
                    if (puzzle.pet[dog] != puzzle.nation[Spaniard]) continue; // rule 3
                    if (puzzle.pet[snail] != puzzle.hobby[painting]) continue; // rule 7
                    if (abs(puzzle.pet[fox] - puzzle.hobby[reading]) != 1) continue; // rule 11
                    if (abs(puzzle.pet[horse] - puzzle.hobby[painting]) != 1) continue; // rule 12
                    reset(puzzle.drink);
                    do {
                        if (puzzle.drink[milk] != 2) continue; // rule 9
                        if (puzzle.drink[coffee] != puzzle.color[green]) continue; // rule 4
                        if (puzzle.drink[tea] != puzzle.nation[Ukrainian]) continue; // rule 5
                        if (puzzle.drink[juice] != puzzle.hobby[football]) continue; // rule 13
                        for (int i = 0; i < 5; ++i) {
                            if (puzzle.nation[i] == puzzle.drink[water]) solution.drinks_water = nations[i];
                            if (puzzle.nation[i] == puzzle.pet[zebra]) solution.owns_zebra = nations[i];
                        }
                        return solution;
                    } while (next_permutation(puzzle.drink));
                } while (next_permutation(puzzle.pet));
            } while (next_permutation(puzzle.hobby));
        } while (next_permutation(puzzle.nation));
    } while (next_permutation(puzzle.color));

    return solution;
}