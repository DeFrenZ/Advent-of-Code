import Foundation

public final class Day18Year2020: DaySolverWithInputs {
    public static let day = 18
    public static let year = 2020

    private let inputElements: [InputElement]

    public init(inputElements: [InputElement]) {
        self.inputElements = inputElements
    }

    /**
     # --- Day 18: Operation Order ---

     As you look out the window and notice a heavily-forested continent slowly appear over the horizon, you are interrupted by the child sitting next to you. They're curious if you could help them with their math homework.

     Unfortunately, it seems like this "math" [follows different rules](https://www.youtube.com/watch?v=3QtRK7Y2pPU&t=15) than you remember.

     The homework (your puzzle input) consists of a series of expressions that consist of addition (`+`), multiplication (`*`), and parentheses (`(...)`). Just like normal math, parentheses indicate that the expression inside must be evaluated before it can be used by the surrounding expression. Addition still finds the sum of the numbers on both sides of the operator, and multiplication still finds the product.

     However, the rules of **operator precedence** have changed. Rather than evaluating multiplication before addition, the operators have the **same precedence**, and are evaluated left-to-right regardless of the order in which they appear.

     For example, the steps to evaluate the expression `1 + 2 * 3 + 4 * 5 + 6` are as follows:

     ```
     **1 + 2** * 3 + 4 * 5 + 6
       **3   * 3** + 4 * 5 + 6
           **9   + 4** * 5 + 6
              **13   * 5** + 6
                  **65   + 6**
                      **71**
     ```

     Parentheses can override this order; for example, here is what happens if parentheses are added to form `1 + (2 * 3) + (4 * (5 + 6))`:

     ```
     1 + **(2 * 3)** + (4 * (5 + 6))
     **1 +    6**    + (4 * (5 + 6))
          7      + (4 * **(5 + 6)**)
          7      + **(4 *   11   )**
          **7      +     44**
                 **51**
     ```

     Here are a few more examples:

     - `2 * 3 + (4 * 5)` becomes **`26`**.
     - `5 + (8 * 3 + 9 + 3 * 4 * 3)` becomes **`437`**.
     - `5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))` becomes **`12240`**.
     - `((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2` becomes **`13632`**.

     Before you can help with the homework, you need to understand it yourself. **Evaluate the expression on each line of the homework; what is the sum of the resulting values?**
     */
    public func solvePart1() -> String {
        inputElements
            .map({ try! $0.parsed(.samePrecedence) })
            .map({ $0.evaluated() })
            .sum()
            .description
    }

    /**
     # --- Part Two ---

     You manage to answer the child's questions and they finish part 1 of their homework, but get stuck when they reach the next section: **advanced** math.

     Now, addition and multiplication have **different** precedence levels, but they're not the ones you're familiar with. Instead, addition is evaluated **before** multiplication.

     For example, the steps to evaluate the expression `1 + 2 * 3 + 4 * 5 + 6` are now as follows:

     ```
     **1 + 2** * 3 + 4 * 5 + 6
       3   * **3 + 4** * 5 + 6
       3   *   7   * **5 + 6**
       **3   *   7**   *  11
          **21       *  11**
              **231**
     ```

     Here are the other examples from above:

     - `1 + (2 * 3) + (4 * (5 + 6))` still becomes **`51`**.
     - `2 * 3 + (4 * 5)` becomes **`46`**.
     - `5 + (8 * 3 + 9 + 3 * 4 * 3)` becomes **`1445`**.
     - `5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))` becomes **`669060`**.
     - `((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2` becomes **`23340`**.

     **What do you get if you add up the results of evaluating the homework problems using these new rules?**
     */
    public func solvePart2() -> String {
        inputElements
            .map({ try! $0.parsed(.differentPrecedence) })
            .map({ $0.evaluated() })
            .sum()
            .description
    }
}

// MARK: - Input

public extension Day18Year2020 {
    struct RawExpression {
        var tokens: [Token]

        enum Token: Equatable {
            case number(Int)
            case sum
            case multiplication
            case openParenthesis
            case closedParenthesis
        }
    }

    typealias InputElement = RawExpression
}

extension Day18Year2020.RawExpression: ParseableFromString {
    public var description: String {
        tokens.withNext()
            .map({ lhs, rhs in
                switch (lhs, rhs) {
                case (.openParenthesis, _), (_, .closedParenthesis):
                    return "\(lhs.description)"
                default:
                    return "\(lhs.description) "
                }
            })
            .joined()
            + tokens.last!.description
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        let tokens = try scanner.scanAll(Token.self, separators: ["", " "])

        return .init(tokens: tokens)
    }
}

extension Day18Year2020.RawExpression.Token: ParseableFromString {
    public var description: String {
        switch self {
        case .number(let number): return "\(number)"
        case .sum: return "+"
        case .multiplication: return "*"
        case .openParenthesis: return "("
        case .closedParenthesis: return ")"
        }
    }

