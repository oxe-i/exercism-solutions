#include "queen_attack.h"

#define ABS(x) ( (x) >= 0 ? (x) : -(x) )

attack_status_t can_attack(position_t queen_1, position_t queen_2) {
    if (queen_1.row > 7 || queen_1.column > 7 || queen_2.row > 7 || queen_2.column > 7) {
        return INVALID_POSITION;
    }
    
    if (queen_1.row == queen_2.row) {
        if (queen_1.column == queen_2.column) return INVALID_POSITION;
        return CAN_ATTACK;
    }

    if (queen_1.column == queen_2.column) return CAN_ATTACK;

    const int diff_row = queen_1.row - queen_2.row;
    const int diff_col = queen_1.column - queen_2.column;

    if (ABS(diff_row) == ABS(diff_col)) return CAN_ATTACK;

    return CAN_NOT_ATTACK;
}