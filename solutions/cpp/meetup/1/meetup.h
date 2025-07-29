#if !defined(MEETUP_H)
#define MEETUP_H

#include <boost/date_time/gregorian/gregorian.hpp>

namespace meetup {
    using namespace boost::gregorian;

    class scheduler {
    private:       
        using week_pos = nth_day_of_the_week_in_month::week_num;

        const greg_month month;
        const greg_year year;

        auto get_date(week_pos pos, greg_weekday week_day) const
        {
            nth_day_of_the_week_in_month nth(pos, week_day, month);
            return nth.get_date(year);
        }
    public:
        scheduler(greg_month month, greg_year year) : month{month}, year{year} {}

        auto first_sunday() const -> date {
            return get_date(week_pos::first, Sunday);
        }
        auto first_monday() const -> date {
            return get_date(week_pos::first, Monday);
        }
        auto first_tuesday() const -> date {
            return get_date(week_pos::first, Tuesday);
        }
        auto first_wednesday() const -> date {
            return get_date(week_pos::first, Wednesday);
        }
        auto first_thursday() const -> date {
            return get_date(week_pos::first, Thursday);
        }
        auto first_friday() const -> date {
            return get_date(week_pos::first, Friday);
        }
        auto first_saturday() const -> date {
            return get_date(week_pos::first, Saturday);
        }

        auto second_sunday() const -> date {
            return get_date(week_pos::second, Sunday);
        }
        auto second_monday() const -> date {
            return get_date(week_pos::second, Monday);
        }
        auto second_tuesday() const -> date {
            return get_date(week_pos::second, Tuesday);
        }
        auto second_wednesday() const -> date {
            return get_date(week_pos::second, Wednesday);
        }
        auto second_thursday() const -> date {
            return get_date(week_pos::second, Thursday);
        }
        auto second_friday() const -> date {
            return get_date(week_pos::second, Friday);
        }
        auto second_saturday() const -> date {
            return get_date(week_pos::second, Saturday);
        }

        auto third_sunday() const -> date {
            return get_date(week_pos::third, Sunday);
        }
        auto third_monday() const -> date {
            return get_date(week_pos::third, Monday);
        }
        auto third_tuesday() const -> date {
            return get_date(week_pos::third, Tuesday);
        }
        auto third_wednesday() const -> date {
            return get_date(week_pos::third, Wednesday);
        }
        auto third_thursday() const -> date {
            return get_date(week_pos::third, Thursday);
        }
        auto third_friday() const -> date {
            return get_date(week_pos::third, Friday);
        }
        auto third_saturday() const -> date {
            return get_date(week_pos::third, Saturday);
        }

        auto fourth_sunday() const -> date {
            return get_date(week_pos::fourth, Sunday);
        }
        auto fourth_monday() const -> date {
            return get_date(week_pos::fourth, Monday);
        }
        auto fourth_tuesday() const -> date {
            return get_date(week_pos::fourth, Tuesday);
        }
        auto fourth_wednesday() const -> date {
            return get_date(week_pos::fourth, Wednesday);
        }
        auto fourth_thursday() const -> date {
            return get_date(week_pos::fourth, Thursday);
        }
        auto fourth_friday() const -> date {
            return get_date(week_pos::fourth, Friday);
        }
        auto fourth_saturday() const -> date {
            return get_date(week_pos::fourth, Saturday);
        }

        auto last_sunday() const -> date {
            return get_date(week_pos::fifth, Sunday);
        }
        auto last_monday() const -> date {
            return get_date(week_pos::fifth, Monday);
        }
        auto last_tuesday() const -> date {
            return get_date(week_pos::fifth, Tuesday);
        }
        auto last_wednesday() const -> date {
            return get_date(week_pos::fifth, Wednesday);
        }
        auto last_thursday() const -> date {
            return get_date(week_pos::fifth, Thursday);
        }
        auto last_friday() const -> date {
            return get_date(week_pos::fifth, Friday);
        }
        auto last_saturday() const -> date {
            return get_date(week_pos::fifth, Saturday);
        }

        auto sunteenth() const -> date {
            if (auto day = second_sunday().day(); day >= 13 and day <= 19) {
                return second_sunday();
            }

            return third_sunday();
        }
        auto monteenth() const -> date {
            if (auto day = second_monday().day(); day >= 13 and day <= 19) {
                return second_monday();
            }

            return third_monday();
        }
        auto tuesteenth() const -> date {
            if (auto day = second_tuesday().day(); day >= 13 and day <= 19) {
                return second_tuesday();
            }

            return third_tuesday();
        }
        auto wednesteenth() const -> date {
            if (auto day = second_wednesday().day(); day >= 13 and day <= 19) {
                return second_wednesday();
            }

            return third_wednesday();
        }
        auto thursteenth() const -> date {
            if (auto day = second_thursday().day(); day >= 13 and day <= 19) {
                return second_thursday();
            }

            return third_thursday();
        }
        auto friteenth() const -> date {
            if (auto day = second_friday().day(); day >= 13 and day <= 19) {
                return second_friday();
            }

            return third_friday();
        }
        auto saturteenth() const -> date {
            if (auto day = second_saturday().day(); day >= 13 and day <= 19) {
                return second_saturday();
            }

            return third_saturday();
        }
    };
}  // namespace meetup

#endif // MEETUP_H