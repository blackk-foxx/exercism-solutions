#pragma once
#include <map>
#include <string>
#include <vector>

namespace grade_school {

class school {
public:
    typedef std::vector<std::string> NameVector;
    typedef std::map<int, NameVector> Roster;
    const Roster& roster() const {return _roster;};
    void add(const std::string& name, int grade_level);
    const NameVector& grade(int level) const;
private:
    Roster _roster;
};

}  // namespace grade_school
