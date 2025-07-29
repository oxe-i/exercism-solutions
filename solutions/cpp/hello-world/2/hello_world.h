#if !defined(HELLO_WORLD_H)
#define HELLO_WORLD_H

#include <string_view>

namespace hello_world {

constexpr auto hello_world = "Hello, World!";

constexpr auto hello() -> std::string_view {
    return hello_world;
}

}  // namespace hello_world

#endif
