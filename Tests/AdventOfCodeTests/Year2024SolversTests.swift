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

	@Test func day2() throws {
		#expect(Day2Year2024.Report(levels: [7, 6, 4, 2, 1]).isSafe() == true)
		#expect(Day2Year2024.Report(levels: [1, 2, 7, 8, 9]).isSafe() == false)
		#expect(Day2Year2024.Report(levels: [9, 7, 6, 2, 1]).isSafe() == false)
		#expect(Day2Year2024.Report(levels: [1, 3, 2, 4, 5]).isSafe() == false)
		#expect(Day2Year2024.Report(levels: [8, 6, 4, 4, 1]).isSafe() == false)
		#expect(Day2Year2024.Report(levels: [1, 3, 6, 7, 9]).isSafe() == true)

		#expect(Day2Year2024.Report(levels: [7, 6, 4, 2, 1]).isSafe(withDampening: true) == true)
		#expect(Day2Year2024.Report(levels: [1, 2, 7, 8, 9]).isSafe(withDampening: true) == false)
		#expect(Day2Year2024.Report(levels: [9, 7, 6, 2, 1]).isSafe(withDampening: true) == false)
		#expect(Day2Year2024.Report(levels: [1, 3, 2, 4, 5]).isSafe(withDampening: true) == true)
		#expect(Day2Year2024.Report(levels: [8, 6, 4, 4, 1]).isSafe(withDampening: true) == true)
		#expect(Day2Year2024.Report(levels: [1, 3, 6, 7, 9]).isSafe(withDampening: true) == true)

		let sampleInput = """
			7 6 4 2 1
			1 2 7 8 9
			9 7 6 2 1
			1 3 2 4 5
			8 6 4 4 1
			1 3 6 7 9
			"""
		try Day2Year2024.testSolutions(
			input: sampleInput,
			part1Solution: "2",
			part2Solution: "4")

		try Day2Year2024.testSolutions(
			part1Solution: "314",
			part2Solution: "373")
	}
}
