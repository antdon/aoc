import Foundation

func getData() -> String? {
    guard let input = try? String(contentsOf: URL(fileURLWithPath: "input")) else {
        return nil
    }
    return input
}

let exampleInput:String =
"""
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-80
"""

func processInput(input:String) -> [(Int, Int, Int, Int)] {
    let lines:[Array] = input
                        .split(separator: "\n")
                        .map { String($0)
                               .split(whereSeparator: {$0 == "," || $0 == "-"}) }
    return lines.map { (Int($0[0]) ?? 0,
                 Int($0[1]) ?? 0,
                 Int($0[2]) ?? 0,
                 Int($0[3]) ?? 0)}

}

func encompass(ranges:(Int,Int,Int,Int)) -> Bool {
    let (a,b,c,d) = ranges
    if (a >= c && b <= d) || (a <= c && b >= d) {
        return true
    } else {
        return false
    }
}

func overlap(ranges:(Int,Int,Int,Int)) -> Bool {
    let (a,b,c,d) = ranges
    if (b >= c && d >= a) {
        return true
    } else {
        return false
    }
}

let input = getData() ?? ""

// Part 1
print(processInput(input:input)
      .filter {encompass(ranges:$0)}
      .count)

// Part 2
print(processInput(input:input)
      .filter {overlap(ranges:$0)}
      .count)

