#if !defined(REVERSE_STRING_H)
#define REVERSE_STRING_H

#include <string>
#include <string_view>

namespace reverse_string {
   auto reverse_string(std::string_view str) -> std::string
   {
       return str.empty() ? "" :
           reverse_string(
                {str.begin() + 1, str.size() - 1}) + str[0];
   }
}  // namespace reverse_string

#endif // REVERSE_STRING_H