#include "acronym.h"

namespace acronym {
     auto is_separator(char ch) -> bool {
           return std::isspace(ch) or ch == '-';
     } 
        
     auto acronym(std::string expression) -> std::string {
           expression.erase(
               std::remove_if(
                    expression.begin(), 
                    expression.end(),
                    [](auto ch) {
                        return std::ispunct(ch) and 
                            not (ch == '-');
                    }), 
                    expression.end());
                  
            std::string unformatted_acronym {static_cast<char>(std::toupper(expression.front()))};
            bool separator {};
                  
            for (const auto& ch : expression) {
                if (is_separator(ch)) {
                     separator = true;
                }
                else if (separator and std::isalpha(ch)) {
                     unformatted_acronym.push_back(
                         std::toupper(ch)
                     );
                     separator = false;
                }
            }
                
            return unformatted_acronym;
       }

}