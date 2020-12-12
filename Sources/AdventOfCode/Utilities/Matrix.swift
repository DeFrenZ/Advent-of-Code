public struct Matrix2 <Element> {
    private var elements: [Element]
    public let elementsPerRow: Int

    private init(uncheckedElements elements: [Element], columns: Int) {
        self.elements = elements
        self.elementsPerRow = columns
    }

    public init(_ elements: [Element], elementsPerRow columns: Int) throws {
        guard columns > 0 else { throw ValidationError.invalidDimension }
        guard elements.count.isMultiple(of: columns) else { throw ValidationError.invalidElementCount }
        self.init(uncheckedElements: elements, columns: columns)
    }

    public init(_ grid: [[Element]]) throws {
        guard let columns = grid.first?.count else { throw ValidationError.empty }
        guard grid.map(\.count).allSatisfy({ $0 == columns }) else { throw ValidationError.notGridShaped }
        let elements = grid.flattened()
        try self.init(elements, elementsPerRow: columns)
    }

    enum ValidationError: Error {
        case invalidDimension
        case invalidElementCount
        case notGridShaped
        case empty
    }

    public typealias Row = [Element]
    public typealias Position = (row: Int, column: Int)
}

extension Matrix2 {
    var elementsPerColumn: Int { elements.count / elementsPerRow }
    var validRowIndices: Range<Int> { 0 ..< elementsPerColumn }
    var validColumnIndices: Range<Int> { 0 ..< elementsPerRow }

    func index(_ position: Position) -> Index {
        .init(position.row * elementsPerRow + position.column)
    }
    func position(for index: Index) -> Position {
        (
            row: index.rawValue / elementsPerRow,
            column: index.rawValue % elementsPerRow)
    }
    subscript(position: Position) -> Element {
        get { self[index(position)] }
        set { self[index(position)] = newValue }
    }
    subscript(row row: Int, column column: Int) -> Element {
        get { self[(row: row, column: column)] }
        set { self[(row: row, column: column)] = newValue }
    }
}

// MARK: - Collection

extension Matrix2: RandomAccessCollection, MutableCollection {
    public var startIndex: Index { .init(elements.startIndex) }
    public var endIndex: Index { .init(elements.endIndex) }
    public func index(after i: Index) -> Index { .init(elements.index(after: i.rawValue)) }
    public func index(before i: Index) -> Index { .init(elements.index(before: i.rawValue)) }

    public subscript(position: Index) -> Element {
        get { elements[position.rawValue] }
        set { self.elements[position.rawValue] = newValue }
    }

    public struct Index: Hashable, Comparable {
        fileprivate var rawValue: Row.Index
        fileprivate init(_ rawValue: Row.Index) {
            self.rawValue = rawValue
        }

        public static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }
}

// MARK: - stdlib

extension Matrix2: Equatable where Element: Equatable {}

extension Matrix2: Hashable where Element: Hashable {}
