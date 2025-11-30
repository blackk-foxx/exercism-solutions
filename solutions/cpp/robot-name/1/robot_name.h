#pragma once
#include <string>
#include <unordered_set>

namespace robot_name {

class robot {
public:
    robot();
    const std::string& name() const {return _name;};
    void reset();
private:
    std::string _name;
    static std::unordered_set<std::string> existing_names;
};

}  // namespace robot_name
