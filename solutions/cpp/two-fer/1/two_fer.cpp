#include "two_fer.h"

namespace two_fer
{
	auto two_fer() -> std::string {
		return "One for you, one for me.";
	}
	
	auto two_fer(const std::string& name) -> std::string {
		return std::string{"One for "} + name + ", one for me.";
	}

} // namespace two_fer

