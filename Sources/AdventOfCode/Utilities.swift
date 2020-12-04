public func memoized <Input: Hashable, Output> (_ operation: @escaping (Input) -> Output) -> (Input) -> Output {
    var cache: [Input: Output] = [:]
    return { input in
        if let cachedOutput = cache[input] {
            return cachedOutput
        }

        let output = operation(input)
        cache[input] = output
        return output
    }
}

infix operator ?!: NilCoalescingPrecedence

public func ?! <T> (_ lhs: T?, _ rhs: Error) throws -> T {
    guard let value = lhs else { throw rhs }
    return value
}
