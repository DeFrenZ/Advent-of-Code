import Testing
import AdventOfCode

struct Year2020SolversTests {
    @Test func day1() throws {
        let sampleInput = """
            1721
            979
            366
            299
            675
            1456
            """
		try Day1Year2020.testSolutions(
			input: sampleInput,
			part1Solution: "514579",
			part2Solution: "241861950")

		try Day1Year2020.testSolutions(
			part1Solution: "1010884",
			part2Solution: "253928438")
    }

    @Test func day2() throws {
        let sampleInput = """
            1-3 a: abcde
            1-3 b: cdefg
            2-9 c: ccccccccc
            """
        try Day2Year2020.testSolutions(
			input: sampleInput,
			part1Solution: "2",
			part2Solution: "1")

        try Day2Year2020.testSolutions(
			part1Solution: "393",
			part2Solution: "690")
    }

    @Test func day3() throws {
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
        try Day3Year2020.testSolutions(
			input: sampleInput,
			part1Solution: "7",
			part2Solution: "336")

        try Day3Year2020.testSolutions(
			part1Solution: "268",
			part2Solution: "3093068400")
    }

    @Test func day4() throws {
        let sampleInput = """
            ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
            byr:1937 iyr:2017 cid:147 hgt:183cm

            iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
            hcl:#cfa07d byr:1929

            hcl:#ae17e1 iyr:2013
            eyr:2024
            ecl:brn pid:760753108 byr:1931
            hgt:179cm

            hcl:#cfa07d eyr:2025 pid:166559648
            iyr:2011 ecl:brn hgt:59in
            """
        try Day4Year2020.testSolutions(input: sampleInput, part1Solution: "2")

		#expect(throws: Never.self) { try Day4Year2020.InputElement.parseBirthYear(from: "2002") }
		#expect(throws: (any Error).self) { try Day4Year2020.InputElement.parseBirthYear(from: "2003") }
		#expect(throws: Never.self) { try Day4Year2020.InputElement.parseLength(from: "60in") }
		#expect(throws: Never.self) { try Day4Year2020.InputElement.parseLength(from: "190cm") }
		#expect(throws: (any Error).self) { try Day4Year2020.InputElement.parseLength(from: "190in") }
		#expect(throws: (any Error).self) { try Day4Year2020.InputElement.parseLength(from: "190") }
		#expect(throws: Never.self) { try Day4Year2020.InputElement.parseColor(from: "#123abc") }
		#expect(throws: (any Error).self) { try Day4Year2020.InputElement.parseColor(from: "#123abz") }
		#expect(throws: (any Error).self) { try Day4Year2020.InputElement.parseColor(from: "123abc") }
		#expect(throws: Never.self) { try Day4Year2020.InputElement.Passport.EyeColor.parse(from: "brn") }
		#expect(throws: (any Error).self) { try Day4Year2020.InputElement.Passport.EyeColor.parse(from: "wat") }
		#expect(throws: Never.self) { try Day4Year2020.InputElement.parsePassportID(from: "000000001") }
		#expect(throws: (any Error).self) { try Day4Year2020.InputElement.parsePassportID(from: "0123456789") }

        let sampleInput2 = """
            eyr:1972 cid:100
            hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

            iyr:2019
            hcl:#602927 eyr:1967 hgt:170cm
            ecl:grn pid:012533040 byr:1946

            hcl:dab227 iyr:2012
            ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

            hgt:59cm ecl:zzz
            eyr:2038 hcl:74454a iyr:2023
            pid:3556412378 byr:2007
            """
        try Day4Year2020.testSolutions(input: sampleInput2, part2Solution: "0")

        let sampleInput3 = """
            pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
            hcl:#623a2f

            eyr:2029 ecl:blu cid:129 byr:1989
            iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

            hcl:#888785
            hgt:164cm byr:2001 iyr:2015 cid:88
            pid:545766238 ecl:hzl
            eyr:2022

            iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719
            """
        try Day4Year2020.testSolutions(input: sampleInput3, part2Solution: "4")

        try Day4Year2020.testSolutions(
			part1Solution: "233",
			part2Solution: "111")
    }

