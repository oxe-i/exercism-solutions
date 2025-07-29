namespace hellmath {

enum class AccountStatus {
     troll,
     guest,
     user,
     mod
};

enum class Action {
     read,
     write,
     remove
};

auto display_post(AccountStatus poster, AccountStatus viewer) -> bool {
    return not (poster == AccountStatus::troll) or 
            (viewer == AccountStatus::troll);
}

auto permission_check(Action act, AccountStatus status) -> bool {
    switch (act) {
    case Action::read:
        return true;
    case Action::write:
        return status != AccountStatus::guest;
    case Action::remove:
        return status == AccountStatus::mod;
    }
    
    return false;
}

auto valid_player_combination(AccountStatus fst, AccountStatus sec) -> bool {
    switch (fst) {
    case AccountStatus::troll:
        return sec == AccountStatus::troll;
    case AccountStatus::guest:
        return false;
    case AccountStatus::user:
    case AccountStatus::mod:
        return sec != AccountStatus::guest and sec != AccountStatus::troll;
    }

    return false;
}

auto has_priority(AccountStatus fst, AccountStatus sec) -> bool {
    return fst > sec;
}

}  // namespace hellmath