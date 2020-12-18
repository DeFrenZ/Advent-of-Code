// MARK: - Point2

public struct Point2 <T> {
    public var x: T
    public var y: T
}

extension Point2: Equatable where T: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        (lhs.x, lhs.y) == (rhs.x, rhs.y)
    }
}

extension Point2: Hashable where T: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

extension Point2 where T: AdditiveArithmetic {
    public static var zero: Self { .init(x: .zero, y: .zero) }
}

// MARK: - Point3

public struct Point3 <T> {
    public var x: T
    public var y: T
    public var z: T
}

extension Point3: Equatable where T: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        (lhs.x, lhs.y, lhs.z) == (rhs.x, rhs.y, rhs.z)
    }
}

extension Point3: Hashable where T: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
    }
}

extension Point3 where T: AdditiveArithmetic {
    public static var zero: Self { .init(x: .zero, y: .zero, z: .zero) }
}

// MARK: - Point4

public struct Point4 <T> {
    public var x: T
    public var y: T
    public var z: T
    public var w: T
}

extension Point4: Equatable where T: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        (lhs.x, lhs.y, lhs.z, lhs.w) == (rhs.x, rhs.y, rhs.z, rhs.w)
    }
}

extension Point4: Hashable where T: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
        hasher.combine(w)
    }
}

extension Point4 where T: AdditiveArithmetic {
    public static var zero: Self { .init(x: .zero, y: .zero, z: .zero, w: .zero) }
}
