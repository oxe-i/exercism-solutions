#include "rna_transcription.h"

namespace rna_transcription {
   auto to_rna(std::string_view dna) -> sequence_of_nucleotides {
       auto convert = [] (const auto& nucleotide) {
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
           
           throw std::domain_error("invalid input");          
           return char{};          
       };

       auto rna = sequence_of_nucleotides{};
       
       std::transform(dna.cbegin(), dna.cend(), 
           std::back_inserter(rna), convert);

       return rna;
   }

    auto to_rna(const char& nucleotide) -> sequence_of_nucleotides {
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
        
        throw std::domain_error("invalid input");          
        return sequence_of_nucleotides{};
    }

}  // namespace rna_transcription
