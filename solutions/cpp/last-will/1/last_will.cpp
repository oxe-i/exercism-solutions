// Enter your code below the lines of the families' information

// Secret knowledge of the Zhang family:
namespace zhang {
    int bank_number_part(int secret_modifier) {
        int zhang_part{8'541};
        return (zhang_part*secret_modifier) % 10000;
    }
    namespace red {
        int code_fragment() {return 512;}
    }
    namespace blue {
        int code_fragment() {return 677;}
    }
}

// Secret knowledge of the Khan family:
namespace khan {
    int bank_number_part(int secret_modifier) {
        int khan_part{4'142};
        return (khan_part*secret_modifier) % 10000;
    }
    namespace red {
        int code_fragment() {return 148;}
    }
    namespace blue {
        int code_fragment() {return 875;}
    }
}

// Secret knowledge of the Garcia family:
namespace garcia {
    int bank_number_part(int secret_modifier) {
        int garcia_part{4'023};
        return (garcia_part*secret_modifier) % 10000;
    }
    namespace red {
        int code_fragment() {return 118;}
    }
    namespace blue {
        int code_fragment() {return 923;}
    }
}

namespace estate_executor {
    auto assemble_account_number(int secret_modifier) -> int {
        return garcia::bank_number_part(secret_modifier) +
            khan::bank_number_part(secret_modifier) +
            zhang::bank_number_part(secret_modifier);
    }

    auto assemble_code() -> int {
        const auto blue = garcia::blue::code_fragment() +
                        khan::blue::code_fragment() +
                        zhang::blue::code_fragment();
        
        const auto red = garcia::red::code_fragment() +
                        khan::red::code_fragment() +
                        zhang::red::code_fragment();

        return blue * red;
    }
}

// Enter your code below