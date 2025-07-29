#include "rna_transcription.h"

namespace rna_transcription {
        auto convert(char nucleotide) -> char {
            switch (nucleotide) {
                case 'A':
                    return 'U';
                case 'T':
                    return 'A';
                case 'C':
                    return 'G';
                case 'G':
                    return 'C';
                default:
                    throw std::domain_error("invalid nucleotide.");
            }
            
            return char{};
        }

        auto to_rna(char nucleotide) -> char {           
            return convert(nucleotide);
        }
        
        auto to_rna(std::string dna) -> std::string { 
            std::transform(dna.cbegin(), dna.cend(), 
               dna.begin(), convert);
    
            return dna;
       }
}  // namespace rna_transcription
