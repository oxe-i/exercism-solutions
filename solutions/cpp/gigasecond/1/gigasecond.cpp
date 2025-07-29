#include "gigasecond.h"

namespace gigasecond {

	auto advance(ptime date) -> ptime {
		auto tp = date + seconds(1'000'000'000);
		return tp;		
	}

}  // namespace gigasecond
