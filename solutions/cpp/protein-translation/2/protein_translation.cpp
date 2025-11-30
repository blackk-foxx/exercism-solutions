#include "protein_translation.h"
#include <unordered_map>
#include <unordered_set>

static const std::unordered_map<std::string_view, std::string> protein_for_codon = {
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

static const std::unordered_set<std::string_view> stop_sequences = {
    "UAA", "UAG", "UGA"
};

static bool is_stop_sequence(std::string_view codon) {
    return (stop_sequences.find(codon) != stop_sequences.end());
}

namespace protein_translation {

std::vector<std::string> proteins(std::string_view rna) {
    constexpr unsigned codon_length = 3;
    std::vector<std::string> result;
    for (unsigned i = 0; i < rna.size(); i += codon_length) {
        const auto codon = rna.substr(i, codon_length);
        if (is_stop_sequence(codon)) break;
        result.push_back(protein_for_codon.at(codon));
    }
    return result;
}

}  // namespace protein_translation
