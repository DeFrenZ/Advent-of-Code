import SwiftGraph

extension Graph where V: Hashable, E: Hashable {
    // https://www.baeldung.com/cs/simple-paths-between-two-vertices
    func allPaths(from startVertex: V, to endVertex: V) -> Set<VertexPath> {
        var state = AllPathsSearchState<V>()

        func dfs(state: inout AllPathsSearchState<V>, u: V, v: V) {
            guard state.visited.contains(u).not else { return }
            state.visited.insert(u)
            state.currentPath.append(u)

            guard v != u else {
                state.results.insert(state.currentPath)
                state.visited.remove(u)
                state.currentPath.removeLast()
                return
            }

            for next in neighborsForVertex(u) ?? [] {
                dfs(state: &state, u: next, v: v)
            }

            state.currentPath.removeLast()
            state.visited.remove(u)
        }

        dfs(state: &state, u: startVertex, v: endVertex)
        return state.results
    }

    typealias VertexPath = [V]
}

private struct AllPathsSearchState<Vertex: Hashable> {
    var visited: Set<Vertex> = []
    var currentPath: Path = []
    var results: Set<Path> = []

    typealias Path = [Vertex]
}

extension UnweightedEdge: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(u)
        hasher.combine(v)
        hasher.combine(directed)
    }
}

extension WeightedEdge: Hashable where W: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(u)
        hasher.combine(v)
        hasher.combine(directed)
        hasher.combine(weight)
    }
}
