namespace hellmath {

// TODO: Task 1 - Define an `AccountStatus` enumeration to represent the four
// account types: `troll`, `guest`, `user`, and `mod`.

enum class AccountStatus {
     troll,
     guest,
     user,
     mod
};

// TODO: Task 1 - Define an `Action` enumeration to represent the three
// permission types: `read`, `write`, and `remove`.

enum class Action {
     read,
     write,
     remove
};

// TODO: Task 2 - Implement the `display_post` function, that gets two arguments
// of `AccountStatus` and returns a `bool`. The first argument is the status of
// the poster, the second one is the status of the viewer.

auto display_post(AccountStatus fst, AccountStatus sec) -> bool {
    return !((fst == AccountStatus::troll) ^ (sec == AccountStatus::troll));
}

// TODO: Task 3 - Implement the `permission_check` function, that takes an
// `Action` as a first argument and an `AccountStatus` to check against. It
// should return a `bool`.

auto permission_check(Action act, AccountStatus status) -> bool {
    switch (act) {
    case Action::read:
        return true;
    case Action::write:
        return status != AccountStatus::guest;
    }
    
    return status == AccountStatus::mod;
}

// TODO: Task 4 - Implement the `valid_player_combination` function that
// checks if two players can join the same game. The function has two parameters
// of type `AccountStatus` and returns a `bool`.
auto valid_player_combination(AccountStatus fst, AccountStatus sec) -> bool {
    switch (fst) {
    case AccountStatus::troll:
        return sec == AccountStatus::troll;
    case AccountStatus::guest:
        return false;
    }

    return (sec != AccountStatus::guest) && 
        (sec != AccountStatus::troll);
}

// TODO: Task 5 - Implement the `has_priority` function that takes two
// `AccountStatus` arguments and returns `true`, if and only if the first
// account has a strictly higher priority than the second.
auto has_priority(AccountStatus fst, AccountStatus sec) -> bool {
    return fst > sec;
}

}  // namespace hellmath