    @Test func day5() throws {
		#expect(try Day5Year2020.Seat.parse(from: "FBFBBFFRLR").id == 357)
		#expect(try Day5Year2020.Seat.parse(from: "BFFFBBFRRR").id == 567)
		#expect(try Day5Year2020.Seat.parse(from: "FFFBBBFRRR").id == 119)
		#expect(try Day5Year2020.Seat.parse(from: "BBFFBBFRLL").id == 820)

        try Day5Year2020.testSolutions(
			part1Solution: "822",
			part2Solution: "705")
    }

    @Test func day6() throws {
        let sampleInput = """
            abcx
            abcy
            abcz
            """
        try Day6Year2020.testSolutions(input: sampleInput, part1Solution: "6")

        let sampleInput2 = """
            abc

            a
            b
            c

            ab
            ac

            a
            a
            a
            a

            b
            """
        try Day6Year2020.testSolutions(
			input: sampleInput2,
			part1Solution: "11",
			part2Solution: "6")

        try Day6Year2020.testSolutions(part1Solution: "6763", part2Solution: "3512")
    }

    @Test func day7() throws {
        let sampleInput = """
            light red bags contain 1 bright white bag, 2 muted yellow bags.
            dark orange bags contain 3 bright white bags, 4 muted yellow bags.
            bright white bags contain 1 shiny gold bag.
            muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
            shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
            dark olive bags contain 3 faded blue bags, 4 dotted black bags.
            vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
            faded blue bags contain no other bags.
            dotted black bags contain no other bags.
            """
        try Day7Year2020.testSolutions(input: sampleInput, part1Solution: "4")

        let sampleInput2 = """
            shiny gold bags contain 2 dark red bags.
            dark red bags contain 2 dark orange bags.
            dark orange bags contain 2 dark yellow bags.
            dark yellow bags contain 2 dark green bags.
            dark green bags contain 2 dark blue bags.
            dark blue bags contain 2 dark violet bags.
            dark violet bags contain no other bags.
            """
        try Day7Year2020.testSolutions(input: sampleInput2, part2Solution: "126")

        try Day7Year2020.testSolutions(
			part1Solution: "254",
			part2Solution: "6006")
    }

    @Test func day8() throws {
        let sampleInput = """
            nop +0
            acc +1
            jmp +4
            acc +3
            jmp -3
            acc -99
            acc +1
            jmp -4
            acc +6
            """
        try Day8Year2020.testSolutions(
			input: sampleInput,
			part1Solution: "5",
			part2Solution: "8")

        try Day8Year2020.testSolutions(
			part1Solution: "1749",
			part2Solution: "515")
    }

    @Test func day9() throws {
        let samplePreamble = (1 ... 25).shuffled()
		#expect(Day9Year2020.isNumberValid(26, inPreamble: samplePreamble[...]) == true)
		#expect(Day9Year2020.isNumberValid(49, inPreamble: samplePreamble[...]) == true)
		#expect(Day9Year2020.isNumberValid(100, inPreamble: samplePreamble[...]) == false)
		#expect(Day9Year2020.isNumberValid(50, inPreamble: samplePreamble[...]) == false)

        let samplePreamble2 = updated(samplePreamble) {
            let index = $0.firstIndex(of: 20)!
            $0.remove(at: index)
            $0.append(45)
        }
		#expect(Day9Year2020.isNumberValid(26, inPreamble: samplePreamble2[...]) == true)
		#expect(Day9Year2020.isNumberValid(65, inPreamble: samplePreamble2[...]) == false)
		#expect(Day9Year2020.isNumberValid(64, inPreamble: samplePreamble2[...]) == true)
		#expect(Day9Year2020.isNumberValid(66, inPreamble: samplePreamble2[...]) == true)

        let sampleInput = """
            35
            20
            15
            25
            47
            40
            62
            55
            65
            95
            102
            117
            150
            182
            127
            219
            299
            277
            309
            576
            """
        let parsedSampleInput = try Day9Year2020.parseInputElements(input: sampleInput)
		#expect(Day9Year2020.firstInvalidXMASNumber(in: parsedSampleInput, preambleLength: 5) == 127)
		#expect(Day9Year2020.xmasEncryptionWeakness(forNumber: 127, in: parsedSampleInput) == 62)

        try Day9Year2020.testSolutions(
			part1Solution: "776203571",
			part2Solution: "104800569")
    }

