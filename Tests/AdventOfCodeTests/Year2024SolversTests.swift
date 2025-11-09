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

	@Test func day3() throws {
		try Day3Year2024.testSolutions(input: "mul(44,46)", part1Solution: "2024")
		try Day3Year2024.testSolutions(input: "mul(123,4)", part1Solution: "492")
		try Day3Year2024.testSolutions(input: "mul(4*", part1Solution: "0")
		try Day3Year2024.testSolutions(input: "mul(6,9!", part1Solution: "0")
		try Day3Year2024.testSolutions(input: "?(12,34)", part1Solution: "0")
		try Day3Year2024.testSolutions(input: "mul ( 2 , 4 )", part1Solution: "0")

		let sampleInput = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
		try Day3Year2024.testSolutions(
			input: sampleInput,
			part1Solution: "161")

		let sampleInput2 = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
		try Day3Year2024.testSolutions(
			input: sampleInput2,
			part2Solution: "48")

		try Day3Year2024.testSolutions(
			part1Solution: "175015740",
			part2Solution: "112272912")
	}
}
