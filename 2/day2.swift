import Foundation

let beats = ["Z" : "B",
             "X" : "C",
             "Y" : "A"]

let bonus = ["X" : 1,
             "Y" : 2,
             "Z" : 3]

let equals = ["X" : "A",
              "Y" : "B",
              "Z" : "C"]

func getData() -> String? {
    guard let input = try? String(contentsOf: URL(fileURLWithPath: "input")) else {
        return nil
    }
    return input
}

func score(game:String) -> Int {
    let hisMove = String(game[game.startIndex])
    let myMove = String(game[game.index(before: game.endIndex)])
    if hisMove == beats[myMove] {
        // if hisMove is what myMove beats
        return 6 + (bonus[myMove] ?? 0)
    } else if hisMove == (equals[myMove] ?? "shit") {
        return 3 + (bonus[myMove] ?? 0)
    } else {
        return 0 + (bonus[myMove] ?? 0)
    }
}

func main() -> Int {
    if let data = getData() {
        let games = data.split(separator: "\n")
        var total:Int = 0
        for game in games {
            total += score(game: String(game))
        }
        print(total)
        return(0)
    } else {
        return(-1)
    }
}

main()