#include "bank_account.h"

#include <stdexcept>

namespace Bankaccount {

    auto Bankaccount::open() -> void {

        const std::lock_guard<std::mutex> lock(account_mutex);
        
        if (is_open)
        {
            throw std::runtime_error("can't open an account already opened.");
        }

        is_open = true;
        m_balance = 0;
    }

    auto Bankaccount::close() -> void {

        const std::lock_guard<std::mutex> lock(account_mutex);

        if (not is_open)
        {
            throw std::runtime_error("can't close an account not opened.");
        }

        is_open = false;
        m_balance = 0;
    }

    auto Bankaccount::deposit(double value) -> void {

        const std::lock_guard<std::mutex> lock(account_mutex);
             
        if (not is_open)
        {
            throw std::runtime_error("can't deposit to a not opened account.");
        }

        if (value < 0)
        {
            throw std::runtime_error("can't deposit a negative value.");
        }

        m_balance += value;
    }

    auto Bankaccount::withdraw(double value) -> void {

        const std::lock_guard<std::mutex> lock(account_mutex);

        if (not is_open)
        {
            throw std::runtime_error("can't withdraw from an account not opened.");
        }

        if (value > m_balance)
        {
            throw std::runtime_error("can't withdraw more than balance in account.");
        }

        if (value < 0)
        {
            throw std::runtime_error("can't withdraw a negative amount.");
        }

        m_balance -= value;
    }


    auto Bankaccount::balance() const -> double {

        if (not is_open)
        {
            throw std::runtime_error("can't check balance from an account not opened.");
        }
        
        return m_balance;
    }
}