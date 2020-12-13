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

    func testDay4() throws {
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
        try testDaySolver(Day4Year2020.self, input: sampleInput, part1Solution: "2")

        XCTAssertNoThrow(try Day4Year2020.InputElement.parseBirthYear(from: "2002"))
        XCTAssertThrowsError(try Day4Year2020.InputElement.parseBirthYear(from: "2003"))
        XCTAssertNoThrow(try Day4Year2020.InputElement.parseLength(from: "60in"))
        XCTAssertNoThrow(try Day4Year2020.InputElement.parseLength(from: "190cm"))
        XCTAssertThrowsError(try Day4Year2020.InputElement.parseLength(from: "190in"))
        XCTAssertThrowsError(try Day4Year2020.InputElement.parseLength(from: "190"))
        XCTAssertNoThrow(try Day4Year2020.InputElement.parseColor(from: "#123abc"))
        XCTAssertThrowsError(try Day4Year2020.InputElement.parseColor(from: "#123abz"))
        XCTAssertThrowsError(try Day4Year2020.InputElement.parseColor(from: "123abc"))
        XCTAssertNoThrow(try Day4Year2020.InputElement.Passport.EyeColor.parse(from: "brn"))
        XCTAssertThrowsError(try Day4Year2020.InputElement.Passport.EyeColor.parse(from: "wat"))
        XCTAssertNoThrow(try Day4Year2020.InputElement.parsePassportID(from: "000000001"))
        XCTAssertThrowsError(try Day4Year2020.InputElement.parsePassportID(from: "0123456789"))

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
        try testDaySolver(Day4Year2020.self, input: sampleInput2, part2Solution: "0")

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
        try testDaySolver(Day4Year2020.self, input: sampleInput3, part2Solution: "4")

        try testDaySolver(Day4Year2020.self, part1Solution: "233", part2Solution: "111")
    }

    func testDay5() throws {
        XCTAssertEqual(try? Day5Year2020.Seat.parse(from: "FBFBBFFRLR").id, 357)
        XCTAssertEqual(try? Day5Year2020.Seat.parse(from: "BFFFBBFRRR").id, 567)
        XCTAssertEqual(try? Day5Year2020.Seat.parse(from: "FFFBBBFRRR").id, 119)
        XCTAssertEqual(try? Day5Year2020.Seat.parse(from: "BBFFBBFRLL").id, 820)

        try testDaySolver(Day5Year2020.self, part1Solution: "822", part2Solution: "705")
    }

    func testDay6() throws {
        let sampleInput = """
            abcx
            abcy
            abcz
            """
        try testDaySolver(Day6Year2020.self, input: sampleInput, part1Solution: "6")

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
        try testDaySolver(Day6Year2020.self, input: sampleInput2, part1Solution: "11", part2Solution: "6")

        try testDaySolver(Day6Year2020.self, part1Solution: "6763", part2Solution: "3512")
    }

    func testDay7() throws {
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
        try testDaySolver(Day7Year2020.self, input: sampleInput, part1Solution: "4")

        let sampleInput2 = """
            shiny gold bags contain 2 dark red bags.
            dark red bags contain 2 dark orange bags.
            dark orange bags contain 2 dark yellow bags.
            dark yellow bags contain 2 dark green bags.
            dark green bags contain 2 dark blue bags.
            dark blue bags contain 2 dark violet bags.
            dark violet bags contain no other bags.
            """
        try testDaySolver(Day7Year2020.self, input: sampleInput2, part2Solution: "126")

        try testDaySolver(Day7Year2020.self, part1Solution: "254", part2Solution: "6006")
    }

    func testDay8() throws {
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
        try testDaySolver(Day8Year2020.self, input: sampleInput, part1Solution: "5", part2Solution: "8")

        try testDaySolver(Day8Year2020.self, part1Solution: "1749", part2Solution: "515")
    }

    func testDay9() throws {
        let samplePreamble = (1 ... 25).shuffled()
        XCTAssertTrue(Day9Year2020.isNumberValid(26, inPreamble: samplePreamble[...]))
        XCTAssertTrue(Day9Year2020.isNumberValid(49, inPreamble: samplePreamble[...]))
        XCTAssertFalse(Day9Year2020.isNumberValid(100, inPreamble: samplePreamble[...]))
        XCTAssertFalse(Day9Year2020.isNumberValid(50, inPreamble: samplePreamble[...]))

        let samplePreamble2 = updated(samplePreamble) {
            let index = $0.firstIndex(of: 20)!
            $0.remove(at: index)
            $0.append(45)
        }
        XCTAssertTrue(Day9Year2020.isNumberValid(26, inPreamble: samplePreamble2[...]))
        XCTAssertFalse(Day9Year2020.isNumberValid(65, inPreamble: samplePreamble2[...]))
        XCTAssertTrue(Day9Year2020.isNumberValid(64, inPreamble: samplePreamble2[...]))
        XCTAssertTrue(Day9Year2020.isNumberValid(66, inPreamble: samplePreamble2[...]))

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
        XCTAssertEqual(Day9Year2020.firstInvalidXMASNumber(in: parsedSampleInput, preambleLength: 5), 127)
        XCTAssertEqual(Day9Year2020.xmasEncryptionWeakness(forNumber: 127, in: parsedSampleInput), 62)

        try testDaySolver(Day9Year2020.self, part1Solution: "776203571", part2Solution: "104800569")
    }

    func testDay10() throws {
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
        try testDaySolver(Day10Year2020.self, input: sampleInput, part1Solution: "35", part2Solution: "8")

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
        try testDaySolver(Day10Year2020.self, input: sampleInput2, part1Solution: "220", part2Solution: "19208")

        try testDaySolver(Day10Year2020.self, part1Solution: "2432", part2Solution: "453551299002368")
    }

    func testDay11() throws {
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
        try testDaySolver(Day11Year2020.self, input: sampleInput, part1Solution: "37", part2Solution: "26")

        try testDaySolver(Day11Year2020.self, part1Solution: "2470", part2Solution: "2259")
    }

    func testDay12() throws {
        let sampleInput = """
            F10
            N3
            F7
            R90
            F11
            """
        try testDaySolver(Day12Year2020.self, input: sampleInput, part1Solution: "25", part2Solution: "286")

        try testDaySolver(Day12Year2020.self, part1Solution: "2847", part2Solution: "29839")
    }

    func testDay13() throws {
        let sampleInput = """
            939
            7,13,x,x,59,x,31,19
            """
        try testDaySolver(Day13Year2020.self, input: sampleInput, part1Solution: "295", part2Solution: "1068781")

        try testDaySolver(Day13Year2020.self, input: "0\n17,x,13,19", part2Solution: "3417")
        try testDaySolver(Day13Year2020.self, input: "0\n67,7,59,61", part2Solution: "754018")
        try testDaySolver(Day13Year2020.self, input: "0\n67,x,7,59,61", part2Solution: "779210")
        try testDaySolver(Day13Year2020.self, input: "0\n67,7,x,59,61", part2Solution: "1261476")
        try testDaySolver(Day13Year2020.self, input: "0\n1789,37,47,1889", part2Solution: "1202161486")

        try testDaySolver(Day13Year2020.self, part1Solution: "4782", part2Solution: "1118684865113056")
    }
}
