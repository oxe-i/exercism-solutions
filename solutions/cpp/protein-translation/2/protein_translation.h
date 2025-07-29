#if !defined(PROTEIN_TRANSLATION_H)
#define PROTEIN_TRANSLATION_H

#include <string>
#include <vector>

namespace protein_translation 
{
    auto proteins(const std::string&) -> std::vector<std::string>;
}  // namespace protein_translation

#endif  // PROTEIN_TRANSLATION_H
