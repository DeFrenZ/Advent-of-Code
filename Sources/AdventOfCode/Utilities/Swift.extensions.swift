import Algorithms

// MARK: - BinaryInteger

extension BinaryInteger {
    func firstMultiple(after threshold: Self) -> Self {
        threshold + self - (threshold % self)
    }

    // Greater Common Divisor
    static func gcd(_ lhs: Self, _ rhs: Self) -> Self {
        // https://en.wikipedia.org/wiki/Euclidean_algorithm
        assert(lhs > 0 && rhs > 0)

        switch lhs <=> rhs {
        case .orderedSame: return lhs
        case .orderedDescending: return gcd(lhs - rhs, rhs)
        case .orderedAscending: return gcd(lhs, rhs - lhs)
        }
    }

    func isCoprime(to other: Self) -> Bool {
        Self.gcd(self, other) == 1
    }

    func primeFactors() -> [Self: Int] {
        // https://en.wikipedia.org/wiki/Trial_division
        assert(self > 0)

        var foundPrimes: [Self: Int] = [:]
        var currentFactor: Self = 2
        var remainingValue = self
        while remainingValue > 1 {
            guard remainingValue.isMultiple(of: currentFactor) else {
                currentFactor += 1
                continue
            }
            foundPrimes[currentFactor, default: 0] += 1
            remainingValue /= currentFactor
        }
        return foundPrimes
    }
}

extension BinaryInteger where Self: SignedNumeric {
    // Least Common Multiplier
    static func lcm(_ lhs: Self, _ rhs: Self) -> Self {
        // https://en.wikipedia.org/wiki/Least_common_multiple#Using_the_greatest_common_divisor
        (abs(lhs) / gcd(lhs, rhs)) * abs(rhs)
    }
}

extension BinaryInteger where Self.Stride == Self {
    func inRange(_ range: Range<Self>) -> Self {
        let offset = (self - range.lowerBound) % range.span + range.lowerBound
        return offset < range.lowerBound
            ? offset + range.span
            : offset
    }

    // Chinese Remainder Theorem
    static func crt(_ congruences: [(divisor: Self, remainder: Self)]) -> Self? {
        // https://en.wikipedia.org/wiki/Chinese_remainder_theorem#Search_by_sieving
        // TODO: Use Bézout coefficients instead. https://en.wikipedia.org/wiki/Chinese_remainder_theorem#Using_the_existence_construction
        let sortedCongruences = congruences
            .sorted(on: \.divisor)
            .reversed()
            .map({ (divisor: $0.divisor, remainder: $0.remainder.inRange(0 ..< $0.divisor)) })

        guard let firstCongruence = sortedCongruences.first else { return nil }

        var currentSolution = firstCongruence.remainder
        var currentMultiple = firstCongruence.divisor
        for congruence in sortedCongruences.dropFirst() {
            while currentSolution % congruence.divisor != congruence.remainder {
                currentSolution += currentMultiple
            }
//            assert(currentMultiple.isCoprime(to: congruence.divisor), "should use lcm instead if they're not coprime")
            currentMultiple *= congruence.divisor
        }
        return currentSolution
    }
}

// MARK: - Bool

extension Bool {
    public var not: Self {
        !self
    }
}

// MARK: - Collection

extension Collection {
    public func index(atOffset offset: Int) -> Index? {
        index(startIndex, offsetBy: offset, limitedBy: endIndex)
    }

    public subscript (offset offset: Int) -> Element? {
        guard
            let index = index(atOffset: offset),
            indices.contains(index)
        else { return nil }
        return self[index]
    }
}

extension Collection {
    public func index(atOffsetCycled offset: Int) -> Index? {
        let cycleSize = distance(from: startIndex, to: endIndex)
        guard cycleSize > 0 else { return nil }
        let cycledOffset = offset % cycleSize
        return index(atOffset: cycledOffset)
    }

    public subscript (offsetCycled offset: Int) -> Element? {
        guard let index = index(atOffsetCycled: offset) else { return nil }
        return self[index]
    }
}

extension Collection {
    public func pairs() -> [(Element, Element)] {
        combinations(ofCount: 2)
            .map({ ($0[0], $0[1]) })
    }

    public func trios() -> [(Element, Element, Element)] {
        combinations(ofCount: 3)
            .map({ ($0[0], $0[1], $0[2]) })
    }
}

extension Collection {
    var onlyValue: Element? {
        guard count == 1 else { return nil }
        return first
    }
}

// MARK: - Dictionary

extension Dictionary where Value == Int {
    public init <S: Sequence> (countingOccurrencesOf sequence: S) where Key == S.Element {
        self.init()
        for element in sequence {
            self[element, default: 0] += 1
        }
    }
}

