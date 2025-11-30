#include "grade_school.h"
#include <algorithm>

namespace grade_school {

void school::add(const std::string& name, int grade_level) {
    _roster[grade_level].push_back(name);
    std::sort(_roster[grade_level].begin(), _roster[grade_level].end());
}

const school::NameVector& school::grade(int grade_level) const {
    if (_roster.find(grade_level) == _roster.end()) {
        static const NameVector empty;
        return empty;
    }
    return _roster.at(grade_level);
}

}  // namespace grade_school
