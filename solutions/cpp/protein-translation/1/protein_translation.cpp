#include "protein_translation.h"

namespace protein_translation {
    const auto protein_table = std::unordered_map<std::string, std::string> {
        {"AUG", "Methionine"},
        {"UUU", "Phenylalanine"},
        {"UUC", "Phenylalanine"},
        {"UUA", "Leucine"},
        {"UUG", "Leucine"},
        {"UCU", "Serine"},
        {"UCC", "Serine"},
        {"UCA", "Serine"},
        {"UCG", "Serine"},
        {"UAU", "Tyrosine"},
        {"UAC", "Tyrosine"},
        {"UGU", "Cysteine"},
        {"UGC", "Cysteine"},
        {"UGG", "Tryptophan"}        
    };

    auto find_protein(const std::string& codon) -> std::string {
        return protein_table.at(codon);
    }

    auto proteins(const std::string& rna) -> std::vector<std::string> {
        if (rna.size() < std::size_t{3}) {
            throw std::domain_error("rna sequence is too short.");
        }
        
        auto protein_sequence = std::vector<std::string>{};

        auto codon_begin = rna.begin();
        
        while (true) { 
            auto codon = std::string{codon_begin, codon_begin + 3};

            if (codon == "UAA" or codon == "UAG" or codon == "UGA") {
                break;
            }
            
            protein_sequence.emplace_back(find_protein(codon));
            
            if (codon_begin + 6 <= std::end(rna)) {
                codon_begin += 3;
            }
            else {
                break;
            }            
        }

        return protein_sequence;
    }
}  // namespace protein_translation
