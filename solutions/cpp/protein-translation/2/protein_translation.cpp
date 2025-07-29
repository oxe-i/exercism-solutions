#include "protein_translation.h"

#include <unordered_map>
#include <stdexcept>

namespace protein_translation 
{
    auto mapping_from_codon_to_protein = std::unordered_map<std::string, std::string>
    {
        std::pair<std::string, std::string>{"AUG", "Methionine"},
        {"UUU", "Phenylalanine"}, {"UUC", "Phenylalanine"},
        {"UUA", "Leucine"}, {"UUG", "Leucine"},
        {"UCU", "Serine"}, {"UCC", "Serine"}, {"UCA", "Serine"}, {"UCG", "Serine"},
        {"UAU", "Tyrosine"}, {"UAC", "Tyrosine"},
        {"UGU", "Cysteine"}, {"UGC", "Cysteine"},
        {"UGG", "Tryptophan"},
        {"UAA", "STOP"}, {"UAG", "STOP"}, {"UGA", "STOP"}
    };
    
    auto proteins(const std::string& rna) -> std::vector<std::string>
    {
        auto list_of_proteins = std::vector<std::string>{};
        list_of_proteins.reserve(rna.size() / 3);

        auto codon_begin = rna.begin();
        auto codon_end = codon_begin + 3;
        
        while (codon_end <= rna.end())
        {
            auto codon = std::string{codon_begin, codon_end};
            try
            {
                auto protein = mapping_from_codon_to_protein.at(codon);
                if (protein == "STOP")
                {
                    list_of_proteins.shrink_to_fit();
                    return list_of_proteins;
                }
                list_of_proteins.push_back(protein);
            }
            catch (const std::exception& invalid_codon)
            {
                list_of_proteins.shrink_to_fit();
                return list_of_proteins;
            }
            codon_begin += 3;
            codon_end = codon_begin + 3;
        }

        return list_of_proteins;
    }
}  // namespace protein_translation
