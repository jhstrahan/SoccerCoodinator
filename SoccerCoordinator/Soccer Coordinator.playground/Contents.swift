// Player Data [name, height(inches), Soccer Experience(yes/no), Guardian Names]
// This soccer league has three teams.  Each team must have an equal number of Veterans and Rookies on each team.  Also, each team in the league must have a similare average height.

var players: [String:[String]] = [:]
func inputPlayerFor(key: String, name: String, height: String, experience: String, guardian: String) -> [String:[String]] {
    players.updateValue([name, height, experience, guardian], forKey: key)
    
    return players
}
let playerOne = inputPlayerFor(key: "playerOne", name: "Joe Smith", height: "42", experience: "true", guardian: "Jim and Jan Smith")
let playerTwo = inputPlayerFor(key: "playerTwo", name: "Jill Tanner", height: "36", experience: "true", guardian: "Clara Tanner")
let playerThree = inputPlayerFor(key: "playerThree", name: "Bill Bon", height: "43", experience: "true", guardian: "Sara and Jenny Bon")
let playerFour = inputPlayerFor(key: "playerFour", name: "Eva Gordon", height: "45", experience: "false", guardian: "Wendy and Mike Gordon")
let playerFive = inputPlayerFor(key: "playerFive", name: "Matt Gill", height: "40", experience: "false", guardian: "Charles and Sylvia Gill")
let playerSix = inputPlayerFor(key: "playerSix", name: "Kimmy Stein", height: "41", experience: "false", guardian: "Bill and Hillary Stein")
let playerSeven = inputPlayerFor(key: "playerSeven", name: "Sammy Adams", height: "45", experience: "false", guardian: "Jeff Adams")
let playerEight = inputPlayerFor(key: "playerEight", name: "Karl Saygan", height: "42", experience: "true", guardian: "Heather Bledsoe")
let playerNine = inputPlayerFor(key: "playerNine", name: "Suzane Greenberg", height: "44", experience: "true", guardian: "Henrietta Dumas")
let playerTen = inputPlayerFor(key: "playerTen", name: "Sal Dali", height: "41", experience: "false", guardian: "Gala Dali")
let playerEleven = inputPlayerFor(key: "playerEleven", name: "Joe Kavalier", height: "39", experience: "false", guardian: "Sam and Elaine Kavalier")
let playerTwelve = inputPlayerFor(key: "playerTwelve", name: "Ben Finkelstein", height: "44", experience: "false", guardian: "Aaron and Jill Finkelstein")
let playerThirteen = inputPlayerFor(key: "playerThirteen", name: "Diego Soto", height: "41", experience: "true", guardian: "Robin and Sarika Soto")
let playerFourteen = inputPlayerFor(key: "playerFourteen", name: "Chloe Alaska", height: "47", experience: "false", guardian: "David and Jamie Alaska")
let playerFifteen = inputPlayerFor(key: "playerFifteen", name: "Arnold Willis", height: "43", experience: "false", guardian: "Claire Willis")
let playerSixteen = inputPlayerFor(key: "playerSixteen", name: "Phillip Helm", height: "44", experience: "true", guardian: "Thomas Helm and Eva Jones")
let playerSeventeen = inputPlayerFor(key: "playerSeventeen", name: "Les Clay", height: "42", experience: "true", guardian: "Wynonna Brown")
let playerEighteen = inputPlayerFor(key: "playerEighteen", name: "Herschel Krustofski", height: "45", experience: "true", guardian: "Hyman and Rachel Krustofski")

// Function to Create Array of Veterans only and Rookies only
// players[key]?[2] identifies the players recorded experience level

func playerBy(experience: Bool) -> [String] {
    var playersExperience = [String]()
    
    for (key,_) in players {
        if players[key]?[2] != nil {
            if let playerExperience = players[key]?[2] {
                if let playerExperienceAsBool = Bool(playerExperience) {
                    if playerExperienceAsBool == experience {
                        playersExperience.append(key)
                    }
                }
            }
        }
    }
    return playersExperience
}

// Assign Veterans and Rookies to Arrays (identified by their key).
let experiencedPlayers = playerBy(experience: true)
let inexperiencedPlayers = playerBy(experience: false)

