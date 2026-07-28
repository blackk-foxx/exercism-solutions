module RolePlayingGame

type Player = { 
    Name: Option<string>
    Level: int
    Health: int
    Mana: Option<int>
}

let introduce (player: Player): string = 
    Option.defaultValue "Mighty Magician" player.Name

let revive (player: Player): Option<Player> = 
    match player.Health with
    | 0 when player.Level >= 10 -> Some { player with Health = 100; Mana = Some 100 }
    | 0 -> Some { player with Health = 100 }
    | _ -> None

let castSpell (manaCost: int) (player: Player): Player * int =
    match player.Mana with
    | Some mana when mana < manaCost -> player, 0
    | Some mana -> { player with Mana = Some (mana - manaCost) }, manaCost * 2
    | None -> { player with Health = max 0 (player.Health - manaCost) }, 0
