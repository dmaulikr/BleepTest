class TeamManager {
    var count = 0
    private var teams = [Team]()
    
    func add(_ team: Team) {
        count += 1
        teams.append(team)
    }
    
    func remove(atIndex: Int) {
        count -= 1
        teams.remove(at: atIndex)
    }
    
    func atIndex(_ index: Int) -> Team? {
        if (index >= count) {
            return nil
        }
        return teams[index]
    }
}
