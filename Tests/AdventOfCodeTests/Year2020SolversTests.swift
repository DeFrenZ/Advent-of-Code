import XCTest
import AdventOfCode

final class Year2020SolversTests: XCTestCase {
    func testDay1() throws {
        let sampleInput = """
            1721
            979
            366
            299
            675
            1456
            """
        try testDaySolver(Day1Year2020.self, input: sampleInput, part1Solution: "514579", part2Solution: "241861950")
        try testDaySolver(Day1Year2020.self, part1Solution: "1010884", part2Solution: "253928438")
    }

    func testDay2() throws {
        let sampleInput = """
            1-3 a: abcde
            1-3 b: cdefg
            2-9 c: ccccccccc
            """
        try testDaySolver(Day2Year2020.self, input: sampleInput, part1Solution: "2", part2Solution: "1")
        try testDaySolver(Day2Year2020.self, part1Solution: "393", part2Solution: "690")
    }

    func testDay3() throws {
        let sampleInput = """
            ..##.......
            #...#...#..
            .#....#..#.
            ..#.#...#.#
            .#...##..#.
            ..#.##.....
            .#.#.#....#
            .#........#
            #.##...#...
            #...##....#
            .#..#...#.#
            """
        try testDaySolver(Day3Year2020.self, input: sampleInput, part1Solution: "7", part2Solution: "336")
        try testDaySolver(Day3Year2020.self, part1Solution: "268", part2Solution: "3093068400")
    }
}
