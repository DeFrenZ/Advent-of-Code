public func memoized <Input: Hashable, Output> (_ operation: @escaping (Input) -> Output) -> (Input) -> Output {
    var cache: [Input: Output] = [:]
    return { input in
        if let cachedOutput = cache[input] {
            return cachedOutput
        }

        let output = operation(input)
        cache[input] = output
        return output
    }
}