    @Test func day10() throws {
        let sampleInput = """
            16
            10
            15
            5
            1
            11
            7
            19
            6
            12
            4
            """
        try Day10Year2020.testSolutions(
			input: sampleInput,
			part1Solution: "35",
			part2Solution: "8")

        let sampleInput2 = """
            28
            33
            18
            42
            31
            14
            46
            20
            48
            47
            24
            23
            49
            45
            19
            38
            39
            11
            1
            32
            25
            35
            8
            17
            7
            9
            4
            2
            34
            10
            3
            """
        try Day10Year2020.testSolutions(
			input: sampleInput2,
			part1Solution: "220",
			part2Solution: "19208")

        try Day10Year2020.testSolutions(
			part1Solution: "2432",
			part2Solution: "453551299002368")
    }

    @Test func day11() throws {
        let sampleInput = """
            L.LL.LL.LL
            LLLLLLL.LL
            L.L.L..L..
            LLLL.LL.LL
            L.LL.LL.LL
            L.LLLLL.LL
            ..L.L.....
            LLLLLLLLLL
            L.LLLLLL.L
            L.LLLLL.LL
            """
        try Day11Year2020.testSolutions(
			input: sampleInput,
			part1Solution: "37",
			part2Solution: "26")

        try Day11Year2020.testSolutions(
			part1Solution: "2470",
			part2Solution: "2259")
    }

    @Test func day12() throws {
        let sampleInput = """
            F10
            N3
            F7
            R90
            F11
            """
        try Day12Year2020.testSolutions(
			input: sampleInput,
			part1Solution: "25",
			part2Solution: "286")

        try Day12Year2020.testSolutions(
			part1Solution: "2847",
			part2Solution: "29839")
    }

    @Test func day13() throws {
        let sampleInput = """
            939
            7,13,x,x,59,x,31,19
            """
        try Day13Year2020.testSolutions(
			input: sampleInput,
			part1Solution: "295",
			part2Solution: "1068781")

        try Day13Year2020.testSolutions(input: "0\n17,x,13,19", part2Solution: "3417")
        try Day13Year2020.testSolutions(input: "0\n67,7,59,61", part2Solution: "754018")
        try Day13Year2020.testSolutions(input: "0\n67,x,7,59,61", part2Solution: "779210")
        try Day13Year2020.testSolutions(input: "0\n67,7,x,59,61", part2Solution: "1261476")
        try Day13Year2020.testSolutions(input: "0\n1789,37,47,1889", part2Solution: "1202161486")

        try Day13Year2020.testSolutions(
			part1Solution: "4782",
			part2Solution: "1118684865113056")
    }

    @Test func day14() throws {
        let sampleInput = """
            mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
            mem[8] = 11
            mem[7] = 101
            mem[8] = 0
            """
        try Day14Year2020.testSolutions(input: sampleInput, part1Solution: "165")

        let sampleInput2 = """
            mask = 000000000000000000000000000000X1001X
            mem[42] = 100
            mask = 00000000000000000000000000000000X0XX
            mem[26] = 1
            """
        try Day14Year2020.testSolutions(input: sampleInput2, part2Solution: "208")

        try Day14Year2020.testSolutions(
			part1Solution: "17028179706934",
			part2Solution: "3683236147222")
    }

