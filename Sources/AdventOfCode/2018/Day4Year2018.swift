import Foundation

public final class Day4Year2018: DaySolverWithInputs {
    public static let day = 4
    public static let year = 2018

    private let inputElements: [InputElement]

    public init(inputElements: [InputElement]) {
        self.inputElements = inputElements
    }

    /**
     # --- Day 4: Repose Record ---

     You've sneaked into another supply closet - this time, it's across from the prototype suit manufacturing lab. You need to sneak inside and fix the issues with the suit, but there's a guard stationed outside the lab, so this is as close as you can safely get.

     As you search the closet for anything that might help, you discover that you're not the first person to want to sneak in. Covering the walls, someone has spent an hour starting every midnight for the past few months secretly observing this guard post! They've been writing down the ID of **the one guard on duty that night** - the Elves seem to have decided that one guard was enough for the overnight shift - as well as when they fall asleep or wake up while at their post (your puzzle input).

     For example, consider the following records, which have already been organized into chronological order:

     ```
     [1518-11-01 00:00] Guard #10 begins shift
     [1518-11-01 00:05] falls asleep
     [1518-11-01 00:25] wakes up
     [1518-11-01 00:30] falls asleep
     [1518-11-01 00:55] wakes up
     [1518-11-01 23:58] Guard #99 begins shift
     [1518-11-02 00:40] falls asleep
     [1518-11-02 00:50] wakes up
     [1518-11-03 00:05] Guard #10 begins shift
     [1518-11-03 00:24] falls asleep
     [1518-11-03 00:29] wakes up
     [1518-11-04 00:02] Guard #99 begins shift
     [1518-11-04 00:36] falls asleep
     [1518-11-04 00:46] wakes up
     [1518-11-05 00:03] Guard #99 begins shift
     [1518-11-05 00:45] falls asleep
     [1518-11-05 00:55] wakes up
     ```

     Timestamps are written using `year-month-day hour:minute` format. The guard falling asleep or waking up is always the one whose shift most recently started. Because all asleep/awake times are during the midnight hour (`00:00` - `00:59`), only the minute portion (`00` - `59`) is relevant for those events.

     Visually, these records show that the guards are asleep at these times:

     ```
     Date   ID   Minute
                 000000000011111111112222222222333333333344444444445555555555
                 012345678901234567890123456789012345678901234567890123456789
     11-01  #10  .....####################.....#########################.....
     11-02  #99  ........................................##########..........
     11-03  #10  ........................#####...............................
     11-04  #99  ....................................##########..............
     11-05  #99  .............................................##########.....
     ```

     The columns are Date, which shows the month-day portion of the relevant day; ID, which shows the guard on duty that day; and Minute, which shows the minutes during which the guard was asleep within the midnight hour. (The Minute column's header shows the minute's ten's digit in the first row and the one's digit in the second row.) Awake is shown as `.`, and asleep is shown as `#`.

     Note that guards count as asleep on the minute they fall asleep, and they count as awake on the minute they wake up. For example, because Guard #10 wakes up at 00:25 on 1518-11-01, minute 25 is marked as awake.

     If you can figure out the guard most likely to be asleep at a specific time, you might be able to trick that guard into working tonight so you can have the best chance of sneaking in. You have two strategies for choosing the best guard/minute combination.

     **Strategy 1:** Find the guard that has the most minutes asleep. What minute does that guard spend asleep the most?

     In the example above, Guard #10 spent the most minutes asleep, a total of 50 minutes (20+25+5), while Guard #99 only slept for a total of 30 minutes (10+10+10). Guard #**10** was asleep most during minute **24** (on two days, whereas any other minute the guard was asleep was only seen on one day).

     While this example listed the entries in chronological order, your entries are in the order you found them. You'll need to organize them before they can be analyzed.

     **What is the ID of the guard you chose multiplied by the minute you chose?** (In the above example, the answer would be `10 * 24 = 240`.)
     */
    public func solvePart1() -> String {
        (sleepiestGuardID * minuteThatSleepiestGuardSleptTheMostOn)
            .description
    }

    /**
     # --- Part Two ---

     **Strategy 2:** Of all guards, which guard is most frequently asleep on the same minute?

     In the example above, Guard #**99** spent minute **45** asleep more than any other guard or minute - three times in total. (In all other cases, any guard spent any minute asleep at most twice.)

     **What is the ID of the guard you chose multiplied by the minute you chose?** (In the above example, the answer would be `99 * 45 = 4455`.)
     */
    public func solvePart2() -> String {
        (guardIDWithSleepiestMinute * sleepiestMinute)
            .description
    }
}

// MARK: - Input

public extension Day4Year2018 {
    struct RecordEntry {
        var date: Date
        var event: Event

        enum Event {
            case guardBeginsShift(guardID: Int)
            case guardFallsAsleep
            case guardWakesUp
        }
    }

    struct GuardSleepLog {
        var guardID: Int
        var minutesAsleep: Range<Int>
    }

    typealias InputElement = RecordEntry
}

