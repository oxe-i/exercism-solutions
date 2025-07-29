#include "word_count.h"
#include <iostream>

namespace word_count {
	auto to_lower(std::string& text) -> void {
		std::transform(
    		text.cbegin(),
    		text.cend(),
    		text.begin(),
    		[](unsigned char character) {
    			return std::isalpha(character) ? std::tolower(character) : character;
    		}
    	);
    }
    
    auto is_valid(unsigned char character) -> bool {
    	return std::isalpha(character) or std::isdigit(character);
    }
    
    auto is_separator(unsigned char character) -> bool {
    	return std::isspace(character) or (std::ispunct(character) and character != '\'');
    }
    
    auto is_word(const std::string& sequence) -> bool {
    	return std::any_of(sequence.cbegin(), sequence.cend(), is_valid);
    }
    
    auto check_and_increment_key_in_map(std::map<std::string, int>& map, const std::string& key) -> void {
    	if (not is_word(key))
    		return;
    		
    	if (map.count(key)) {
    		map[key]++;
    	}
    	else {
    		map[key] = 1;
    	}
    }
    
    auto format_word(std::string& word) -> void {
    	if (not word.empty() and word.back() == '\'') {
			word.pop_back();
		}
	}
    
    auto is_end_of_subtitle(char& begin, char& end, const int& size) -> bool {
    	return std::distance(&begin, &end) == size - 1;
    }
    
    auto words(std::string subtitle) -> std::map<std::string, int> {   
    	to_lower(subtitle);
    		    	
    	return std::accumulate(
		    		subtitle.begin(),
		    		subtitle.end(),
		    		std::map<std::string, int>{},
		    		[&, word = std::string{}, size = static_cast<int>(subtitle.size())](auto&& acc, auto& character) mutable {
		    			auto partial_map = std::move(acc);
		    			  			
		    			if (is_valid(character)) {
		    				word.push_back(character);
		    			}
		    			else if (is_separator(character) or (character == '\'' and not is_valid(word.back()))) {
		    				format_word(word);		    				
		    				check_and_increment_key_in_map(partial_map, word);		    				
		    				word.clear();
		    			}
		    			else if (character == '\'') {
		    				word.push_back(character);
		    			}
		    			
		    			if (is_end_of_subtitle(subtitle[0], character, size)) {
		    				format_word(word);		    				
		    				check_and_increment_key_in_map(partial_map, word);
		    			}
		    			
		    			return partial_map;
		    		}
				);
    }
}  // namespace word_count
