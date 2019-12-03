import Foundation

struct Day3 {
    var input: String

    func pointsList() -> [[Point]] {
        let stepsList = InputDecoder(input: input).decode()
        return stepsList.map { steps -> [Point] in
            var points = [Point]()

            steps.forEach { step in
                points.append(contentsOf: (points.last ?? Point.zero).walking(step: step))
            }

            return points
        }
    }

    func intersections() -> Set<Point> {
        let list = pointsList()

        return Set(list.first!).intersection(Set(list.last!))
    }

    func part1() -> Int {
        intersections().map({ Point.zero.manhattanDistance(to: $0) }).min()!
    }

    func part2() -> Int {
        let list = pointsList()
        let a = list.first!
        let b = list.last!
        let intersects = intersections()

        var steps = [Int]()

        for intersect in intersects {
            let aSteps = a.firstIndex(of: intersect)! + 1
            let bSteps = b.firstIndex(of: intersect)! + 1
            steps.append(aSteps + bSteps)
        }

        return steps.min()!
    }
}

struct Point: Equatable, Hashable {
    static var zero = Point(x: 0, y: 0)

    var x: Int
    var y: Int

    func manhattanDistance(to point: Point) -> Int {
        return (abs(self.x - point.x) + abs(self.y - point.y))
    }

    func walking(direction: Direction) -> Point {
        switch direction {
        case .down:
            return Point(x: x, y: y + 1)
        case .left:
            return Point(x: x - 1, y: y)
        case .right:
            return Point(x: x + 1, y: y)
        case .up:
            return Point(x: x, y: y - 1)
        }
    }

    func walking(step: Step) -> [Point] {
        (0..<step.distance).reduce([Point]()) { result, integer in
            var result = result
            result.append((result.last ?? self).walking(direction: step.direction))
            return result
        }
    }
}

struct InputDecoder {
    var input: String

    func decode() -> [[Step]] {
        input.split(separator: "\n").map { row in
            row.split(separator: ",").map { rawStep in
                let rawDirection = rawStep.trimmingCharacters(in: .integers)
                let distance = Int(rawStep.trimmingCharacters(in: .letters))!

                return Step(direction: Direction(rawValue: rawDirection)!,
                            distance: distance)
            }
        }
    }
}

struct Step: Equatable {
    let direction: Direction
    let distance: Int
}

enum Direction: String {
    case up = "U"
    case right = "R"
    case down = "D"
    case left = "L"
}

extension CharacterSet {
    static let integers = CharacterSet(charactersIn: "0123456789")
}
