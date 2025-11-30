#include <algorithm>
#include <array>
#include <cmath>
#include <iterator>
#include <numeric>
#include <sstream>
#include <string>
#include <vector>

// Round down all provided student scores.
std::vector<int> round_down_scores(std::vector<double> student_scores) {
    std::vector<int> result;
    auto floor = [](double n) { return static_cast<int>(std::floor(n)); };
    std::transform(student_scores.begin(), student_scores.end(), std::back_inserter(result), floor);
    return result;
}

// Count the number of failing students out of the group provided.
int count_failed_students(std::vector<int> student_scores) {
    auto is_failing = [](int &n) { return n <= 40; };
    return std::count_if(student_scores.begin(), student_scores.end(), is_failing);
}

// Create a list of grade thresholds based on the provided highest grade.
std::array<int, 4> letter_grades(int highest_score) {
    constexpr int min_passing_score = 41;
    const int passing_score_range = highest_score - min_passing_score;
    const int delta = ceil(static_cast<float>(passing_score_range) / 4);
    std::array<int, 4> result;
    std::iota(result.begin(), result.end(), 0);
    auto calculate_threshold = [delta](int n) { return min_passing_score + delta * n; };
    std::transform(result.begin(), result.end(), result.begin(), calculate_threshold);
    return result;
}

// Organize the student's rank, name, and grade information in ascending order.
std::vector<std::string> student_ranking(
    std::vector<int> student_scores, std::vector<std::string> student_names) {
    std::vector<std::string> result;
    auto format_entry = [](int rank, const std::string &name, int score) {
        std::ostringstream entry;
        entry << rank << ". " << name << ": " << score;
        return entry.str();
    };
    for (auto i = 0; i < student_scores.size(); i++) {
        result.push_back(format_entry(i + 1, student_names[i], student_scores[i]));
    }
    return result;
}

// Create a string that contains the name of the first student to make a perfect
// score on the exam.
std::string perfect_score(std::vector<int> student_scores,
                          std::vector<std::string> student_names) {
    auto perfect_score_iter = std::find(student_scores.begin(), student_scores.end(), 100);
    if (perfect_score_iter != student_scores.end())
        return student_names.at(perfect_score_iter - student_scores.begin());
    return "";
}
