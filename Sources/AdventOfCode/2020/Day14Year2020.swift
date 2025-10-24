import Foundation

public final class Day14Year2020: DaySolverWithInputs {
    public static let day = 14
    public static let year = 2020

    private let inputElements: [InputElement]

    public init(inputElements: [InputElement]) {
        self.inputElements = inputElements
    }

    /**
     # --- Day 14: Docking Data ---

     As your ferry approaches the sea port, the captain asks for your help again. The computer system that runs this port isn't compatible with the docking program on the ferry, so the docking parameters aren't being correctly initialized in the docking program's memory.

     After a brief inspection, you discover that the sea port's computer system uses a strange [https://en.wikipedia.org/wiki/Mask_(computing)](bitmask) system in its initialization program. Although you don't have the correct decoder chip handy, you can emulate it in software!

     The initialization program (your puzzle input) can either update the bitmask or write a value to memory. Values and memory addresses are both 36-bit unsigned integers. For example, ignoring bitmasks for a moment, a line like `mem[8] = 11` would write the value `11` to memory address `8`.

     The bitmask is always given as a string of 36 bits, written with the most significant bit (representing `2^35`) on the left and the least significant bit (`2^0`, that is, the `1`s bit) on the right. The current bitmask is applied to values immediately before they are written to memory: a `0` or `1` overwrites the corresponding bit in the value, while an `X` leaves the bit in the value unchanged.

     For example, consider the following program:

     ```
     mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
     mem[8] = 11
     mem[7] = 101
     mem[8] = 0
     ```

     This program starts by specifying a bitmask (`mask = ....`). The mask it specifies will overwrite two bits in every written value: the `2`s bit is overwritten with `0`, and the `64`s bit is overwritten with `1`.

     The program then attempts to write the value `11` to memory address `8`. By expanding everything out to individual bits, the mask is applied as follows:

     ```
     value:  000000000000000000000000000000001011  (decimal 11)
     mask:   XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
     result: 00000000000000000000000000000**1**0010**0**1  (decimal 73)
     ```

     So, because of the mask, the value `73` is written to memory address `8` instead. Then, the program tries to write `101` to address `7`:

     ```
     value:  000000000000000000000000000001100101  (decimal 101)
     mask:   XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
     result: 00000000000000000000000000000**1**1001**0**1  (decimal 101)
     ```

     This time, the mask has no effect, as the bits it overwrote were already the values the mask tried to set. Finally, the program tries to write `0` to address `8`:

     ```
     value:  000000000000000000000000000000000000  (decimal 0)
     mask:   XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
     result: 000000000000000000000000000001000000  (decimal 64)
     ```

     `64` is written to address `8` instead, overwriting the value that was there previously.

     To initialize your ferry's docking program, you need the sum of all values left in memory after the initialization program completes. (The entire 36-bit address space begins initialized to the value `0` at every address.) In the above example, only two values in memory are not zero - `101` (at address `7`) and `64` (at address `8`) - producing a sum of **`165`**.

     Execute the initialization program. **What is the sum of all values left in memory after it completes?**
     */
    public func solvePart1() -> String {
        executeInstructions(rule: .version1)
            .values
            .sum()
            .description
    }

