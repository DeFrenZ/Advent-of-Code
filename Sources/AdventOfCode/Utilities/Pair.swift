/// An object equivalent to a Tuple (A, B), but that can conform to protocols. Might be unnecessary once [SE-0283](https://github.com/apple/swift-evolution/blob/main/proposals/0283-tuples-are-equatable-comparable-hashable.md) gets merged in
public struct Pair<A, B> {
    public var a: A
    public var b: B

    public init(a: A, b: B) {
        self.a = a
        self.b = b
    }

    public init(_ tuple: Tuple) {
        self.init(a: tuple.0, b: tuple.1)
    }

    var asTuple: Tuple { (a, b) }

    public typealias Tuple = (A, B)
}

extension Pair: Equatable where A: Equatable, B: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.asTuple == rhs.asTuple
    }
}

extension Pair: Hashable where A: Hashable, B: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(a)
        hasher.combine(b)
    }
}

extension Pair: Comparable where A: Comparable, B: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.asTuple < rhs.asTuple
    }
}

public func toPairArgument <InputA, InputB, Output> (
    _ function: @escaping (InputA, InputB) -> Output)
-> (Pair<InputA, InputB>) -> Output {
    { pair in
        function(pair.a, pair.b)
    }
}

public func fromPairArgument <InputA, InputB, Output> (
    _ function: @escaping (Pair<InputA, InputB>) -> Output)
-> (InputA, InputB) -> Output {
    { a, b in
        function(.init(a: a, b: b))
    }
}
