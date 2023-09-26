import Foundation

func getData() -> String? {
    guard let input = try? String(contentsOf: URL(fileURLWithPath: "input")) else {
        return nil
    }
    return input
}


let exampleInput:String =
"""
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
"""

func shared(bags:[String]) -> Character? {
    let uniqueElements:[Set<Character>] = bags.map { Set($0) }
    var intersect:Set<Character> = uniqueElements.first ?? Set<Character>()
    for set in uniqueElements {
        intersect = intersect.intersection(set)
    }
    if intersect.count == 1 {
        return intersect.first
    } else  {
        return nil
    }
}


func splitUp(a:String) -> (String, String) {
    let len = a.length/2
    return (String(a.prefix(len)), String(a.suffix(len)))
}

func score(b:Character?) -> Int {
    if let a = b {
        let offset:Int
            if a >= Character("a") && a <= Character("z") {
                offset = 96
            } else {
                offset = 38
            }
        if let val = a.asciiValue {
            return Int(val) - offset
        } else {
            return 0
        }
    } else {
        return 0
    }
}

// Part 1
let input = getData()!
let packs = input.split(separator: "\n").map { String($0) }
var total = 0
for pack in packs {
    let (compartment1, comparment2) = splitUp(a:pack)
    total += score(b:shared(bags:[compartment1, comparment2]))
}
print(total)

// Part 2
total = 0
for i in stride(from:0, to:packs.count-2, by:3) {
    total += score(b:shared(bags: Array<String>(packs[i..<i+3])))
}
print(total)
