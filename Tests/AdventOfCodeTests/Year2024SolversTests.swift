import Testing
import AdventOfCode

struct Year2024SolversTests {
	@Test func day1() throws {
		let sampleInput = """
			3   4
			4   3
			2   5
			1   3
			3   9
			3   3
			"""
		try Day1Year2024.testSolutions(
			input: sampleInput,
			part1Solution: "11",
			part2Solution: "31")

		try Day1Year2024.testSolutions(
			part1Solution: "3714264",
			part2Solution: "18805872")
	}
}
