from collections import defaultdict
from dataclasses import dataclass

@dataclass
class Stats:
    wins: int = 0
    losses: int = 0
    draws: int = 0

    @property
    def points(self):
        return self.wins * 3 + self.draws

    @property
    def matches(self):
        return sum((self.wins, self.losses, self.draws))


def tally(rows):
    stats_for_team = defaultdict(Stats)
    for row in rows:
        team1, team2, outcome = row.split(';')
        update_stats(stats_for_team, team1, team2, outcome)
    return create_summary(stats_for_team)


def update_stats(stats_for_team, team1, team2, outcome):
    match outcome:
        case "win":
            stats_for_team[team1].wins += 1
            stats_for_team[team2].losses += 1
        case "loss":
            stats_for_team[team1].losses += 1
            stats_for_team[team2].wins += 1
        case "draw":
            stats_for_team[team1].draws += 1
            stats_for_team[team2].draws += 1


def create_summary(stats_for_team):

    def get_team_rank(team):
        return (-stats_for_team[team].points, team)
        
    header = " | ".join(("Team".ljust(30), "MP", " W", " D", " L", " P"))
    sorted_teams = sorted(stats_for_team.keys(), key=get_team_rank)
    return [header, *(format_row(team, stats_for_team[team]) for team in sorted_teams)]


def format_row(team, stats):
    return f"{team.ljust(30)} | " + format_stats(stats)
    

def format_stats(stats):
    return " | ".join((f"{x:2}" for x in (stats.matches, stats.wins, stats.draws, stats.losses, stats.points)))


