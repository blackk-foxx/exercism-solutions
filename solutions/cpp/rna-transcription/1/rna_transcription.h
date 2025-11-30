#pragma once
#include <string>

namespace rna_transcription {

char to_rna(char dna);
std::string to_rna(const std::string& dna);

}  // namespace rna_transcription