extension Day4Year2018.RecordEntry: ParseableFromString {
    public var description: String {
        "[\(Self.dateFormatter.string(from: date))] \(event)"
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        _ = try scanner.scanString("[") ?! ParseError.onOpenSquareBracket(scanner.remainingString)
        let dateString = try scanner.scanUpToString("]") ?! ParseError.onDateString(scanner.remainingString)
        let date = try dateFormatter.date(from: dateString) ?! ParseError.onDateFormatting(dateString: dateString)
        _ = try scanner.scanString("] ") ?! ParseError.onClosedSquareBracket(scanner.remainingString)
        let event = try scanner.scan(Event.self)

        return Self(date: date, event: event)
    }

    public enum ParseError: Error {
        case onOpenSquareBracket(String)
        case onDateString(String)
        case onDateFormatting(dateString: String)
        case onClosedSquareBracket(String)
    }

    private static let dateFormatter = DateFormatter.apiDateFormatter(format: "yyyy-MM-dd HH:mm")
}

extension Day4Year2018.RecordEntry.Event: ParseableFromString {
    var description: String {
        switch self {
        case .guardBeginsShift(let guardID):
            return "Guard #\(guardID) begins shift"
        case .guardFallsAsleep:
            return "falls asleep"
        case .guardWakesUp:
            return "wakes up"
        }
    }

    static func parse(on scanner: Scanner) throws -> Self {
        switch scanner.remainingString.first {
        case "f":
            _ = try scanner.scanString("falls asleep") ?! ParseError.notValidForFallsAsleep(scanner.remainingString)
            return .guardFallsAsleep
        case "w":
            _ = try scanner.scanString("wakes up") ?! ParseError.notValidForWakesUp(scanner.remainingString)
            return .guardWakesUp
        case "G":
            guard
                scanner.scanString("Guard #") != nil,
                let guardID = scanner.scanInt(),
                scanner.scanString(" begins shift") != nil
            else { throw ParseError.notValidForChangeShift(scanner.remainingString) }
            return .guardBeginsShift(guardID: guardID)
        default:
            throw ParseError.notAValidCase(scanner.remainingString)
        }
    }

    enum ParseError: Error {
        case notAValidCase(String)
        case notValidForFallsAsleep(String)
        case notValidForWakesUp(String)
        case notValidForChangeShift(String)
    }
}

// MARK: - Logic

private extension Day4Year2018 {
    var sleepLogs: [GuardSleepLog] {
        let sortedRecords = inputElements.sorted(on: \.date)
        guard case .guardBeginsShift(let firstGuardID) = sortedRecords.first?.event else { fatalError("First event should be a guard shift") }

        let sleepLogs = sortedRecords
            .dropFirst()
            .reduce(
                into: (currentGuardID: firstGuardID, fellAsleepAtMinute: nil, collectedLogs: []) as SleepLogAccumulator,
                { accumulator, element in
                    let eventMinute = Calendar.api.component(.minute, from: element.date)
                    switch (element.event, accumulator.fellAsleepAtMinute) {
                    case (.guardBeginsShift(let guardID), nil):
                        accumulator.currentGuardID = guardID
                    case (.guardFallsAsleep, nil):
                        accumulator.fellAsleepAtMinute = eventMinute
                    case (.guardWakesUp, let fellAsleepAtMinute?):
                        let sleepLog = GuardSleepLog(
                            guardID: accumulator.currentGuardID,
                            minutesAsleep: fellAsleepAtMinute ..< eventMinute
                        )
                        accumulator.collectedLogs.append(sleepLog)
                        accumulator.fellAsleepAtMinute = nil
                    case (.guardBeginsShift, _?),
                         (.guardFallsAsleep, _?),
                         (.guardWakesUp, nil):
                        fatalError("Invalid event succession")
                    }
                })
                .collectedLogs
        return sleepLogs
    }

    var sleepGraphByGuardID: [Int: [Int]] {
        let sleepLogsByGuardID = Dictionary(grouping: sleepLogs, by: \.guardID)
            .mapValues({
                $0.map(\.minutesAsleep)
            })
        let sleepGraphByGuardID = sleepLogsByGuardID
            .mapValues({
                $0.reduce(into: Array(repeating: 0, count: 60), {
                    for minute in $1 {
                        $0[minute] += 1
                    }
                })
            })
        return sleepGraphByGuardID
    }

    var sleepiestGuardID: Int {
        sleepGraphByGuardID
            .mapValues({ $0.sum() })
            .max(on: \.value)!
            .key
    }

    var minuteThatSleepiestGuardSleptTheMostOn: Int {
        let minuteThatSleepiestGuardSleptTheMostOnTimes = sleepGraphByGuardID[sleepiestGuardID]!
            .max()!
        return sleepGraphByGuardID[sleepiestGuardID]!
            .firstIndex(of: minuteThatSleepiestGuardSleptTheMostOnTimes)!
    }

    var guardIDWithSleepiestMinute: Int {
        sleepGraphByGuardID
            .mapValues({ $0.max()! })
            .max(on: \.value)!
            .key
    }

    var sleepiestMinuteSleptTimes: Int {
        sleepGraphByGuardID[guardIDWithSleepiestMinute]!
            .max()!
    }

    var sleepiestMinute: Int {
        sleepGraphByGuardID[guardIDWithSleepiestMinute]!
            .firstIndex(of: sleepiestMinuteSleptTimes)!
    }

    private typealias SleepLogAccumulator = (currentGuardID: Int, fellAsleepAtMinute: Int?, collectedLogs: [GuardSleepLog])
}
