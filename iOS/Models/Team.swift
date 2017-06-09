struct Team {
    
    init(name: String, teamDescription: String? = nil) {
        self.name = name
        self.teamDescription = teamDescription
    }
    
    let name: String
    let teamDescription: String?
}
