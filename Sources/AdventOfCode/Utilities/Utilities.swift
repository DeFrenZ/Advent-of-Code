import Foundation

// MARK: - Memoization

/// Memoize a function that calls itself recursively.
///
/// This cannot be caught from the outside, so the function needs to accept a "continuation" argument, and then a concrete implementation will call that by passing it again as the continuation.
/// Example:
/// ```
/// func fibonacci(_ n: Int, continuation: (Int) -> Int) -> Int {
///     guard n > 0 else { return 0 }
///     if n == 1 { return 1 }
///     return continuation(n - 2) + continuation(n - 1)
/// }
///
/// func fibonacci(_ n: Int) -> Int {
///     let fibonacciMemoized = memoized({ continuation in
///         { input in fibonacci(input, continuation) }
///     })
///     return fibonacciMemoized(n)
/// }
/// ```
/// Note: in the example above every call to `fibonacci(_:)` will have its own memoization cache
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

// MARK: - Update

public func updated <T> (_ value: T, with update: (inout T) -> Void) -> T {
    var mutable = value
    update(&mutable)
    return mutable
}

// MARK: - Unwrap or Throw

infix operator ?!: NilCoalescingPrecedence

public func ?! <T> (lhs: T?, rhs: Error) throws -> T {
    guard let value = lhs else { throw rhs }
    return value
}

struct UndefinedError: Error {}

// MARK: - Pipe

infix operator |>: FunctionArrowPrecedence

public func |> <T, U> (lhs: T, rhs: (T) throws -> U) rethrows -> U {
    try rhs(lhs)
}

// MARK: - Three-way comparison

infix operator <=>: ComparisonPrecedence

public func <=> <T: Comparable> (lhs: T, rhs: T) -> ComparisonResult {
    lhs.compared(to: rhs)
}
