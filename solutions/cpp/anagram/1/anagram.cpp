#include "anagram.h"

namespace anagram {
    auto find_index(unsigned char alpha) -> uint8_t {
        return std::tolower(alpha) - 'a';
    }

    auto count_letters(const std::string& word) -> std::array<uint8_t, 26> {
        auto counter = std::array<uint8_t, 26> {};

        std::for_each(word.begin(), word.end(), 
		[&] (auto letter) {
			const auto index = find_index(letter);
			counter[index]++;
		});

        return counter;
    }
    
    auto get_first_word(std::string& word) -> void {
    	word.erase(
    		std::find_if(word.begin(), word.end(),
			[](unsigned char character) {
				return not std::isalpha(character);
			}),
		word.end());
    }
    
    auto to_lower_case(std::string& word) -> void {		
    	std::transform(word.cbegin(), word.cend(), word.begin(), 
			[] (unsigned char letter) {
				return std::tolower(letter);
        		});
    }

    auto not_anagram(std::string& word, const std::string& m_word, const std::array<uint8_t, 26>& base) -> bool {    	
        if (std::equal(word.cbegin(), word.cend(), m_word.cbegin(), m_word.cend())) {
            return true;
        }

        const auto counter_candidate = count_letters(word);

        return not std::equal(base.cbegin(), base.cend(), counter_candidate.cbegin(), counter_candidate.cend());
    }

    anagram::anagram(const std::string& word) : m_word{word}, m_base{} {
    	get_first_word(m_word);
    	
        to_lower_case(m_word);
        	
        m_base = count_letters(m_word);
    }

    auto anagram::matches(std::vector<std::string> candidates) -> std::vector<std::string> {
        candidates.erase(
        		std::remove_if(candidates.begin(), candidates.end(),
                                [&] (auto word) {
                                	get_first_word(word);
                                	
                                	if (word.empty()) {
                                		return true;
                                	}
                                	
                                	to_lower_case(word);
                                	
                                	return not_anagram(word, m_word, m_base);
                                }), 
                                candidates.end());

        return candidates;
    }
}  // namespace anagram