    static func parse(on scanner: Scanner) throws -> Self {
        if let number = scanner.scanInt() {
            return .number(number)
        } else if scanner.scanString("+") != nil {
            return .sum
        } else if scanner.scanString("*") != nil {
            return .multiplication
        } else if scanner.scanString("(") != nil {
            return .openParenthesis
        } else if scanner.scanString(")") != nil {
            return .closedParenthesis
        }
        throw ParseError.notAValidToken(scanner.remainingString)
    }

    enum ParseError: Error {
        case notAValidToken(String)
    }
}

// MARK: - Logic

extension Day18Year2020 {
    enum Expression {
        case number(Int)
        indirect case sum(Expression, Expression)
        indirect case multiplication(Expression, Expression)
    }

    enum ParsingRule {
        case samePrecedence
        case differentPrecedence
    }
}

extension Day18Year2020.Expression: CustomStringConvertible {
    var description: String {
        switch self {
        case .number(let number):
            return "\(number)"
        case .sum(let lhs, let rhs):
            return "(\(lhs.description) + \(rhs.description))"
        case .multiplication(let lhs, let rhs):
            return "(\(lhs.description) * \(rhs.description))"
        }
    }
}

extension Day18Year2020.Expression {
    static func parse <C: Collection> (from tokens: C, parsingRule: Day18Year2020.ParsingRule) throws -> Self
        where C.Element == Token
    {
        switch parsingRule {
        case .samePrecedence:
            return try parseBasic(from: tokens)
        case .differentPrecedence:
            return try parseAdvanced(from: tokens)
        }
    }

    private static func parseBasic <C: Collection> (from tokens: C) throws -> Self
        where C.Element == Token
    {
        try tokens
            .reduce(into: .start, { try parseBasic(token: $1, parsingState: &$0) })
            .makeExpression()
    }

    private static func parseBasic(token: Token, parsingState: inout ParsingState) throws {
        func applyOperator(_ op: Operator, lhs: Expression, rhs: Expression) -> Expression {
            switch op {
            case .sum:
                return .sum(lhs, rhs)
            case .multiplication:
                return .multiplication(lhs, rhs)
            }
        }

        switch (parsingState, token) {
        case (.start, .number(let lhs)):
            parsingState = .term(.number(lhs))
        case (.start, .openParenthesis):
            parsingState = .nested(.start)
        case (.term(let lhs), .sum):
            parsingState = .op(.sum, lhs: lhs)
        case (.term(let lhs), .multiplication):
            parsingState = .op(.multiplication, lhs: lhs)
        case (.op(let op, let lhs), .number(let rhs)):
            let applied = applyOperator(op, lhs: lhs, rhs: .number(rhs))
            parsingState = .term(applied)
        case (.op(let op, let lhs), .openParenthesis):
            parsingState = .nestedRHS(.start, lhs: lhs, op: op)
        case (.nested(.term(let expression)), .closedParenthesis):
            parsingState = .term(expression)
        case (.nested(var state), let token):
            try parseBasic(token: token, parsingState: &state)
            parsingState = .nested(state)
        case (.nestedRHS(.term(let expression), let lhs, let op), .closedParenthesis):
            let applied = applyOperator(op, lhs: lhs, rhs: expression)
            parsingState = .term(applied)
        case (.nestedRHS(var state, let lhs, let op), let token):
            try parseBasic(token: token, parsingState: &state)
            parsingState = .nestedRHS(state, lhs: lhs, op: op)
        default:
            throw ParseError.invalidToken(token: token, state: parsingState)
        }
    }

    private static func parseAdvanced <C: Collection> (from tokens: C) throws -> Self
        where C.Element == Token
    {
        try tokens
            .reduce(into: .start, { try parseAdvanced(token: $1, parsingState: &$0) })
            .makeExpression()
    }

