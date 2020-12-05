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
}
