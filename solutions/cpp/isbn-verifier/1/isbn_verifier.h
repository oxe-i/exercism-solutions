#if !defined(ISBN_VERIFIER_H)
#define ISBN_VERIFIER_H

#include <string>
#include <numeric>
#include <algorithm>
#include <cctype>

namespace isbn_verifier {
    auto is_valid(const std::string& isbn) -> bool;
} // namespace isbn_verifier

#endif // ISBN_VERIFIER_H