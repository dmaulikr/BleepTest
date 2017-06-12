struct Team {
    
    init(name: String, teamDescription: String? = nil, players: [Player]? = nil) {
        self.name = name
        self.teamDescription = teamDescription
        self.players = players
    }
    
    let name: String
    let teamDescription: String?
    let players: [Player]?
}
