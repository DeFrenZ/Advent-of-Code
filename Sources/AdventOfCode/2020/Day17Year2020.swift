import Algorithms

public final class Day17Year2020: DaySolverWithInputs {
    public static let day = 17
    public static let year = 2020

    private let inputElements: [InputElement]

    public init(inputElements: [InputElement]) {
        self.inputElements = inputElements
    }

    /**
     # --- Day 17: Conway Cubes ---

     As your flight slowly drifts through the sky, the Elves at the Mythical Information Bureau at the North Pole contact you. They'd like some help debugging a malfunctioning experimental energy source aboard one of their super-secret imaging satellites.

     The experimental energy source is based on cutting-edge technology: a set of Conway Cubes contained in a pocket dimension! When you hear it's having problems, you can't help but agree to take a look.

     The pocket dimension contains an infinite 3-dimensional grid. At every integer 3-dimensional coordinate (`x,y,z`), there exists a single cube which is either **active** or **inactive**.

     In the initial state of the pocket dimension, almost all cubes start **inactive**. The only exception to this is a small flat region of cubes (your puzzle input); the cubes in this region start in the specified **active** (`#`) or **inactive** (`.`) state.

     The energy source then proceeds to boot up by executing six **cycles**.

     Each cube only ever considers its **neighbors**: any of the 26 other cubes where any of their coordinates differ by at most `1`. For example, given the cube at `x=1,y=2,z=3`, its neighbors include the cube at `x=2,y=2,z=2`, the cube at `x=0,y=2,z=3`, and so on.

     During a cycle, **all** cubes **simultaneously** change their state according to the following rules:

     - If a cube is **active** and **exactly `2` or `3`** of its neighbors are also active, the cube remains **active**. Otherwise, the cube becomes **inactive**.
     - If a cube is **inactive** but **exactly `3`** of its neighbors are active, the cube becomes **active**. Otherwise, the cube remains **inactive**.

     The engineers responsible for this experimental energy source would like you to simulate the pocket dimension and determine what the configuration of cubes should be at the end of the six-cycle boot process.

     For example, consider the following initial state:

     ```
     .#.
     ..#
     ###
     ```

     Even though the pocket dimension is 3-dimensional, this initial state represents a small 2-dimensional slice of it. (In particular, this initial state defines a 3x3x1 region of the 3-dimensional space.)

     Simulating a few cycles from this initial state produces the following configurations, where the result of each cycle is shown layer-by-layer at each given z coordinate (and the frame of view follows the active cells in each cycle):

     ```
     Before any cycles:

     z=0
     .#.
     ..#
     ###


     After 1 cycle:

     z=-1
     #..
     ..#
     .#.

     z=0
     #.#
     .##
     .#.

     z=1
     #..
     ..#
     .#.


     After 2 cycles:

     z=-2
     .....
     .....
     ..#..
     .....
     .....

     z=-1
     ..#..
     .#..#
     ....#
     .#...
     .....

     z=0
     ##...
     ##...
     #....
     ....#
     .###.

     z=1
     ..#..
     .#..#
     ....#
     .#...
     .....

     z=2
     .....
     .....
     ..#..
     .....
     .....


     After 3 cycles:

     z=-2
     .......
     .......
     ..##...
     ..###..
     .......
     .......
     .......

     z=-1
     ..#....
     ...#...
     #......
     .....##
     .#...#.
     ..#.#..
     ...#...

     z=0
     ...#...
     .......
     #......
     .......
     .....##
     .##.#..
     ...#...

     z=1
     ..#....
     ...#...
     #......
     .....##
     .#...#.
     ..#.#..
     ...#...

     z=2
     .......
     .......
     ..##...
     ..###..
     .......
     .......
     .......
     ```

     After the full six-cycle boot process completes, `112` cubes are left in the **active** state.

     Starting with your given initial configuration, simulate six cycles. How many cubes are left in the active state after the sixth cycle?
     */
    public func solvePart1() -> String {
        cycledStates(from: initialState3, findNeighbors: Self.neighbors(of:includeIndex:))
            .element(atOffset: 6)!
            .count
            .description
    }

