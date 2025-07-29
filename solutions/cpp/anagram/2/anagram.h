#if !defined(ANAGRAM_H)
#define ANAGRAM_H

#include <vector>
#include <string>
#include <algorithm>
#include <array>
#include <cstdint>
#include <cctype>

namespace anagram {
	class anagram {
	private:
		std::string m_word;
		std::array<uint8_t, 26> m_base;
	public:
		anagram(const std::string& word);
		auto matches(std::vector<std::string> candidates) -> std::vector<std::string>;
	};
}  // namespace anagram

#endif // ANAGRAM_H
