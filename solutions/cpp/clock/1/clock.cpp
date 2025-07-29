#include "clock.h"

namespace date_independent {
    auto adjust_time(int& hour, int& minute) -> void {
        const auto change_hour = minute / full_hour;
        
        minute %= full_hour;

        hour += change_hour;

        hour %= full_day;

        if (minute < 0) {
            minute = full_hour + minute;
            hour--;
        }

        if (hour < 0) {
            hour = full_day + hour;
        }
    }

    auto clock::at(int hour, int minute) -> clock::time {       
        adjust_time(hour, minute);

        return clock::time{hour, minute};   
    }

    auto clock::time::plus(int minute) -> clock::time& {
        m_minute += minute;

        adjust_time(m_hour, m_minute);

        return *this;
    }

    clock::time::operator std::string() const {
        auto hour = std::to_string(m_hour);
        auto minute = std::to_string(m_minute);

        if (hour.size() < 2) {
            hour = "0" + hour;
        }

        if (minute.size() < 2) {
            minute = "0" + minute;
        }

        return hour + ":" + minute;
    }


}  // namespace date_independent