    /**
     # --- Part Two ---

     For some reason, your simulated results don't match what the experimental energy source engineers expected. Apparently, the pocket dimension actually has **four spatial dimensions**, not three.

     The pocket dimension contains an infinite 4-dimensional grid. At every integer 4-dimensional coordinate (`x,y,z,w`), there exists a single cube (really, a **hypercube**) which is still either **active** or **inactive**.

     Each cube only ever considers its **neighbors**: any of the 80 other cubes where any of their coordinates differ by at most `1`. For example, given the cube at `x=1,y=2,z=3,w=4`, its neighbors include the cube at `x=2,y=2,z=3,w=3`, the cube at `x=0,y=2,z=3,w=4`, and so on.

     The initial state of the pocket dimension still consists of a small flat region of cubes. Furthermore, the same rules for cycle updating still apply: during each cycle, consider the **number of active neighbors** of each cube.

     For example, consider the same initial state as in the example above. Even though the pocket dimension is 4-dimensional, this initial state represents a small 2-dimensional slice of it. (In particular, this initial state defines a 3x3x1x1 region of the 4-dimensional space.)

     Simulating a few cycles from this initial state produces the following configurations, where the result of each cycle is shown layer-by-layer at each given `z` and `w` coordinate:

     ```
     Before any cycles:

     z=0, w=0
     .#.
     ..#
     ###


     After 1 cycle:

     z=-1, w=-1
     #..
     ..#
     .#.

     z=0, w=-1
     #..
     ..#
     .#.

     z=1, w=-1
     #..
     ..#
     .#.

     z=-1, w=0
     #..
     ..#
     .#.

     z=0, w=0
     #.#
     .##
     .#.

     z=1, w=0
     #..
     ..#
     .#.

     z=-1, w=1
     #..
     ..#
     .#.

     z=0, w=1
     #..
     ..#
     .#.

     z=1, w=1
     #..
     ..#
     .#.


     After 2 cycles:

     z=-2, w=-2
     .....
     .....
     ..#..
     .....
     .....

     z=-1, w=-2
     .....
     .....
     .....
     .....
     .....

     z=0, w=-2
     ###..
     ##.##
     #...#
     .#..#
     .###.

     z=1, w=-2
     .....
     .....
     .....
     .....
     .....

     z=2, w=-2
     .....
     .....
     ..#..
     .....
     .....

     z=-2, w=-1
     .....
     .....
     .....
     .....
     .....

     z=-1, w=-1
     .....
     .....
     .....
     .....
     .....

     z=0, w=-1
     .....
     .....
     .....
     .....
     .....

     z=1, w=-1
     .....
     .....
     .....
     .....
     .....

     z=2, w=-1
     .....
     .....
     .....
     .....
     .....

     z=-2, w=0
     ###..
     ##.##
     #...#
     .#..#
     .###.

     z=-1, w=0
     .....
     .....
     .....
     .....
     .....

     z=0, w=0
     .....
     .....
     .....
     .....
     .....

     z=1, w=0
     .....
     .....
     .....
     .....
     .....

     z=2, w=0
     ###..
     ##.##
     #...#
     .#..#
     .###.

     z=-2, w=1
     .....
     .....
     .....
     .....
     .....

     z=-1, w=1
     .....
     .....
     .....
     .....
     .....

     z=0, w=1
     .....
     .....
     .....
     .....
     .....

     z=1, w=1
     .....
     .....
     .....
     .....
     .....

     z=2, w=1
     .....
     .....
     .....
     .....
     .....

     z=-2, w=2
     .....
     .....
     ..#..
     .....
     .....

     z=-1, w=2
     .....
     .....
     .....
     .....
     .....

     z=0, w=2
     ###..
     ##.##
     #...#
     .#..#
     .###.

     z=1, w=2
     .....
     .....
     .....
     .....
     .....

     z=2, w=2
     .....
     .....
     ..#..
     .....
     .....
     ```

     After the full six-cycle boot process completes, **`848`** cubes are left in the **active** state.

     Starting with your given initial configuration, simulate six cycles in a 4-dimensional space. **How many cubes are left in the active state after the sixth cycle?**
     */
    public func solvePart2() -> String {
        cycledStates(from: initialState4, findNeighbors: Self.neighbors(of:includeIndex:))
            .element(atOffset: 6)!
            .count
            .description
    }
}

// MARK: - Input

public extension Day17Year2020 {
    enum CubeState: Character {
        case active = "#"
        case inactive = "."
    }

    typealias InputElement = [CubeState]
    typealias PocketDimensionState<Index: Hashable> = [Index: Void]
}

extension Day17Year2020.CubeState: ParseableFromString {}

// MARK: - Logic

