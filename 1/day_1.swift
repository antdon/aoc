import Foundation
func prepareData(fileName:String) -> [[String]] {
    let path = URL(fileURLWithPath: fileName)
    guard let text = try? String(contentsOf: path) else {
        print("yikes")
        return [[]]
    }
    let lst = text.split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)
    var total: [[String]] = []
    var elems: [String] = []

    for elem in lst {
        if elem == "" {
            total.append(elems)
            elems = []
        } else {
            elems.append(String(elem))
        }
    }
    return total
}


let elfPacks = prepareData(fileName:"./input")
var calories: [Int] = []
for pack in elfPacks {
    var packSum: Int = 0
    for rawCalorie in pack {
        let calorie:Int = (try? Int(rawCalorie)) ?? 0
        packSum += calorie
    }
    calories.append(packSum)
}
print(calories.sorted(by: >)[..<3].reduce(0, +))

