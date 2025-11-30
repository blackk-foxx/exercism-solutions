#include <algorithm>
#include <array>
#include <cmath>
#include <iterator>
#include <numeric>
#include <sstream>
#include <string>
#include <vector>

constexpr int min_passing_score = 41;
constexpr int passing_letter_grade_count = 4;

// Round down all provided student scores.
std::vector<int> round_down_scores(const std::vector<double>& student_scores) {
    std::vector<int> result(student_scores.size());
    auto floor = [](double n) -> int { return std::floor(n); };
    std::transform(student_scores.cbegin(), student_scores.cend(), result.begin(), floor);
    return result;
}

// Count the number of failing students out of the group provided.
int count_failed_students(const std::vector<int>& student_scores) {
    auto is_failing = [](int n) -> bool { return n < min_passing_score; };
    return std::count_if(student_scores.cbegin(), student_scores.cend(), is_failing);
}

// Create a list of grade thresholds based on the provided highest grade.
std::array<int, passing_letter_grade_count> letter_grades(int highest_score) {
    const int passing_score_range = highest_score - min_passing_score;
    const int delta = std::ceil(static_cast<float>(passing_score_range) / passing_letter_grade_count);
    std::array<int, passing_letter_grade_count> result;
    for (auto i = 0; i < passing_letter_grade_count; i++)
        result[i] = min_passing_score + delta * i;
    return result;
}

// Organize the student's rank, name, and grade information in ascending order.
std::vector<std::string> student_ranking(
    const std::vector<int>& student_scores, const std::vector<std::string>& student_names
) {
    std::vector<std::string> result;
    auto format_entry = [](int rank, const std::string &name, int score) -> std::string {
        std::ostringstream entry;
        entry << rank << ". " << name << ": " << score;
        return entry.str();
    };
    for (auto i = 0; i < student_scores.size(); i++) {
        result.push_back(format_entry(i + 1, student_names.at(i), student_scores.at(i)));
    }
    return result;
}

// Create a string that contains the name of the first student to make a perfect
// score on the exam.
std::string perfect_score(
    const std::vector<int>& student_scores, const std::vector<std::string>& student_names
) {
    constexpr int perfect_score_value = 100;
    const auto perfect_score_iter = std::find(student_scores.cbegin(), student_scores.cend(), perfect_score_value);
    if (perfect_score_iter != student_scores.cend())
        return student_names.at(perfect_score_iter - student_scores.cbegin());
    return "";
}
