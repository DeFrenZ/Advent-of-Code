import Benchmark
import AdventOfCode

let benchmarks: @Sendable () -> Void = {
	for daySolverType in allDaySolvers() {
		Benchmark("\(daySolverType)") { benchmark in
			blackHole(try daySolverType.computeSolutions())
		}
	}
}