	@Test(.disabled("Slow test"))
    func day15() throws {
        try Day15Year2020.testSolutions(
			input: "0,3,6",
			part1Solution: "436",
			part2Solution: "175594")
        try Day15Year2020.testSolutions(
			input: "1,3,2",
			part1Solution: "1",
			part2Solution: "2578")
        try Day15Year2020.testSolutions(
			input: "2,1,3",
			part1Solution: "10",
			part2Solution: "3544142")
        try Day15Year2020.testSolutions(
			input: "1,2,3",
			part1Solution: "27",
			part2Solution: "261214")
        try Day15Year2020.testSolutions(
			input: "2,3,1",
			part1Solution: "78",
			part2Solution: "6895259")
        try Day15Year2020.testSolutions(
			input: "3,2,1",
			part1Solution: "438",
			part2Solution: "18")
        try Day15Year2020.testSolutions(
			input: "3,1,2",
			part1Solution: "1836",
			part2Solution: "362")

        try Day15Year2020.testSolutions(
			part1Solution: "1280",
			part2Solution: "651639")
    }

    @Test func day16() throws {
        let sampleInput = """
            class: 1-3 or 5-7
            row: 6-11 or 33-44
            seat: 13-40 or 45-50

            your ticket:
            7,1,14

            nearby tickets:
            7,3,47
            40,4,50
            55,2,20
            38,6,12
            """
        try Day16Year2020.testSolutions(input: sampleInput, part1Solution: "71")

        let sampleInput2 = """
            class: 0-1 or 4-19
            row: 0-5 or 8-19
            seat: 0-13 or 16-19

            your ticket:
            11,12,13

            nearby tickets:
            3,9,18
            15,1,5
            5,14,9
            """
		#expect(try Day16Year2020(input: sampleInput2).deducedFields() == ["row", "class", "seat"])

        try Day16Year2020.testSolutions(
			part1Solution: "25972",
			part2Solution: "622670335901")
    }

	@Test(.disabled("Slow test"))
    func day17() throws {
        let sampleInput = """
            .#.
            ..#
            ###
            """
        try Day17Year2020.testSolutions(
			input: sampleInput,
			part1Solution: "112",
			part2Solution: "848")

        try Day17Year2020.testSolutions(
			part1Solution: "324",
			part2Solution: "1836")
    }

    @Test func day18() throws {
        try Day18Year2020.testSolutions(
			input: "1 + 2 * 3 + 4 * 5 + 6",
			part1Solution: "71",
			part2Solution: "231")
        try Day18Year2020.testSolutions(
			input: "1 + (2 * 3) + (4 * (5 + 6))",
			part1Solution: "51",
			part2Solution: "51")
        try Day18Year2020.testSolutions(
			input: "2 * 3 + (4 * 5)",
			part1Solution: "26",
			part2Solution: "46")
        try Day18Year2020.testSolutions(
			input: "5 + (8 * 3 + 9 + 3 * 4 * 3)",
			part1Solution: "437",
			part2Solution: "1445")
        try Day18Year2020.testSolutions(
			input: "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))",
			part1Solution: "12240",
			part2Solution: "669060")
        try Day18Year2020.testSolutions(
			input: "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2",
			part1Solution: "13632",
			part2Solution: "23340")

        try Day18Year2020.testSolutions(
			part1Solution: "11297104473091",
			part2Solution: "185348874183674")
    }

