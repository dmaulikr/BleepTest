class TeamManager {
    var count = 0
    private var teams = [Team]()
    
    func add(_ team: Team) {
        count += 1
        teams.append(team)
    }
    
    func atIndex(_ index: Int) -> Team {
        return teams[index]
    }
}
