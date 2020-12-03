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
