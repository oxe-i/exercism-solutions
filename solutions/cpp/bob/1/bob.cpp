#include "bob.h"

namespace bob {
    namespace message {
        enum kind : uint8_t {
            question,
            yelling,
            yelled_question,
            silence,
            other
        };
    }    

    constexpr std::array<const char*, 5> response = {
        "Sure.",
        "Whoa, chill out!",
        "Calm down, I know what I'm doing!",
        "Fine. Be that way!",
        "Whatever."    
    };

    auto find_response(message::kind dialogue) -> std::string {
        return response[dialogue];
    }

    auto hey(const std::string& dialogue) -> std::string {
        if (const auto silence = std::all_of(dialogue.begin(), dialogue.end(),
            [](unsigned char character) -> bool {
                return std::isspace(character);
            }); silence) {
            return find_response(message::kind::silence);
        }

        const auto yell = std::any_of(dialogue.begin(), dialogue.end(),
            [](unsigned char character) {
                return std::isalpha(character);
            }) and 
            std::all_of(dialogue.begin(), dialogue.end(),
            [](unsigned char character) -> bool {
                if (std::isalpha(character)) {
                    return std::isupper(character);
                }
                return true;
            });

        const auto question = *(std::find_if(dialogue.rbegin(), dialogue.rend(),
            [](unsigned char character) -> bool {
                return not isspace(character);
            })) == '?'; 

        if (yell and question) {
            return find_response(message::kind::yelled_question);
        }
        else if (yell) {
            return find_response(message::kind::yelling);
        }
        else if (question) {
            return find_response(message::kind::question);
        }
              
        return find_response(message::kind::other);
    }
}  // namespace bob
