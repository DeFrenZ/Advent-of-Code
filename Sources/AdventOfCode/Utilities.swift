public func memoized <Input: Hashable, Output> (
    _ operation: @escaping (_ continuation: @escaping (Input) -> Output) -> (Input) -> Output)
-> (Input) -> Output {
    var cache: [Input: Output] = [:]

    // Defining a nested function because otherwise the nested `memoize` call would create a new `storage` each time.
    func _memoized(_ operation: @escaping (_ continuation: @escaping (Input) -> Output) -> (Input) -> Output) -> (Input) -> Output {
        return { input in
            if let cachedOutput = cache[input] { return cachedOutput }
            let output = operation(_memoized(operation))(input)
            cache[input] = output
            return output
        }
    }

    return _memoized(operation)
}

public func memoized <Input: Hashable, Output> (_ operation: @escaping (Input) -> Output) -> (Input) -> Output {
    memoized { _ in operation }
}

public func memoized <InputA: Hashable, InputB: Hashable, Output> (
    _ operation: @escaping (_ continuation: @escaping (InputA, InputB) -> Output) -> (InputA, InputB) -> Output)
-> (InputA, InputB) -> Output {
    let pairMemoized = memoized({ (continuation: @escaping (Pair<InputA, InputB>) -> Output) -> (Pair<InputA, InputB>) -> Output in
        let argumentsContinuation = fromPairArgument(continuation)
        return toPairArgument(operation(argumentsContinuation))
    })
    return fromPairArgument(pairMemoized)
}

public func updated <T> (_ value: T, with update: (inout T) -> Void) -> T {
    var mutable = value
    update(&mutable)
    return mutable
}

infix operator ?!: NilCoalescingPrecedence

public func ?! <T> (_ lhs: T?, _ rhs: Error) throws -> T {
    guard let value = lhs else { throw rhs }
    return value
}
