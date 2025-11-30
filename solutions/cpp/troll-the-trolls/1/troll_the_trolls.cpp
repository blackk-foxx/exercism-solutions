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

bool display_post(AccountStatus poster, AccountStatus viewer) {
    if (poster == AccountStatus::troll)
        return viewer == AccountStatus::troll;
    return poster != AccountStatus::troll;
}
    
bool permission_check(Action action, AccountStatus user_type) {
    switch(user_type) {
        case AccountStatus::mod:
            return true;
        case AccountStatus::user:
        case AccountStatus::troll:
            return action == Action::read || action == Action::write;
        case AccountStatus::guest:
            return action == Action::read;
    }
    return false;
}
    
bool valid_player_combination(AccountStatus player1, AccountStatus player2) {
    if (player1 == AccountStatus::guest || player2 == AccountStatus::guest)
        return false;
    if (player1 == AccountStatus::troll && player2 == AccountStatus::troll)
        return true;
    return player1 != AccountStatus::troll && player2 != AccountStatus::troll;
}
    
bool has_priority(AccountStatus player1, AccountStatus player2) {
    return player1 > player2;
}
}  // namespace hellmath