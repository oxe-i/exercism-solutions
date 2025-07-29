#if !defined(RNA_TRANSCRIPTION_H)
#define RNA_TRANSCRIPTION_H

#include <string>
#include <string_view>
#include <algorithm>
#include <iterator>
#include <stdexcept>
#include <iostream>

namespace rna_transcription {   
    struct sequence_of_nucleotides {
    private:
        std::string sequence;
    public:
        using value_type = char;

        sequence_of_nucleotides() : sequence{} {}
        sequence_of_nucleotides(std::string&& input) : sequence{input} {}
        sequence_of_nucleotides(const std::string& input) : sequence{input} {}
        sequence_of_nucleotides(char&& input) : sequence{input} {}
        sequence_of_nucleotides(const char& input) : sequence{input} {}
        sequence_of_nucleotides(const char* input) : sequence{input} {}

        friend auto operator==(const sequence_of_nucleotides& fst, const sequence_of_nucleotides& sec) {
            return std::equal(fst.sequence.cbegin(), fst.sequence.cend(), sec.sequence.cbegin());
        }

        auto push_back(char elem) {
            sequence.push_back(std::move(elem));
        }
    };

    auto to_rna(std::string_view dna) -> sequence_of_nucleotides;
    auto to_rna(const char& nucleotide) -> sequence_of_nucleotides;
}  // namespace rna_transcription

#endif // RNA_TRANSCRIPTION_H