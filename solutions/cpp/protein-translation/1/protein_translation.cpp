#include "protein_translation.h"
#include <unordered_map>
#include <unordered_set>

namespace protein_translation {

const std::unordered_map<std::string, std::string> protein_for_codon = {
    {"AUG", "Methionine"},
    {"UAC", "Tyrosine"},
    {"UAU", "Tyrosine"},
    {"UCA", "Serine"},
    {"UCC", "Serine"},
    {"UCG", "Serine"},
    {"UCU", "Serine"},
    {"UGC", "Cysteine"},
    {"UGG", "Tryptophan"},
    {"UGU", "Cysteine"},
    {"UUA", "Leucine"},
    {"UUC", "Phenylalanine"},
    {"UUG", "Leucine"},
    {"UUU", "Phenylalanine"}
};

bool is_stop_sequence(const std::string& codon) {
    static const std::unordered_set<std::string> stop_sequences = {
        "UAA", "UAG", "UGA"
    };
    return (stop_sequences.find(codon) != stop_sequences.end());
}

std::vector<std::string> proteins(const std::string& rna) {
    constexpr unsigned CODON_LENGTH = 3;
    std::vector<std::string> result;
    for (unsigned i = 0; i < rna.size(); i += CODON_LENGTH) {
        const auto codon = rna.substr(i, CODON_LENGTH);
        if (is_stop_sequence(codon)) break;
        result.push_back(protein_for_codon.at(codon));
    }
    return result;
}

}  // namespace protein_translation