// Functions to sort heights of verterans and rookies [Int] from smallest to tallest. By sorting the heights of players, each player can be placed on a team according to their height.
func sortedHeight(experience: Bool) -> [Int] {
    var playersHeight = [Int]()
    for (key,_) in players {
        if players[key]?[2] != nil {
            if let playerExperience = players[key]?[2] {
                if let playerExperienceAsBool = Bool(playerExperience) {
                    if playerExperienceAsBool == experience {
                        if players[key]?[1] != nil {
                            if let playerHeight = players[key]?[1] {
                                if let playerHeightAsInt = Int(playerHeight) {
                                    playersHeight.append(playerHeightAsInt)
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    playersHeight.sort()
    return playersHeight
}

// Assigned heights of players by sorted Array of Ints.
let veteransHeightArray = sortedHeight(experience: true)
let rookiesHeightArray = sortedHeight(experience: false)

// Sort players by experience and height and assign sorted player keys from shortest to tallest to [String]
// This function uses the Arrays of Veterans and Rookies and their cooresponting Arrays of Heights
func sortedExperienceByHeight(playerWithExperience: [String], withHeight: [Int]) -> [String] {
    var heightArray = withHeight
    var playerArray = playerWithExperience
    var sortedByHeight = [String]()
    var heightIndex = 0
    var playerIndex = 0
    
    while heightIndex < playerWithExperience.count {
        
        
        if String(heightArray[heightIndex]) != players[playerArray[playerIndex]]?[1] {
            playerIndex += 1
        } else if String(heightArray[heightIndex]) == players[playerArray[playerIndex]]?[1] {
            sortedByHeight.append(playerArray[playerIndex])
            playerArray.remove(at: playerIndex)
            playerIndex = 0
            heightIndex += 1
            
            
        }
        
        
    }
    return sortedByHeight
}
// Assign sorted veterans and rookies to constants identified by their keys
let veteransInLeague = sortedExperienceByHeight(playerWithExperience: experiencedPlayers, withHeight: veteransHeightArray)
let rookiesInLeague = sortedExperienceByHeight(playerWithExperience: inexperiencedPlayers, withHeight: rookiesHeightArray)



// Group Players according by equal experience and acending height so that the result is groupings of Veterans and Rookies which will be on the same team.  Each group should have similar average heights.
// Because their are three teams in the league, the players will be dived equally.  The following function requires a total number of players divisable by three so that the teams are equal.
// this function uses the constants "veteransInLeague" and "rookiesInLeague"
func assignPlayersFor(veterans: Bool) -> [[String]] {
    var leagueTeams = [[String]]()
    let teamsInLeague = 3
    var one = [String]()
    var two = [String]()
    var three = [String]()
    var vets = veteransInLeague
    var rooks = rookiesInLeague
    var picked = 0
    
    if veterans == true {
        if vets.count % teamsInLeague == 0 {
            
            for _ in 1...vets.count {
                if picked <= (vets.count - 1) {
                    one.append(vets[picked])
                    two.append(vets[picked + 1])
                    three.append(vets[picked + 2])
                }
                picked += 3
            }
        } else if vets.count % teamsInLeague != 0 {
            print("Can't compute.")
        }
    } else if veterans == false {
        if rooks.count % teamsInLeague == 0 {
            
            for _ in 1...rooks.count {
                if picked <= (rooks.count - 1) {
                    one.append(rooks[picked])
                    two.append(rooks[picked + 1])
                    three.append(rooks[picked + 2])
                }
                picked += 3
            }
        } else if rooks.count % teamsInLeague != 0 {
            print("Can't compute.")
        }
        
        
        
        
    }
    leagueTeams = [one, two, three]
    return leagueTeams
}
// Assigned groups of Veterans and Rookies according to average height which will be on the same team
let pickVeterans = assignPlayersFor(veterans: true)
let pickRookies = assignPlayersFor(veterans: false)



//Create Team of players identified by their Keys.  Each team will have the same number of Veterans and Rookies and a similar average height.
// this function uses the constants "pickVeterans" and "pickRookies"
func createTeamWith(veterans: [[String]], rookies: [[String]], team: Int) -> [String] {
    var finishedTeam = [String]()
    let teamNumber = team - 1
    
    for number in 1...3 {
        finishedTeam.append(veterans[teamNumber][number - 1])
        finishedTeam.append(rookies[teamNumber][number - 1])
    }
    
    
    return finishedTeam
}

// Assign teams of players identified by their keys
let sharkKeys = createTeamWith(veterans: pickVeterans, rookies: pickRookies, team: 1)
let dragonsKeys = createTeamWith(veterans: pickVeterans, rookies: pickRookies, team: 2)
let raptorsKeys = createTeamWith(veterans: pickVeterans, rookies: pickRookies, team: 3)

// Print each team's average height to the console
func printingAverageHeightOf(team: [String]) -> Double {
    var teamAverageHeight = Double()
    var heightCount = 0
    for player in 1...team.count {
        if players[team[player - 1]]?[1] != nil {
            if let playerHeight = players[team[player - 1]]?[1] {
                if let playerHeightAsInt = Int(playerHeight) {
                    heightCount += playerHeightAsInt
                    
                }
                
            }
            
        }
    }
    let totalHeight = Double(heightCount)
    teamAverageHeight = totalHeight / 6.0
    print("The Shark's Average Height: \(teamAverageHeight)")
    return teamAverageHeight
}
let sharksAverageHeight = printingAverageHeightOf(team: sharkKeys)
let dragonsAverageHeight = printingAverageHeightOf(team: dragonsKeys)
let raptorsAverageHeight = printingAverageHeightOf(team: raptorsKeys)



// function creating a team as a Dictionary of Data with all data of original file
func newTeam(teamOfKeys: [String]) -> [String:[String]] {
    var newlyFormedTeam = [String:[String]]()
    var index = 0
    for _ in teamOfKeys {
        if players[teamOfKeys[index]] != nil {
            if let addPlayer = players[teamOfKeys[index]] {
                newlyFormedTeam.updateValue(addPlayer, forKey: teamOfKeys[index])
                index += 1
                
            }
        }
    }
    
    return newlyFormedTeam
}


// Assigned teams as dictionaries
let sharks = newTeam(teamOfKeys: sharkKeys)
let dragons = newTeam(teamOfKeys: dragonsKeys)
let raptors = newTeam(teamOfKeys: raptorsKeys)


// Letters to Guardians

// tupel of Arrays of Player Names on Team and Guardians of Players
func playersOn(team: [String:[String]]) -> ([String],[String]) {
    var playerNames = [String]()
    var guardianNames = [String]()
    for (key,_) in team {
        if team[key]?[0] != nil && team[key]?[3] != nil {
            if let playerNameOnTeam = team[key]?[0] {
                playerNames.append(playerNameOnTeam)
            }
            if let guardianNameOnTeam = team[key]?[3] {
                guardianNames.append(guardianNameOnTeam)
            }
        }
    }
    
    
    return (playerNames,guardianNames)
}

let sharksPlayersAndGuardians = playersOn(team: sharks)
let dragonsPlayersAndGuardians = playersOn(team: dragons)
let raptorsPlayersAndGuardians = playersOn(team: raptors)

//Leters
func lettersFor(theSharks: ([String],[String]), theDragons: ([String],[String]), theRaptors: ([String],[String])) -> [String] {
    var teamLetters = [String]()
    let teamSharks = "Sharks"
    let sharksPactice = "March 17, at 3 pm"
    let teamDragons = "Dragons"
    let dragonsPractice = "March 17, 1pm"
    let teamRaptors = "Raptors"
    let raptorsPractice = "March 18, 1pm"
    for player in 1...theSharks.0.count {
        teamLetters.append("Dear \(theSharks.1[player - 1]),\n We are pleased that you have allowed \(theSharks.0[player - 1]) to play in our league!  \(theSharks.0[player - 1]) has been placed on the \(teamSharks) for this season.  Your teams first practice is on \(sharksPactice).  The practice will be held at the SWIFT FIELDS COMPLEX on Field One. Enjoy the season!")
    }
    for player in 1...theDragons.0.count {
        teamLetters.append("Dear \(theDragons.1[player - 1]),\n We are pleased that you have allowed \(theDragons.0[player - 1]) to play in our league!  \(theDragons.0[player - 1]) has been placed on the \(teamDragons) for this season.  Your teams first practice is on \(dragonsPractice).  The practice will be held at the SWIFT FIELDS COMPLEX on Field One. Enjoy the season!")
    }
    for player in 1...theRaptors.0.count {
        teamLetters.append("Dear \(theRaptors.1[player - 1]),\n We are pleased that you have allowed \(theRaptors.0[player - 1]) to play in our league!  \(theRaptors.0[player - 1]) has been placed on the \(teamRaptors) for this season.  Your teams first practice is on \(raptorsPractice).  The practice will be held at the SWIFT FIELDS COMPLEX on Field One. Enjoy the season!")
    }
    
    return teamLetters
}

// assign all greeting letters to a constant named greetingLetters
let greetingLetters = lettersFor(theSharks: sharksPlayersAndGuardians, theDragons: dragonsPlayersAndGuardians, theRaptors: raptorsPlayersAndGuardians)


// function that prints all letters.
func printAll(leagueLetters: [String]) {
    
    for player in 1...leagueLetters.count {
        print(leagueLetters[player - 1])
    }
    
}

var letters = printAll(leagueLetters: greetingLetters)




