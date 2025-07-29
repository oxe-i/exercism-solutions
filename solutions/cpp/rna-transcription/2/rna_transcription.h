#if !defined(RNA_TRANSCRIPTION_H)
#define RNA_TRANSCRIPTION_H

#include <string>
#include <algorithm>
#include <stdexcept>

namespace rna_transcription {
    auto convert(char nucleotide) -> char;
    auto to_rna(char input) -> char;
    auto to_rna(std::string input) -> std::string;
}  // namespace rna_transcription

#endif // RNA_TRANSCRIPTION_H