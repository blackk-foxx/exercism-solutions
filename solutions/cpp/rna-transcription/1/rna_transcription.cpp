#include "rna_transcription.h"
#include <algorithm>

namespace rna_transcription {

char to_rna(char dna) {
    static const char rna_complement[] = "U G   C            A";
    return rna_complement[dna - 'A'];
}

std::string to_rna(const std::string& dna) {
    std::string result;
    for (auto c: dna)
        result.push_back(to_rna(c));
    return result;
}

}  // namespace rna_transcription
