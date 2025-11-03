import Testing
import AdventOfCode

struct Year2019SolversTests {
    @Test func day1() throws {
        try Day1Year2019.testSolutions(input: "12", part1Solution: "2")
        try Day1Year2019.testSolutions(input: "14", part1Solution: "2")
        try Day1Year2019.testSolutions(input: "1969", part1Solution: "654")
        try Day1Year2019.testSolutions(input: "100756", part1Solution: "33583")

        try Day1Year2019.testSolutions(input: "14", part2Solution: "2")
        try Day1Year2019.testSolutions(input: "1969", part2Solution: "966")
        try Day1Year2019.testSolutions(input: "100756", part2Solution: "50346")

        try Day1Year2019.testSolutions(
			part1Solution: "3457281",
			part2Solution: "5183030")
    }

    @Test func day2() throws {
		#expect(Day2Year2019.executedProgram([1,9,10,3,2,3,11,0,99,30,40,50]) == [3500,9,10,70,2,3,11,0,99,30,40,50])
		#expect(Day2Year2019.executedProgram([1,0,0,0,99]) == [2,0,0,0,99])
		#expect(Day2Year2019.executedProgram([2,3,0,3,99]) == [2,3,0,6,99])
		#expect(Day2Year2019.executedProgram([2,4,4,5,99,0]) == [2,4,4,5,99,9801])
		#expect(Day2Year2019.executedProgram([1,1,1,4,99,5,6,0,99]) == [30,1,1,4,2,5,6,0,99])

        try Day2Year2019.testSolutions(
			part1Solution: "3101878",
			part2Solution: "8444")
    }
}
