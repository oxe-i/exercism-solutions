#if !defined(PROTEIN_TRANSLATION_H)
#define PROTEIN_TRANSLATION_H

#include <vector>
#include <string>
#include <unordered_map>
#include <stdexcept>

namespace protein_translation {
    auto proteins(const std::string& rna) -> std::vector<std::string>;
}  // namespace protein_translation

#endif // PROTEIN_TRANSLATION_H
