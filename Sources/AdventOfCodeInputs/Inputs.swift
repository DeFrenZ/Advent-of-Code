import Foundation

public enum Inputs {
	public static func puzzleInput(year: Int, day: Int) throws -> String {
		let inputURL = Bundle.module.url(forResource: "\(year)-\(day)", withExtension: "txt")!
		let input = try String(contentsOf: inputURL, encoding: .utf8)
		return input
	}
}
