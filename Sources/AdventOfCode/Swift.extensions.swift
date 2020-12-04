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
}

extension Sequence {
    public func compacted <T> () -> [T] where Element == T? {
        compactMap({ $0 })
    }
}
