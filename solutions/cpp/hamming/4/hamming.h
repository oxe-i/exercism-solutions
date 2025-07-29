#if !defined(HAMMING_H)
#define HAMMING_H

#include <stdexcept>

namespace hamming {
   using strand = const char*;
   constexpr auto compute(strand fst, strand snd) -> unsigned {
       if (*fst == '\0' and *snd == '\0') 
            return 0;
       if (*fst == '\0' or *snd == '\0') 
            throw std::domain_error("Strands of different sizes.");
       return (*fst != *snd) + compute(fst + 1, snd + 1);
   }
}  // namespace hamming

#endif // HAMMING_H