    /**
     # --- Part Two ---

     For some reason, the sea port's computer system still can't communicate with your ferry's docking program. It must be using **version 2** of the decoder chip!

     A version 2 decoder chip doesn't modify the values being written at all. Instead, it acts as a [https://www.youtube.com/watch?v=PvfhANgLrm4](memory address decoder). Immediately before a value is written to memory, each bit in the bitmask modifies the corresponding bit of the destination **memory address** in the following way:

     - If the bitmask bit is `0`, the corresponding memory address bit is **unchanged**.
     - If the bitmask bit is `1`, the corresponding memory address bit is **overwritten with `1`**.
     - If the bitmask bit is `X`, the corresponding memory address bit is **floating**.

     A **floating** bit is not connected to anything and instead fluctuates unpredictably. In practice, this means the floating bits will take on **all possible values**, potentially causing many memory addresses to be written all at once!

     For example, consider the following program:

     ```
     mask = 000000000000000000000000000000X1001X
     mem[42] = 100
     mask = 00000000000000000000000000000000X0XX
     mem[26] = 1
     ```
     When this program goes to write to memory address `42`, it first applies the bitmask:

     ```
     address: 000000000000000000000000000000101010  (decimal 42)
     mask:    000000000000000000000000000000X1001X
     result:  000000000000000000000000000000**X1**10**1X**
     ```

     After applying the mask, four bits are overwritten, three of which are different, and two of which are **floating**. Floating bits take on every possible combination of values; with two floating bits, four actual memory addresses are written:

     ```
     000000000000000000000000000000**0**1101**0**  (decimal 26)
     000000000000000000000000000000**0**1101**1**  (decimal 27)
     000000000000000000000000000000**1**1101**0**  (decimal 58)
     000000000000000000000000000000**1**1101**1**  (decimal 59)
     ```

     Next, the program is about to write to memory address `26` with a different bitmask:

     ```
     address: 000000000000000000000000000000011010  (decimal 26)
     mask:    00000000000000000000000000000000X0XX
     result:  00000000000000000000000000000001**X**0**XX**
     ```

     This results in an address with three floating bits, causing writes to **eight** memory addresses:

     ```
     00000000000000000000000000000001**0**0**00**  (decimal 16)
     00000000000000000000000000000001**0**0**01**  (decimal 17)
     00000000000000000000000000000001**0**0**10**  (decimal 18)
     00000000000000000000000000000001**0**0**11**  (decimal 19)
     00000000000000000000000000000001**1**0**00**  (decimal 24)
     00000000000000000000000000000001**1**0**01**  (decimal 25)
     00000000000000000000000000000001**1**0**10**  (decimal 26)
     00000000000000000000000000000001**1**0**11**  (decimal 27)
     ```

     The entire 36-bit address space still begins initialized to the value 0 at every address, and you still need the sum of all values left in memory at the end of the program. In this example, the sum is **`208`**.

     Execute the initialization program using an emulator for a version 2 decoder chip. **What is the sum of all values left in memory after it completes?**
     */
    public func solvePart2() -> String {
        executeInstructions(rule: .version2)
            .values
            .sum()
            .description
    }
}

// MARK: - Input

public extension Day14Year2020 {
    enum Instruction {
        case updateMask(Bitmask)
        case writeToMemory(address: Int, value: Int)

        public enum Bit: Character {
            case setOne = "1"
            case setZero = "0"
            case dontChange = "X"
        }
        public typealias Bitmask = [Bit]
    }

    typealias InputElement = Instruction
    typealias ResolvedBitmask = Int
}

extension Day14Year2020.Instruction: ParseableFromString {
    public var description: String {
        switch self {
        case .updateMask(let bitmask):
            return "mask = \(bitmask.map(\.description).joined())"
        case .writeToMemory(let address, let value):
            return "mem[\(address)] = \(value)"
        }
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        if scanner.scanString("mask") != nil {
            _ = try scanner.scanString(" = ") ?! ParseError.notAValidMaskInstruction(scanner.remainingString)
            let mask = try scanner.scanAll(Bit.self) ?! ParseError.notAValidMask(scanner.remainingString)
            guard mask.count == 36 else { throw ParseError.notAValidMaskLength(mask) }
            return .updateMask(mask)
        } else if scanner.scanString("mem") != nil {
            _ = try scanner.scanString("[") ?! ParseError.notAValidWriteInstruction(scanner.remainingString)
            let address = try scanner.scanInt() ?! ParseError.notAValidWriteAddress(scanner.remainingString)
            _ = try scanner.scanString("] = ") ?! ParseError.notAValidWriteInstruction(scanner.remainingString)
            let value = try scanner.scanInt() ?! ParseError.notAValidWriteValue(scanner.remainingString)
            return .writeToMemory(address: address, value: value)
        }
        throw ParseError.notAValidInstruction(scanner.remainingString)
    }

    enum ParseError: Error {
        case notAValidMaskInstruction(String)
        case notAValidMask(String)
        case notAValidMaskLength([Bit])
        case notAValidWriteInstruction(String)
        case notAValidWriteAddress(String)
        case notAValidWriteValue(String)
        case notAValidInstruction(String)
    }
}

extension Day14Year2020.Instruction.Bit: ParseableFromString {}

// MARK: - Logic

