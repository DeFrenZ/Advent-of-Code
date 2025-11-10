import Testing
import AdventOfCode

struct Year2024SolversTests {
	@Test func day1() throws {
		typealias SUT = Day1Year2024

		let sampleInput = """
			3   4
			4   3
			2   5
			1   3
			3   9
			3   3
			"""
		try SUT.testSolutions(
			input: sampleInput,
			part1Solution: "11",
			part2Solution: "31")

		try SUT.testSolutions(
			part1Solution: "3714264",
			part2Solution: "18805872")
	}

	@Test func day2() throws {
		typealias SUT = Day2Year2024

		#expect(SUT.Report(levels: [7, 6, 4, 2, 1]).isSafe() == true)
		#expect(SUT.Report(levels: [1, 2, 7, 8, 9]).isSafe() == false)
		#expect(SUT.Report(levels: [9, 7, 6, 2, 1]).isSafe() == false)
		#expect(SUT.Report(levels: [1, 3, 2, 4, 5]).isSafe() == false)
		#expect(SUT.Report(levels: [8, 6, 4, 4, 1]).isSafe() == false)
		#expect(SUT.Report(levels: [1, 3, 6, 7, 9]).isSafe() == true)

		#expect(SUT.Report(levels: [7, 6, 4, 2, 1]).isSafe(withDampening: true) == true)
		#expect(SUT.Report(levels: [1, 2, 7, 8, 9]).isSafe(withDampening: true) == false)
		#expect(SUT.Report(levels: [9, 7, 6, 2, 1]).isSafe(withDampening: true) == false)
		#expect(SUT.Report(levels: [1, 3, 2, 4, 5]).isSafe(withDampening: true) == true)
		#expect(SUT.Report(levels: [8, 6, 4, 4, 1]).isSafe(withDampening: true) == true)
		#expect(SUT.Report(levels: [1, 3, 6, 7, 9]).isSafe(withDampening: true) == true)

		let sampleInput = """
			7 6 4 2 1
			1 2 7 8 9
			9 7 6 2 1
			1 3 2 4 5
			8 6 4 4 1
			1 3 6 7 9
			"""
		try SUT.testSolutions(
			input: sampleInput,
			part1Solution: "2",
			part2Solution: "4")

		try SUT.testSolutions(
			part1Solution: "314",
			part2Solution: "373")
	}

	@Test func day3() throws {
		typealias SUT = Day3Year2024

		try SUT.testSolutions(input: "mul(44,46)", part1Solution: "2024")
		try SUT.testSolutions(input: "mul(123,4)", part1Solution: "492")
		try SUT.testSolutions(input: "mul(4*", part1Solution: "0")
		try SUT.testSolutions(input: "mul(6,9!", part1Solution: "0")
		try SUT.testSolutions(input: "?(12,34)", part1Solution: "0")
		try SUT.testSolutions(input: "mul ( 2 , 4 )", part1Solution: "0")

		let sampleInput = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
		try SUT.testSolutions(
			input: sampleInput,
			part1Solution: "161")

		let sampleInput2 = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
		try SUT.testSolutions(
			input: sampleInput2,
			part2Solution: "48")

		try SUT.testSolutions(
			part1Solution: "175015740",
			part2Solution: "112272912")
	}

	@Test func day4() throws {
		typealias SUT = Day4Year2024

		let sampleInput = """
			MMMSXXMASM
			MSAMXMSMSA
			AMXSXMAAMM
			MSAMASMSMX
			XMASAMXAMM
			XXAMMXXAMA
			SMSMSASXSS
			SAXAMASAAA
			MAMMMXMMMM
			MXMXAXMASX
			"""
		try SUT.testSolutions(
			input: sampleInput,
			part1Solution: "18",
			part2Solution: "9")

		try SUT.testSolutions(
			part1Solution: "2496",
			part2Solution: "1967")
	}
}
