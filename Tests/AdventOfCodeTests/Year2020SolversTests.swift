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
}