extension Day14Year2020 {
    func executeInstructions(rule: Rule) -> [ResolvedBitmask: Int] {
        switch rule {
        case .version1:
            return executeInstructionsVersion1()
        case .version2:
            return executeInstructionsVersion2()
        }
    }

    func executeInstructionsVersion1() -> [ResolvedBitmask: Int] {
        var currentMasks: (and: ResolvedBitmask, or: ResolvedBitmask)!
        var memory: [ResolvedBitmask: Int] = [:]
        for instruction in inputElements {
            switch instruction {
            case .updateMask(let mask):
                currentMasks = Self.masksForBitmask(mask)
            case .writeToMemory(let address, let value):
                let maskedValue = value & currentMasks.and | currentMasks.or
                memory[address] = maskedValue
            }
        }
        return memory
    }

    func executeInstructionsVersion2() -> [ResolvedBitmask: Int] {
        var currentMask: Instruction.Bitmask!
        var memory: [ResolvedBitmask: Int] = [:]
        for instruction in inputElements {
            switch instruction {
            case .updateMask(let mask):
                currentMask = mask
            case .writeToMemory(let address, let value):
                let maskedAddress = Self.maskAddress(address, with: currentMask)
                let allAddresses = Self.allPossibleValues(forBitmask: maskedAddress)
                for address in allAddresses {
                    memory[address] = value
                }
            }
        }
        return memory
    }

    static func masksForBitmask(_ bitmask: Instruction.Bitmask) -> (and: ResolvedBitmask, or: ResolvedBitmask) {
        let andMask = bitmask.enumerated()
            .filter({ $0.element == .setZero })
            .map({ Instruction.Bit.zero(atOffset: $0.offset) })
            .reduce(into: Instruction.Bit.allOnesMask, { $0 &= $1 })
        let orMask = bitmask.enumerated()
            .filter({ $0.element == .setOne })
            .map({ Instruction.Bit.one(atOffset: $0.offset) })
            .reduce(into: Instruction.Bit.allZerosMask, { $0 |= $1 })
        return (andMask, orMask)
    }

    static func maskAddress(_ address: ResolvedBitmask, with mask: Instruction.Bitmask) -> Instruction.Bitmask {
        let base = bitmask(fromAddress: address)
        return zip(base, mask)
            .map({ addressBit, maskBit in
                switch (addressBit, maskBit) {
                case (_, .setZero): return addressBit
                case (_, .setOne): return .setOne
                case (_, .dontChange): return .dontChange
                }
            })
            .toArray()
    }

    static func bitmask(fromAddress address: ResolvedBitmask) -> Instruction.Bitmask {
        (0 ..< 36).reversed()
            .map({ offset in
                address >> offset & 0b1 == 0b1 ? .setOne : .setZero
            })
    }

    static func allPossibleValues(forBitmask bitmask: Instruction.Bitmask) -> Set<ResolvedBitmask> {
        let base = bitmask.enumerated()
            .filter({ $0.element == .setOne })
            .map({ Instruction.Bit.one(atOffset: $0.offset) })
            .sum()
        let floatingOffsets = bitmask.enumerated()
            .filter({ $0.element == .dontChange })
            .map(\.offset)
        let floatingValues = floatingOffsets
            .reduce([Instruction.Bit.allZerosMask], { values, offset in
                values.flatMap({ [$0, $0 + Instruction.Bit.one(atOffset: offset)] })
            })
        return floatingValues
            .map({ $0 + base })
            .toSet()
    }

    enum Rule {
        case version1
        case version2
    }
}

extension Day14Year2020.Instruction.Bit {
    func resolvedBitmask(atOffset offset: Int) -> Day14Year2020.ResolvedBitmask? {
        switch self {
        case .setOne: return Self.one(atOffset: offset)
        case .setZero: return Self.zero(atOffset: offset)
        case .dontChange: return nil
        }
    }

    static func one(atOffset offset: Int) -> Day14Year2020.ResolvedBitmask {
        0b1 << (35 - offset)
    }

    static func zero(atOffset offset: Int) -> Day14Year2020.ResolvedBitmask {
        allOnesMask - one(atOffset: offset)
    }

	static let allOnesMask: Day14Year2020.ResolvedBitmask = 0b111111111111111111111111111111111111
	static let allZerosMask: Day14Year2020.ResolvedBitmask = 0b000000000000000000000000000000000000
}
