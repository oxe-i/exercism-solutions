#if !defined(ETL_H)
#define ETL_H

#include <vector>
#include <map>
#include <numeric>
#include <cctype>

namespace etl {
    auto transform(const std::map<int, std::vector<char>>& old) -> std::map<char, int>;
}  // namespace etl

#endif // ETL_H