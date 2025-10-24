import Foundation

public final class Day20Year2020: DaySolverWithInputs {
    public static let day = 20
    public static let year = 2020
    public static let elementsSeparator = "\n\n"

    private let inputElements: [InputElement]

    public init(inputElements: [InputElement]) {
        self.inputElements = inputElements
    }

    /**
     # --- Day 20: Jurassic Jigsaw ---

     The high-speed train leaves the forest and quickly carries you south. You can even see a desert in the distance! Since you have some spare time, you might as well see if there was anything interesting in the image the Mythical Information Bureau satellite captured.

     After decoding the satellite messages, you discover that the data actually contains many small images created by the satellite's **camera array**. The camera array consists of many cameras; rather than produce a single square image, they produce many smaller square image **tiles** that need to be **reassembled back into a single image**.

     Each camera in the camera array returns a single monochrome **image tile** with a random unique **ID number**. The tiles (your puzzle input) arrived in a random order.

     Worse yet, the camera array appears to be malfunctioning: each image tile has been **rotated and flipped to a random orientation**. Your first task is to reassemble the original image by orienting the tiles so they fit together.

     To show how the tiles should be reassembled, each tile's image data includes a border that should line up exactly with its adjacent tiles. All tiles have this border, and the border lines up exactly when the tiles are both oriented correctly. Tiles at the edge of the image also have this border, but the outermost edges won't line up with any other tiles.

     For example, suppose you have the following nine tiles:

     ```
     Tile 2311:
     ..##.#..#.
     ##..#.....
     #...##..#.
     ####.#...#
     ##.##.###.
     ##...#.###
     .#.#.#..##
     ..#....#..
     ###...#.#.
     ..###..###

     Tile 1951:
     #.##...##.
     #.####...#
     .....#..##
     #...######
     .##.#....#
     .###.#####
     ###.##.##.
     .###....#.
     ..#.#..#.#
     #...##.#..

     Tile 1171:
     ####...##.
     #..##.#..#
     ##.#..#.#.
     .###.####.
     ..###.####
     .##....##.
     .#...####.
     #.##.####.
     ####..#...
     .....##...

     Tile 1427:
     ###.##.#..
     .#..#.##..
     .#.##.#..#
     #.#.#.##.#
     ....#...##
     ...##..##.
     ...#.#####
     .#.####.#.
     ..#..###.#
     ..##.#..#.

     Tile 1489:
     ##.#.#....
     ..##...#..
     .##..##...
     ..#...#...
     #####...#.
     #..#.#.#.#
     ...#.#.#..
     ##.#...##.
     ..##.##.##
     ###.##.#..

     Tile 2473:
     #....####.
     #..#.##...
     #.##..#...
     ######.#.#
     .#...#.#.#
     .#########
     .###.#..#.
     ########.#
     ##...##.#.
     ..###.#.#.

     Tile 2971:
     ..#.#....#
     #...###...
     #.#.###...
     ##.##..#..
     .#####..##
     .#..####.#
     #..#.#..#.
     ..####.###
     ..#.#.###.
     ...#.#.#.#

     Tile 2729:
     ...#.#.#.#
     ####.#....
     ..#.#.....
     ....#..#.#
     .##..##.#.
     .#.####...
     ####.#.#..
     ##.####...
     ##..#.##..
     #.##...##.

     Tile 3079:
     #.#.#####.
     .#..######
     ..#.......
     ######....
     ####.#..#.
     .#...#.##.
     #.#####.##
     ..#.###...
     ..#.......
     ..#.###...
     ```

     By rotating, flipping, and rearranging them, you can find a square arrangement that causes all adjacent borders to line up:

     ```
     #...##.#.. ..###..### #.#.#####.
     ..#.#..#.# ###...#.#. .#..######
     .###....#. ..#....#.. ..#.......
     ###.##.##. .#.#.#..## ######....
     .###.##### ##...#.### ####.#..#.
     .##.#....# ##.##.###. .#...#.##.
     #...###### ####.#...# #.#####.##
     .....#..## #...##..#. ..#.###...
     #.####...# ##..#..... ..#.......
     #.##...##. ..##.#..#. ..#.###...

     #.##...##. ..##.#..#. ..#.###...
     ##..#.##.. ..#..###.# ##.##....#
     ##.####... .#.####.#. ..#.###..#
     ####.#.#.. ...#.##### ###.#..###
     .#.####... ...##..##. .######.##
     .##..##.#. ....#...## #.#.#.#...
     ....#..#.# #.#.#.##.# #.###.###.
     ..#.#..... .#.##.#..# #.###.##..
     ####.#.... .#..#.##.. .######...
     ...#.#.#.# ###.##.#.. .##...####

     ...#.#.#.# ###.##.#.. .##...####
     ..#.#.###. ..##.##.## #..#.##..#
     ..####.### ##.#...##. .#.#..#.##
     #..#.#..#. ...#.#.#.. .####.###.
     .#..####.# #..#.#.#.# ####.###..
     .#####..## #####...#. .##....##.
     ##.##..#.. ..#...#... .####...#.
     #.#.###... .##..##... .####.##.#
     #...###... ..##...#.. ...#..####
     ..#.#....# ##.#.#.... ...##.....
     ```

     For reference, the IDs of the above tiles are:

     ```
     **1951**    2311   ** 3079**
     2729    1427    2473
     **2971**    1489    **1171**
     ```

     To check that you've assembled the image correctly, multiply the IDs of the four corner tiles together. If you do this with the assembled tiles from the example above, you get `1951 * 3079 * 2971 * 1171` = **`20899048083289`**.

     Assemble the tiles into an image. **What do you get if you multiply together the IDs of the four corner tiles?**
     */
    public func solvePart1() -> String {
        let assembled = Self.assembled(inputElements)
        let corners = Self.corners(of: assembled)
        return corners.product()
            .description
    }

