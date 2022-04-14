import UIKit

var greeting = "Hello, playground"
protocol IntroForAthlete {
    var fullIntro: String {get}
    func printIntro()
}


struct Athlete: IntroForAthlete, Comparable {
    
    static func < (lhs: Athlete, rhs: Athlete) -> Bool {
        return lhs.number > rhs.number
        
    }
    
    var name: String
    var number: Int
    var sport: String
    var league: String
    var team: String
    
    var fullIntro: String {
      return "\(name) is \(number) years old plays \(sport) for \(team) in the \(league)"
        }
    
    func printIntro() {
        print(fullIntro)
    }
}
let instance1 = Athlete(name: "Juju Smith", number: 19, sport: "Football", league: "NFl", team: "Steelers")
let instance2 = Athlete(name: "Chase Claypool", number: 11, sport: "Football", league: "NFL", team: "Steelers")
let instance3 = Athlete(name: "Big Ben", number: 7, sport: "Football", league: "NFL", team: "Steelers")
let instance4 = Athlete(name: "Minkah Fitzpatrick", number: 39, sport: "Football", league: "NFL", team: "Steelers")
let instance5 = Athlete(name: "Joe Haden", number: 23, sport: "Football", league: "NFL", team: "Steelers")

let players = [instance1,  instance2, instance3, instance4, instance5]

let sortedPlayers = players.sorted(by: >)
for players in sortedPlayers {
    players.printIntro()
}
//struct SpecificAthlete: Athlete {
//    var position: String
//} How can we get 

