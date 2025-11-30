module Bandwagoner

type Coach = 
    { Name: string 
      FormerPlayer: bool }

type Stats = 
    { Wins: int 
      Losses: int }

type Team = 
    { Name: string
      Coach: Coach
      Stats: Stats }

let createCoach (name: string) (formerPlayer: bool): Coach =
    { Name = name; FormerPlayer = formerPlayer }

let createStats(wins: int) (losses: int): Stats =
    { Wins = wins; Losses = losses }

let createTeam(name: string) (coach: Coach)(stats: Stats): Team =
    { Name = name; Coach = coach; Stats = stats }

let replaceCoach(team: Team) (coach: Coach): Team =
    { Name = team.Name; Coach = coach; Stats = team.Stats }

let isSameTeam(homeTeam: Team) (awayTeam: Team): bool =
    homeTeam.Name = awayTeam.Name && 
    homeTeam.Coach = awayTeam.Coach && 
    homeTeam.Stats = awayTeam.Stats

let rootForTeam(team: Team): bool =
    team.Coach.Name = "Gregg Popovich" ||
    team.Coach.FormerPlayer ||
    team.Name = "Chicago Bulls" ||
    team.Stats.Wins >= 60 ||
    team.Stats.Losses > team.Stats.Wins
