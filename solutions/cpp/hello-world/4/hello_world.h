#if !defined(HELLO_WORLD_H)
#define HELLO_WORLD_H

#include <string_view>

namespace hello_world {

constexpr auto hello() {return std::string_view{"Hello, World!"};}

}  // namespace hello_world

#endif
