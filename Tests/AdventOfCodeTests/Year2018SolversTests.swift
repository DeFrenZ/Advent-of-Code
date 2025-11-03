import Testing
import AdventOfCode

struct Year2018SolversTests {
    @Test func day1() throws {
		#expect(Day1Year2018.resultFrequency(changes: [+1, -2, +3, +1]) == 3)
		#expect(Day1Year2018.resultFrequency(changes: [+1, +1, +1]) == 3)
		#expect(Day1Year2018.resultFrequency(changes: [+1, +1, -2]) == 0)
		#expect(Day1Year2018.resultFrequency(changes: [-1, -2, -3]) == -6)

		try Day1Year2018.testSolutions(
			part1Solution: "484",
			part2Solution: "367")
    }

    @Test func day2() throws {
		#expect(Day2Year2018.checksumFlags(for: "abcdef") == .init(hasTwo: false, hasThree: false))
		#expect(Day2Year2018.checksumFlags(for: "bababc") == .init(hasTwo: true, hasThree: true))
		#expect(Day2Year2018.checksumFlags(for: "abbcde") == .init(hasTwo: true, hasThree: false))
		#expect(Day2Year2018.checksumFlags(for: "abcccd") == .init(hasTwo: false, hasThree: true))
		#expect(Day2Year2018.checksumFlags(for: "aabcdd") == .init(hasTwo: true, hasThree: false))
		#expect(Day2Year2018.checksumFlags(for: "abcdee") == .init(hasTwo: true, hasThree: false))
		#expect(Day2Year2018.checksumFlags(for: "ababab") == .init(hasTwo: false, hasThree: true))

        let sampleInput = """
            abcde
            fghij
            klmno
            pqrst
            fguij
            axcye
            wvxyz
            """
		try Day2Year2018.testSolutions(input: sampleInput, part2Solution: "fgij")

		try Day2Year2018.testSolutions(
			part1Solution: "6474",
			part2Solution: "mxhwoglxgeauywfkztndcvjqr")
    }

    @Test func day3() throws {
        let sampleInput = """
            #1 @ 1,3: 4x4
            #2 @ 3,1: 4x4
            #3 @ 5,5: 2x2
            """
		try Day3Year2018.testSolutions(
			input: sampleInput,
			part1Solution: "4",
			part2Solution: "3")

		try Day3Year2018.testSolutions(
			part1Solution: "107663",
			part2Solution: "1166")
    }

    @Test func day4() throws {
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
		try Day4Year2018.testSolutions(
			input: sampleInput,
			part1Solution: "240",
			part2Solution: "4455")


        try Day4Year2018.testSolutions(
			part1Solution: "99911",
			part2Solution: "65854")
    }

    @Test func day5() throws {
        let sampleInput = "aA"
        try Day5Year2018.testSolutions(input: sampleInput, part1Solution: "0")

        let sampleInput2 = "abBA"
        try Day5Year2018.testSolutions(input: sampleInput2, part1Solution: "0")

        let sampleInput3 = "abAB"
        try Day5Year2018.testSolutions(input: sampleInput3, part1Solution: "4")

        let sampleInput4 = "aabAAB"
        try Day5Year2018.testSolutions(input: sampleInput4, part1Solution: "6")

        let sampleInput5 = "dabAcCaCBAcCcaDA"
        try Day5Year2018.testSolutions(
			input: sampleInput5,
			part1Solution: "10",
			part2Solution: "4")

        try Day5Year2018.testSolutions(
			part1Solution: "9116",
			part2Solution: "6890")
    }
}