    @Test func day19() throws {
        let sampleInput = """
            0: 4 1 5
            1: 2 3 | 3 2
            2: 4 4 | 5 5
            3: 4 5 | 5 4
            4: "a"
            5: "b"

            ababbb
            bababa
            abbbab
            aaabbb
            aaaabbb
            """
        try Day19Year2020.testSolutions(input: sampleInput, part1Solution: "2")

        let sampleInput2 = """
            42: 9 14 | 10 1
            9: 14 27 | 1 26
            10: 23 14 | 28 1
            1: "a"
            11: 42 31
            5: 1 14 | 15 1
            19: 14 1 | 14 14
            12: 24 14 | 19 1
            16: 15 1 | 14 14
            31: 14 17 | 1 13
            6: 14 14 | 1 14
            2: 1 24 | 14 4
            0: 8 11
            13: 14 3 | 1 12
            15: 1 | 14
            17: 14 2 | 1 7
            23: 25 1 | 22 14
            28: 16 1
            4: 1 1
            20: 14 14 | 1 15
            3: 5 14 | 16 1
            27: 1 6 | 14 18
            14: "b"
            21: 14 1 | 1 14
            25: 1 1 | 1 14
            22: 14 14
            8: 42
            26: 14 22 | 1 20
            18: 15 15
            7: 14 5 | 1 21
            24: 14 1

            abbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa
            bbabbbbaabaabba
            babbbbaabbbbbabbbbbbaabaaabaaa
            aaabbbbbbaaaabaababaabababbabaaabbababababaaa
            bbbbbbbaaaabbbbaaabbabaaa
            bbbababbbbaaaaaaaabbababaaababaabab
            ababaaaaaabaaab
            ababaaaaabbbaba
            baabbaaaabbaaaababbaababb
            abbbbabbbbaaaababbbbbbaaaababb
            aaaaabbaabaaaaababaa
            aaaabbaaaabbaaa
            aaaabbaabbaaaaaaabbbabbbaaabbaabaaa
            babaaabbbaaabaababbaabababaaab
            aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba
            """
        try Day19Year2020.testSolutions(
			input: sampleInput2,
			part1Solution: "3",
			part2Solution: "12")

        try Day19Year2020.testSolutions(
			part1Solution: "176",
			part2Solution: "352")
    }

	@Test(.disabled("Not implemented yet"))
	func day20() throws {
        let sampleInput = """
            Tile 2311:
            ..##.#..#.
            ##..#.....
            #...##..#.
            ####.#...#
            ##.##.###.
            ##...#.###
            .#.#.#..##
            ..#....#..
            ###...#.#.
            ..###..###

            Tile 1951:
            #.##...##.
            #.####...#
            .....#..##
            #...######
            .##.#....#
            .###.#####
            ###.##.##.
            .###....#.
            ..#.#..#.#
            #...##.#..

            Tile 1171:
            ####...##.
            #..##.#..#
            ##.#..#.#.
            .###.####.
            ..###.####
            .##....##.
            .#...####.
            #.##.####.
            ####..#...
            .....##...

            Tile 1427:
            ###.##.#..
            .#..#.##..
            .#.##.#..#
            #.#.#.##.#
            ....#...##
            ...##..##.
            ...#.#####
            .#.####.#.
            ..#..###.#
            ..##.#..#.

            Tile 1489:
            ##.#.#....
            ..##...#..
            .##..##...
            ..#...#...
            #####...#.
            #..#.#.#.#
            ...#.#.#..
            ##.#...##.
            ..##.##.##
            ###.##.#..

            Tile 2473:
            #....####.
            #..#.##...
            #.##..#...
            ######.#.#
            .#...#.#.#
            .#########
            .###.#..#.
            ########.#
            ##...##.#.
            ..###.#.#.

            Tile 2971:
            ..#.#....#
            #...###...
            #.#.###...
            ##.##..#..
            .#####..##
            .#..####.#
            #..#.#..#.
            ..####.###
            ..#.#.###.
            ...#.#.#.#

            Tile 2729:
            ...#.#.#.#
            ####.#....
            ..#.#.....
            ....#..#.#
            .##..##.#.
            .#.####...
            ####.#.#..
            ##.####...
            ##..#.##..
            #.##...##.

            Tile 3079:
            #.#.#####.
            .#..######
            ..#.......
            ######....
            ####.#..#.
            .#...#.##.
            #.#####.##
            ..#.###...
            ..#.......
            ..#.###...
            """
        try Day20Year2020.testSolutions(input: sampleInput, part1Solution: "20899048083289")
    }
}
