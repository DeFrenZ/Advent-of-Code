import XCTest
import AdventOfCode

final class DaySolverPerformace: XCTestCase {
    func testPerformanceDay1Year2018() throws {
        measure { executeDaySolver(Day1Year2018.self) }
    }

    func testPerformanceDay1Year2019() throws {
        measure { executeDaySolver(Day1Year2019.self) }
    }

    func testPerformanceDay2Year2019() throws {
        measure { executeDaySolver(Day2Year2019.self) }
    }

    func testPerformanceDay1Year2020() throws {
        measure { executeDaySolver(Day1Year2020.self) }
    }

    func testPerformanceDay2Year2020() throws {
        measure { executeDaySolver(Day2Year2020.self) }
    }

    func testPerformanceDay3Year2020() throws {
        measure { executeDaySolver(Day3Year2020.self) }
    }

    func testPerformanceDay4Year2020() throws {
        measure { executeDaySolver(Day4Year2020.self) }
    }
}
