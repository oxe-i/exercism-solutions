#include "rna_transcription.h"

namespace rna_transcription {
        auto convert(char nucleotide) -> char {
            if (nucleotide == 'A') {
                return 'U';
            }
            else if (nucleotide == 'T') {
                return 'A';
            }
            else if (nucleotide == 'C') {
                return 'G';
            }
            else if (nucleotide == 'G') {
                return 'C';
            }

            throw std::domain_error("invalid nucleotide");          
            return char{};
        }

        auto to_rna(char dna) -> char {           
            return convert(dna);
        }
        
        auto to_rna(std::string dna) -> std::string { 
            if (dna.empty()) {
                throw std::domain_error("there's no nucleotide.");
            }
           
            std::transform(dna.cbegin(), dna.cend(), 
               dna.begin(), convert);
    
            return dna;
       }
}  // namespace rna_transcription
