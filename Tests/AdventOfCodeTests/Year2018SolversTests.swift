import XCTest
import AdventOfCode

final class Year2018SolversTests: XCTestCase {
    func testDay1() throws {
        XCTAssertEqual(Day1Year2018.resultFrequency(changes: [+1, -2, +3, +1]), 3)
        XCTAssertEqual(Day1Year2018.resultFrequency(changes: [+1, +1, +1]), 3)
        XCTAssertEqual(Day1Year2018.resultFrequency(changes: [+1, +1, -2]), 0)
        XCTAssertEqual(Day1Year2018.resultFrequency(changes: [-1, -2, -3]), -6)

        try testDaySolver(Day1Year2018.self, part1Solution: "484", part2Solution: "367")
    }

    func testDay2() throws {
        XCTAssertEqual(Day2Year2018.checksumFlags(for: "abcdef"), .init(hasTwo: false, hasThree: false))
        XCTAssertEqual(Day2Year2018.checksumFlags(for: "bababc"), .init(hasTwo: true, hasThree: true))
        XCTAssertEqual(Day2Year2018.checksumFlags(for: "abbcde"), .init(hasTwo: true, hasThree: false))
        XCTAssertEqual(Day2Year2018.checksumFlags(for: "abcccd"), .init(hasTwo: false, hasThree: true))
        XCTAssertEqual(Day2Year2018.checksumFlags(for: "aabcdd"), .init(hasTwo: true, hasThree: false))
        XCTAssertEqual(Day2Year2018.checksumFlags(for: "abcdee"), .init(hasTwo: true, hasThree: false))
        XCTAssertEqual(Day2Year2018.checksumFlags(for: "ababab"), .init(hasTwo: false, hasThree: true))

        let sampleInput = """
            abcde
            fghij
            klmno
            pqrst
            fguij
            axcye
            wvxyz
            """
        try testDaySolver(Day2Year2018.self, input: sampleInput, part2Solution: "fgij")

        try testDaySolver(Day2Year2018.self, part1Solution: "6474", part2Solution: "mxhwoglxgeauywfkztndcvjqr")
    }

    func testDay3() throws {
        let sampleInput = """
            #1 @ 1,3: 4x4
            #2 @ 3,1: 4x4
            #3 @ 5,5: 2x2
            """
        try testDaySolver(Day3Year2018.self, input: sampleInput, part1Solution: "4", part2Solution: "3")

        try testDaySolver(Day3Year2018.self, part1Solution: "107663", part2Solution: "1166")
    }

    func testDay4() throws {
        let sampleInput = """
            [1518-11-01 00:00] Guard #10 begins shift
            [1518-11-01 00:05] falls asleep
            [1518-11-01 00:25] wakes up
            [1518-11-01 00:30] falls asleep
            [1518-11-01 00:55] wakes up
            [1518-11-01 23:58] Guard #99 begins shift
            [1518-11-02 00:40] falls asleep
            [1518-11-02 00:50] wakes up
            [1518-11-03 00:05] Guard #10 begins shift
            [1518-11-03 00:24] falls asleep
            [1518-11-03 00:29] wakes up
            [1518-11-04 00:02] Guard #99 begins shift
            [1518-11-04 00:36] falls asleep
            [1518-11-04 00:46] wakes up
            [1518-11-05 00:03] Guard #99 begins shift
            [1518-11-05 00:45] falls asleep
            [1518-11-05 00:55] wakes up
            """
        try testDaySolver(Day4Year2018.self, input: sampleInput, part1Solution: "240", part2Solution: "4455")

        try testDaySolver(Day4Year2018.self, part1Solution: "99911", part2Solution: "65854")
    }

    func testDay5() throws {
        let sampleInput = "aA"
        try testDaySolver(Day5Year2018.self, input: sampleInput, part1Solution: "0")

        let sampleInput2 = "abBA"
        try testDaySolver(Day5Year2018.self, input: sampleInput2, part1Solution: "0")

        let sampleInput3 = "abAB"
        try testDaySolver(Day5Year2018.self, input: sampleInput3, part1Solution: "4")

        let sampleInput4 = "aabAAB"
        try testDaySolver(Day5Year2018.self, input: sampleInput4, part1Solution: "6")

        let sampleInput5 = "dabAcCaCBAcCcaDA"
        try testDaySolver(Day5Year2018.self, input: sampleInput5, part1Solution: "10", part2Solution: "4")

        try testDaySolver(Day5Year2018.self, part1Solution: "9116", part2Solution: "6890")
    }
}
