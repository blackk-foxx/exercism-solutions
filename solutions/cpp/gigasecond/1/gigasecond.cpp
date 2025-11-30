#include "gigasecond.h"

namespace gigasecond {
using namespace boost::posix_time;

ptime advance(const ptime& t) {
    return t + seconds(1000000000);
}

}  // namespace gigasecond