    private static func parseAdvanced(token: Token, parsingState: inout ParsingState) throws {
        switch (parsingState, token) {
        case (.start, .number(let lhs)):
            parsingState = .term(.number(lhs))
        case (.start, .openParenthesis):
            parsingState = .nested(.start)
        case (.term(let lhs), .sum):
            parsingState = .op(.sum, lhs: lhs)
        case (.term(let lhs), .multiplication):
            parsingState = .op(.multiplication, lhs: lhs)
        case (.mult(let lhs, let rhs), .sum):
            parsingState = .sumAfterMult(lhs: lhs, rhs: rhs)
        case (.mult(let lhs, let rhs), .multiplication):
            parsingState = .op(.multiplication, lhs: .multiplication(lhs, rhs))
        case (.op(.sum, let lhs), .number(let rhs)):
            parsingState = .term(.sum(lhs, .number(rhs)))
        case (.op(.multiplication, let lhs), .number(let rhs)):
            parsingState = .mult(lhs: lhs, rhs: .number(rhs))
        case (.op(let op, let lhs), .openParenthesis):
            parsingState = .nestedRHS(.start, lhs: lhs, op: op)
        case (.sumAfterMult(let llhs, let lrhs), .number(let rhs)):
            parsingState = .mult(lhs: llhs, rhs: .sum(lrhs, .number(rhs)))
        case (.sumAfterMult(let lhs, let rhs), .openParenthesis):
            parsingState = .nestedRHSSumAfterMult(.start, lhs: lhs, rhs: rhs)
        case (.nested(.term(let expression)), .closedParenthesis):
            parsingState = .term(expression)
        case (.nested(.mult(let lhs, let rhs)), .closedParenthesis):
            parsingState = .term(.multiplication(lhs, rhs))
        case (.nested(var state), let token):
            try parseAdvanced(token: token, parsingState: &state)
            parsingState = .nested(state)
        case (.nestedRHS(.term(let expression), let lhs, .sum), .closedParenthesis):
            parsingState = .term(.sum(lhs, expression))
        case (.nestedRHS(.term(let expression), let lhs, .multiplication), .closedParenthesis):
            parsingState = .mult(lhs: lhs, rhs: expression)
        case (.nestedRHS(.mult(let rlhs, let rrhs), let lhs, .sum), .closedParenthesis):
            parsingState = .term(.sum(lhs, .multiplication(rlhs, rrhs)))
        case (.nestedRHS(.mult(let rlhs, let rrhs), let lhs, .multiplication), .closedParenthesis):
            parsingState = .mult(lhs: lhs, rhs: .multiplication(rlhs, rrhs))
        case (.nestedRHS(var state, let lhs, let op), let token):
            try parseAdvanced(token: token, parsingState: &state)
            parsingState = .nestedRHS(state, lhs: lhs, op: op)
        case (.nestedRHSSumAfterMult(.term(let expression), let lhs, let rhs), .closedParenthesis):
            parsingState = .mult(lhs: lhs, rhs: .sum(rhs, expression))
        case (.nestedRHSSumAfterMult(.mult(let rlhs, let rrhs), let llhs, let lrhs), .closedParenthesis):
            parsingState = .mult(lhs: llhs, rhs: .sum(lrhs, .multiplication(rlhs, rrhs)))
        case (.nestedRHSSumAfterMult(var state, let lhs, let rhs), let token):
            try parseAdvanced(token: token, parsingState: &state)
            parsingState = .nestedRHSSumAfterMult(state, lhs: lhs, rhs: rhs)
        default:
            throw ParseError.invalidToken(token: token, state: parsingState)
        }
    }

    enum ParsingState {
        case start
        case term(Expression)
        case mult(lhs: Expression, rhs: Expression)
        case op(Operator, lhs: Expression)
        case sumAfterMult(lhs: Expression, rhs: Expression)
        indirect case nested(Self)
        indirect case nestedRHS(Self, lhs: Expression, op: Operator)
        indirect case nestedRHSSumAfterMult(Self, lhs: Expression, rhs: Expression)

        func makeExpression() throws -> Expression {
            switch self {
            case .start:
                throw ParseError.noTokenAvailable
            case .op, .sumAfterMult:
                throw ParseError.incompleteExpression
            case .nested, .nestedRHS, .nestedRHSSumAfterMult:
                throw ParseError.incompleteParenthesis
            case .term(let expression):
                return expression
            case .mult(let lhs, let rhs):
                return .multiplication(lhs, rhs)
            }
        }
    }

    enum Operator {
        case sum
        case multiplication
    }

    enum ParseError: Error {
        case noTokenAvailable
        case incompleteExpression
        case incompleteParenthesis
        case invalidToken(token: Token, state: ParsingState)
    }

    typealias Token = Day18Year2020.RawExpression.Token
    typealias Expression = Self
}

extension Day18Year2020.Expression.ParsingState: CustomStringConvertible {
    var description: String {
        switch self {
        case .start: return ""
        case .term(let expr): return "\(expr)"
        case .mult(let lhs, let rhs): return "\(lhs) * \(rhs)"
        case .op(let op, let lhs): return "\(lhs) \(op)"
        case .sumAfterMult(let lhs, let rhs): return "\(lhs) * \(rhs) +"
        case .nested(let state): return "(\(state)"
        case .nestedRHS(let state, let lhs, let op): return "\(lhs) \(op) (\(state)"
        case .nestedRHSSumAfterMult(let state, let lhs, let rhs): return "\(lhs) * \(rhs) + (\(state)"
        }
    }
}

extension Day18Year2020.Expression.Operator: CustomStringConvertible {
    var description: String {
        switch self {
        case .sum: return "+"
        case .multiplication: return "*"
        }
    }
}

extension Day18Year2020.Expression {
    func evaluated() -> Int {
        switch self {
        case .number(let number):
            return number
        case .sum(let lhs, let rhs):
            return lhs.evaluated() + rhs.evaluated()
        case .multiplication(let lhs, let rhs):
            return lhs.evaluated() * rhs.evaluated()
        }
    }
}

extension Day18Year2020.RawExpression {
    func parsed(_ parsingRule: Day18Year2020.ParsingRule) throws -> Day18Year2020.Expression {
        try .parse(from: tokens, parsingRule: parsingRule)
    }
}
