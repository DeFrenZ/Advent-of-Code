import Algorithms

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

// MARK: - Dictionary

extension Dictionary where Value == Int {
    public init <S: Sequence> (countingOccurrencesOf sequence: S) where Key == S.Element {
        self.init()
        for element in sequence {
            self[element, default: 0] += 1
        }
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

    public func max <T: Comparable> (on transform: (Element) throws -> T) rethrows -> Element? {
        try self.max(by: { try transform($0) < transform($1) })
    }

    public func sorted <T: Comparable> (on transform: (Element) throws -> T) rethrows -> [Element] {
        try self.sorted(by: { try transform($0) < transform($1) })
    }
}

extension Sequence where Element: Hashable {
    public func toSet() -> Set<Element> {
        Set(self)
    }
}