extension Dictionary {
    public init <S: Sequence> (
        indexing values: S,
        by keyForValue: (Value) throws -> Key,
        uniquingKeysWith combine: (Value, Value) throws -> Value)
    rethrows where S.Element == Value {
        func uniqueValue(from values: [Value]) throws -> Value? {
            guard let first = values.first else { return nil }
            return try values.dropFirst().reduce(first, combine)
        }

        let grouped = try Dictionary<Key, [Value]>(grouping: values, by: keyForValue)
        // `uniqueValue(from:)` returns `nil` only when is empty, and `init(grouping:by:)` doesn't have empty values
        self = try grouped.mapValues({ try uniqueValue(from: $0)! })
    }
}

extension Dictionary where Value: Hashable {
    init <S: Sequence> (indexingUniqueValues values: S) where S.Element == Value, Key == Value {
        self.init(
            indexing: values,
            by: { $0 },
            uniquingKeysWith: { fatalError("Given sequence has non-unique values \($0) and \($1): \(values)") })
    }
}

extension Dictionary {
    mutating func mapValuesInPlace(_ transform: (inout Value) throws -> Void) rethrows {
        for (key, var value) in self {
            try transform(&value)
            self[key] = value
        }
    }
}

// MARK: - Range

extension Range where Bound: Strideable {
    var span: Bound.Stride {
        lowerBound.distance(to: upperBound)
    }
}

// MARK: - Sequence

extension Sequence where Element: AdditiveArithmetic {
    public func sum() -> Element {
        reduce(.zero, +)
    }
}

extension Sequence where Element: Numeric {
    public func product() -> Element {
        reduce(1, *)
    }
}

extension Sequence {
    public func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        for element in self where try predicate(element) {
            count += 1
        }
        return count
    }

    func reduce(_ nextPartialResult: (_ partialResult: Element, Element) throws -> Element) rethrows -> Element? {
        var iterator = makeIterator()
        guard let initialResult = iterator.next() else { return nil }
        return try IteratorSequence(iterator).reduce(initialResult, nextPartialResult)
    }

    func reduce(_ nextPartialResult: (_ partialResult: inout Element, Element) throws -> Void) rethrows -> Element? {
        var iterator = makeIterator()
        guard let initialResult = iterator.next() else { return nil }
        return try IteratorSequence(iterator).reduce(into: initialResult, nextPartialResult)
    }

    public func scan <Result> (_ initialResult: Result, nextResult: @escaping (Result, Element) -> Result) -> AnyIterator<Result> {
        var currentResult: Result = initialResult
        var didPublishInitialResult = false
        var baseIterator = self.makeIterator()
        return AnyIterator<Result> {
            guard didPublishInitialResult else {
                didPublishInitialResult = true
                return initialResult
            }

            guard let nextElement = baseIterator.next() else { return nil }
            currentResult = nextResult(currentResult, nextElement)
            return currentResult
        }
    }

    public func toArray() -> [Element] {
        map({ $0 })
    }

    public func eraseToAnySequence() -> AnySequence<Element> {
        AnySequence(self)
    }

    public func compacted <T> () -> [T] where Element == T? {
        compactMap({ $0 })
    }

    public func flattened <T> () -> [T] where Element == [T] {
        flatMap({ $0 })
    }

    public func min <T: Comparable> (on transform: (Element) throws -> T) rethrows -> Element? {
        try self.min(by: { try transform($0) < transform($1) })
    }

    public func max <T: Comparable> (on transform: (Element) throws -> T) rethrows -> Element? {
        try self.max(by: { try transform($0) < transform($1) })
    }

    public func sorted <T: Comparable> (on transform: (Element) throws -> T) rethrows -> [Element] {
        try self.sorted(by: { try transform($0) < transform($1) })
    }

    public func elementsRange <T: Comparable> (on transform: (Element) throws -> T) rethrows -> ClosedRange<T>? {
        let transformedElements = try map(transform)
        guard
            let min = transformedElements.min(),
            let max = transformedElements.max()
        else { return nil }
        return min ... max
    }

    public func element(atOffset offset: Int) -> Element? {
        enumerated()
            .first(where: { $0.offset == offset })?
            .element
    }
}

extension Sequence {
    public func withPrevious() -> AnySequence<(current: Element, previous: Element)> {
        var iterator = makeIterator()
        guard let first = iterator.next() else { return [].eraseToAnySequence() }
        return sequence(state: (iterator: iterator, current: first), next: { state in
            guard let next = iterator.next() else { return nil }
            let previous = state.current
            state.current = next
            return (next, previous)
        }).eraseToAnySequence()
    }

    public func withNext() -> AnySequence<(current: Element, next: Element)> {
        withPrevious()
            .lazy
            .map({ ($1, $0) })
            .eraseToAnySequence()
    }
}

extension Sequence where Element: Equatable {
    public func count(occurrencesOf element: Element) -> Int {
        count(where: { $0 == element })
    }
}

extension Sequence where Element: Hashable {
    public func toSet() -> Set<Element> {
        Set(self)
    }
}

extension Sequence where Element: BinaryInteger {
    public func gcd() -> Element? {
        reduce(Element.gcd)
    }
}

extension Sequence where Element: BinaryInteger, Element: SignedNumeric {
    public func lcm() -> Element? {
        reduce(Element.lcm)
    }
}
