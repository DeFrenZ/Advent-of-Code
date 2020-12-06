//
//  File.swift
//  
//
//  Created by Davide De Franceschi on 06/12/2020.
//

import Foundation

public final class Day6Year2020: DaySolverWithInputs {
    public static let day = 6
    public static let year = 2020
    public static let elementsSeparator = "\n\n"

    private let inputElements: [InputElement]

    public init(inputElements: [InputElement]) {
        self.inputElements = inputElements
    }

    /*
     --- Day 6: Custom Customs ---

     As your flight approaches the regional airport where you'll switch to a much larger plane, customs declaration forms are distributed to the passengers.

     The form asks a series of 26 yes-or-no questions marked a through z. All you need to do is identify the questions for which anyone in your group answers "yes". Since your group is just you, this doesn't take very long.

     However, the person sitting next to you seems to be experiencing a language barrier and asks if you can help. For each of the people in their group, you write down the questions for which they answer "yes", one per line. For example:

     abcx
     abcy
     abcz

     In this group, there are 6 questions to which anyone answered "yes": a, b, c, x, y, and z. (Duplicate answers to the same question don't count extra; each question counts at most once.)

     Another group asks for your help, then another, and eventually you've collected answers from every group on the plane (your puzzle input). Each group's answers are separated by a blank line, and within each group, each person's answers are on a single line. For example:

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

     This list represents answers from five groups:

     - The first group contains one person who answered "yes" to 3 questions: a, b, and c.
     - The second group contains three people; combined, they answered "yes" to 3 questions: a, b, and c.
     - The third group contains two people; combined, they answered "yes" to 3 questions: a, b, and c.
     - The fourth group contains four people; combined, they answered "yes" to only 1 question, a.
     - The last group contains one person who answered "yes" to only 1 question, b.

     In this example, the sum of these counts is 3 + 3 + 3 + 1 + 1 = 11.

     For each group, count the number of questions to which anyone answered "yes". What is the sum of those counts?
     */
    public func solvePart1() -> String {
        inputElements
            .map({ $0.questionsAnyoneAnsweredYes().count })
            .sum()
            .description
    }

    /*
     --- Part Two ---

     As you finish the last group's customs declaration, you notice that you misread one word in the instructions:

     You don't need to identify the questions to which anyone answered "yes"; you need to identify the questions to which everyone answered "yes"!

     Using the same example as above:

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

     This list represents answers from five groups:

     - In the first group, everyone (all 1 person) answered "yes" to 3 questions: a, b, and c.
     - In the second group, there is no question to which everyone answered "yes".
     - In the third group, everyone answered yes to only 1 question, a. Since some people did not answer "yes" to b or c, they don't count.
     - In the fourth group, everyone answered yes to only 1 question, a.
     - In the fifth group, everyone (all 1 person) answered "yes" to 1 question, b.

     In this example, the sum of these counts is 3 + 0 + 1 + 1 + 1 = 6.

     For each group, count the number of questions to which everyone answered "yes". What is the sum of those counts?
     */
    public func solvePart2() -> String {
        inputElements
            .map({ $0.questionsEveryoneAnsweredYes().count })
            .sum()
            .description
    }
}

// MARK: - Input

public extension Day6Year2020 {
    struct GroupAnswers {
        var personsAnswers: [PersonAnswers]

        typealias PersonAnswers = Day6Year2020.PersonAnswers
        typealias Question = Day6Year2020.Question
    }

    struct PersonAnswers {
        var questionsAnsweredYes: Set<Question>

        typealias Question = Day6Year2020.Question
    }

    enum Question: Character, CaseIterable, ParseableFromString {
        case a = "a"
        case b = "b"
        case c = "c"
        case d = "d"
        case e = "e"
        case f = "f"
        case g = "g"
        case h = "h"
        case i = "i"
        case j = "j"
        case k = "k"
        case l = "l"
        case m = "m"
        case n = "n"
        case o = "o"
        case p = "p"
        case q = "q"
        case r = "r"
        case s = "s"
        case t = "t"
        case u = "u"
        case v = "v"
        case w = "w"
        case x = "x"
        case y = "y"
        case z = "z"
    }

    typealias InputElement = GroupAnswers
}

extension Day6Year2020.GroupAnswers: ParseableFromString {
    public var description: String {
        personsAnswers
            .map(\.description)
            .joined(separator: "\n")
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        let answers = try scanner.scanAll(PersonAnswers.self, separators: .newlines)
        return Self(personsAnswers: answers)
    }
}

extension Day6Year2020.PersonAnswers: ParseableFromString {
    public var description: String {
        questionsAnsweredYes
            .map(\.rawValue)
            .map(String.init)
            .joined()
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        let questions = try scanner.scanAll(Question.self)
        return Self(questionsAnsweredYes: Set(questions))
    }
}

// MARK: - Logic

extension Day6Year2020.GroupAnswers {
    func questionsAnyoneAnsweredYes() -> Set<Question> {
        personsAnswers
            .map(\.questionsAnsweredYes)
            .reduce(into: [], { $0.formUnion($1) })
    }

    func questionsEveryoneAnsweredYes() -> Set<Question> {
        personsAnswers
            .map(\.questionsAnsweredYes)
            .reduce(into: Set(Question.allCases), { $0.formIntersection($1) })
    }
}