    /**

     */
    public func solvePart2() -> String {
        0
            .description
    }
}

// MARK: - Input

public extension Day20Year2020 {
    struct Tile: Identifiable, Hashable {
        public var id: ID
        public var imageData: Matrix2<Pixel>

        public enum Pixel: Character {
            case full = "#"
            case empty = "."
        }

        public typealias ID = Int
    }

    typealias InputElement = Tile
}

extension Day20Year2020.Tile: ParseableFromString {
    public var description: String {
        let image = imageData.rows
            .map({ $0.map({ String($0.rawValue) }).joined() })
            .joined(separator: "\n")
        return """
        Tile \(id):
        \(image)
        """
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        _ = try scanner.scanString("Tile ") ?! ParseError.noTile(scanner.remainingString)
        let id = try scanner.scanInt() ?! ParseError.invalidID(scanner.remainingString)
        _ = try scanner.scanString(":\n") ?! ParseError.noPeriod(scanner.remainingString)
        let imageRows = try scanner.scanAll([Pixel].self, separators: ["\n"], stopAt: ["\n\n"])

        let imageData = try Matrix2(imageRows)
        return .init(id: id, imageData: imageData)
    }

    enum ParseError: Error {
        case noTile(String)
        case invalidID(String)
        case noPeriod(String)
    }
}

extension Day20Year2020.Tile.Pixel: ParseableFromString {}

// MARK: - Logic

extension Day20Year2020 {
    static func assembled(_ tiles: [Tile]) -> Matrix2<Tile.ID> {
        let tilesPermutationsByID = Dictionary(indexingUniqueValues: tiles)
            .mapValues({ $0.imageDataPermutations() })
        fatalError()
    }

    static func corners <T> (of matrix: Matrix2<T>) -> [T] {
        [
            matrix[row: 0, column: 0],
            matrix[row: 0, column: matrix.elementsPerRow - 1],
            matrix[row: matrix.elementsPerRow - 1, column: 0],
            matrix[row: matrix.elementsPerRow - 1, column: matrix.elementsPerRow - 1],
        ]
    }
}

extension Day20Year2020.Tile {
    func imageDataPermutations() -> [Transformation: Matrix2<Pixel>] {
        Transformation.allCases
            .map({ ($0, transformedImageData($0)) })
            |> Dictionary.init(uniqueKeysWithValues:)
    }

    func transformedImageData(_ transformation: Transformation) -> Matrix2<Pixel> {
        switch (transformation.flipped, transformation.rotation) {
        case (false, .zero): return imageData
        case (false, .one): return imageData.rotatedClockwise()
        case (false, .two): return imageData.rotated180()
        case (false, .three): return imageData.rotatedCounterClockwise()
        case (true, .zero): return imageData.flippedHorizontally()
        case (true, .one): return imageData.flippedHorizontally().rotatedClockwise()
        case (true, .two): return imageData.flippedVertically()
        case (true, .three): return imageData.flippedHorizontally().rotatedCounterClockwise()
        }
    }

    struct Transformation: Hashable, CaseIterable {
        var flipped: Bool
        var rotation: Rotation

        enum Rotation: CaseIterable {
            case zero
            case one
            case two
            case three
        }

        static let allCases: [Self] = Rotation.allCases
            .flatMap({ [.init(flipped: false, rotation: $0), .init(flipped: true, rotation: $0)] })
    }
}
