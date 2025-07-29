#if !defined(BANK_ACCOUNT_H)
#define BANK_ACCOUNT_H

#include <mutex>

namespace Bankaccount {
class Bankaccount {
private:
    double m_balance;
    bool is_open;
    std::mutex account_mutex;
public:
    Bankaccount() = default;

    auto open() -> void;
    auto close() -> void;
    auto deposit(double value) -> void;
    auto withdraw(double value) -> void;
    auto balance() const -> double;
};  // class Bankaccount

}  // namespace Bankaccount

#endif  // BANK_ACCOUNT_H