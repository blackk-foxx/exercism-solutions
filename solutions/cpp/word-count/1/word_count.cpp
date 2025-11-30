#include "word_count.h"
#include <functional>
#include <vector>

class Parser {
public:
    std::vector<std::string> parse(std::string_view s);
private:
    enum class State {
        SEEKING_WORD,
        ACCUMULATING_WORD,
        FOLLOWING_APOSTROPHE,
    } state = State::SEEKING_WORD;
    std::string word;
    std::vector<std::string> words;

    void handle_initial_state();
    void handle_SEEKING_WORD(char c);
    void handle_ACCUMULATING_WORD(char c);
    void handle_FOLLOWING_APOSTROPHE(char c);
    void handle_end_state();
};

void Parser::handle_initial_state() {
    word.clear();
    words.clear();
}

void Parser::handle_SEEKING_WORD(char c) {
    if (isalnum(c)) {
        word.push_back(tolower(c));
        state = State::ACCUMULATING_WORD;
    }
}

void Parser::handle_ACCUMULATING_WORD(char c) {
    if (isalnum(c))
        word.push_back(tolower(c));
    else if (c == '\'')
        state = State::FOLLOWING_APOSTROPHE;
    else {
        words.push_back(word);
        word.clear();
        state = State::SEEKING_WORD;
    }
}

void Parser::handle_FOLLOWING_APOSTROPHE(char c) {
    if (isalnum(c)) {
        word.push_back('\'');
        word.push_back(tolower(c));
        state = State::ACCUMULATING_WORD;
    }
    else {
        words.push_back(word);
        word.clear();
        state = State::SEEKING_WORD;
    }
}

void Parser::handle_end_state() {
    if (word.size() > 0)
        words.push_back(word);
}

std::vector<std::string> Parser::parse(std::string_view sentence) {
    const std::map<State, std::function<void(char)>> handler_for_state = {
        {State::SEEKING_WORD, std::bind(&Parser::handle_SEEKING_WORD, this, std::placeholders::_1)},
        {State::ACCUMULATING_WORD, std::bind(&Parser::handle_ACCUMULATING_WORD, this, std::placeholders::_1)},
        {State::FOLLOWING_APOSTROPHE, std::bind(&Parser::handle_FOLLOWING_APOSTROPHE, this, std::placeholders::_1)},
    };

    handle_initial_state();
    for (auto c: sentence)
        handler_for_state.at(state)(c);
    handle_end_state();
    return words;
}

namespace word_count {

std::map<std::string, int> words(std::string sentence) {
    std::map<std::string, int> result;
    for (const auto& word: Parser().parse(sentence))
        result[word]++;
    return result;
}

}  // namespace word_count
