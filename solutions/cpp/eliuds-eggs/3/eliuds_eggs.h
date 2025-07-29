#pragma once

namespace chicken_coop {
[[gnu::const]] constexpr auto positions_to_quantity(unsigned pos)
{
    if (not pos) return 0U;
    return (pos & 1) + positions_to_quantity(pos >> 1);  
}
}  // namespace chicken_coop
