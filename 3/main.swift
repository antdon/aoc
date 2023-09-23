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

func shared(a:String, b:String) -> Character? {
    let uniqueElements:Set<Character> = Set(a)
    for j:Character in b {
        if uniqueElements.contains(j) {
            return(j)
        }
    }
    return nil
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

let input = getData()!
let packs = input.split(separator: "\n")
var total = 0
for pack in packs {
    let (compartment1, comparment2) = splitUp(a:String(pack))
    total += score(b:shared(a:compartment1, b:comparment2))
}
print(total)
