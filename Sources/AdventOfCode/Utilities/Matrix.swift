public struct Matrix2 <Element> {
    private var elements: Storage
    public let elementsPerRow: Int

    private init(uncheckedElements elements: Storage, columns: Int) {
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

    fileprivate typealias Storage = [Element]
    public typealias RowIndex = Int
    public typealias ColumnIndex = Int
    public typealias Position = (row: RowIndex, column: ColumnIndex)
}

extension Matrix2 {
    var elementsPerColumn: Int { elements.count / elementsPerRow }
    var validRowIndices: Range<RowIndex> { 0 ..< elementsPerColumn }
    var validColumnIndices: Range<ColumnIndex> { 0 ..< elementsPerRow }

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
    subscript(row row: RowIndex, column column: ColumnIndex) -> Element {
        get { self[(row: row, column: column)] }
        set { self[(row: row, column: column)] = newValue }
    }
}

extension Matrix2 {
    public var rows: AnySequence<ArraySlice<Element>> {
        validRowIndices
            .lazy
            .map(row(atIndex:))
            .eraseToAnySequence()
    }

    public func row(atIndex index: RowIndex) -> ArraySlice<Element> {
        let startIndex = self.index((row: index, column: 0)).rawValue
        let endIndex = elements.index(startIndex, offsetBy: elementsPerRow)
        return elements[startIndex ..< endIndex]
    }

    public var columns: AnySequence<AnySequence<Element>> {
        validColumnIndices
            .lazy
            .map(column(atIndex:))
            .eraseToAnySequence()
    }

    public func column(atIndex index: ColumnIndex) -> AnySequence<Element> {
        let indices = validRowIndices
            .map({ (row: $0, column: index) })
            .map(self.index)
            .map(\.rawValue)
        let rangeSet = RangeSet(indices, within: elements)
        return elements[rangeSet]
            .eraseToAnySequence()
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
        fileprivate var rawValue: Storage.Index
        fileprivate init(_ rawValue: Storage.Index) {
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
