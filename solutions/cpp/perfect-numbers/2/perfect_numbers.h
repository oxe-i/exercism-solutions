#if !defined(PERFECT_NUMBERS_H)
#define PERFECT_NUMBERS_H

namespace perfect_numbers 
{
    enum class classification {deficient, perfect, abundant};
    auto classify(const int) -> classification;
}  // namespace perfect_numbers

#endif  // PERFECT_NUMBERS_H