extension Day17Year2020 {
    var initialState: PocketDimensionState<Point2<Int>> {
        let statesMatrix = [Point2<Int>: CubeState](grid: inputElements)
        return statesMatrix
            .compactMapValues({ $0 == .active ? () : nil })
    }

    var initialState3: PocketDimensionState<Point3<Int>> {
        let pairs = initialState.map({ (key: Point3(x: $0.key.x, y: $0.key.y, z: 0), value: $0.value) })
        return .init(uniqueKeysWithValues: pairs)
    }

    var initialState4: PocketDimensionState<Point4<Int>> {
        let pairs = initialState.map({ (key: Point4(x: $0.key.x, y: $0.key.y, z: 0, w: 0), value: $0.value) })
        return .init(uniqueKeysWithValues: pairs)
    }

    func cycledStates <Index: Hashable> (
        from initialState: PocketDimensionState<Index>,
        findNeighbors: @escaping (Index, Bool) -> [Index])
    -> AnySequence<PocketDimensionState<Index>> {
        sequence(
            state: initialState,
            next: { state in
                defer { Self.cycleState(&state, findNeighbors: findNeighbors) }
                return state
            })
            .eraseToAnySequence()
    }

    static func neighbors(of index: Point3<Int>, includeIndex: Bool) -> [Point3<Int>] {
        let deltas = product(product(-1 ... 1, -1 ... 1), -1 ... 1)
            .map({ Point3(x: $0.0, y: $0.1, z: $1) })
        let appliedDeltas = includeIndex ? deltas : deltas.filter({ $0 != .zero })
        return appliedDeltas.map({
            .init(
                x: index.x + $0.x,
                y: index.y + $0.y,
                z: index.z + $0.z)
        })
    }

    static func neighbors(of index: Point4<Int>, includeIndex: Bool) -> [Point4<Int>] {
        let deltas = product(product(product(-1 ... 1, -1 ... 1), -1 ... 1), -1 ... 1)
            .map({ Point4(x: $0.0.0, y: $0.0.1, z: $0.1, w: $1) })
        let appliedDeltas = includeIndex ? deltas : deltas.filter({ $0 != .zero })
        return appliedDeltas.map({
            .init(
                x: index.x + $0.x,
                y: index.y + $0.y,
                z: index.z + $0.z,
                w: index.w + $0.w)
        })
    }

    static func stateOfCube <Index: Hashable> (
        from cubeState: CubeState,
        at index: Index,
        in state: PocketDimensionState<Index>,
        findNeighbors: (Index, Bool) -> [Index])
    -> CubeState {
        let activeNeighborsCount = findNeighbors(index, false)
            .count(where: { state[$0] != nil })

        switch (cubeState, activeNeighborsCount) {
        case (.active, 2), (.active, 3), (.inactive, 3):
            return .active
        case (.active, _), (.inactive, _):
            return .inactive
        }
    }

    static func cycleState <Index: Hashable> (
        _ state: inout PocketDimensionState<Index>,
        findNeighbors: (Index, Bool) -> [Index])
    {
        let previousState = state
        let involvedIndices = previousState.keys
            .flatMap({ findNeighbors($0, true) })
            |> Set.init
        for index in involvedIndices {
            let newCubeState = stateOfCube(
                from: previousState[cubeStateIndex: index],
                at: index,
                in: previousState,
                findNeighbors: findNeighbors)
            state[cubeStateIndex: index] = newCubeState
        }
    }

    private static func prettyPrint(_ state: PocketDimensionState<Point3<Int>>) {
        let xRange = state.keys.elementsRange(on: \.x)!
        let yRange = state.keys.elementsRange(on: \.y)!
        let zRange = state.keys.elementsRange(on: \.z)!

        for z in zRange {
            print("z=\(z)")
            for y in yRange {
                for x in xRange {
                    let index = Point3(x: x, y: y, z: z)
                    let character = state[cubeStateIndex: index].rawValue
                    print(character, terminator: "")
                }
                print()
            }
            print()
        }
    }
}

private extension Dictionary where Value == Void {
    subscript(cubeStateIndex index: Key) -> Day17Year2020.CubeState {
        get { self[index].map({ _ in .active }) ?? .inactive }
        set { self[index] = newValue == .active ? () : nil }
    }
}

private extension Dictionary where Key == Point2<Int> {
    init(grid: [[Value]]) {
        self = [:]
        for (yIndex, row) in grid.enumerated() {
            for (xIndex, element) in row.enumerated() {
                let index = Key(x: xIndex, y: yIndex)
                self[index] = element
            }
        }
    }
}
