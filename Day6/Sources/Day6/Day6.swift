class Day6 {
    let input: String

    init(input: String) {
        self.input = input
    }

    lazy var spaceObjects: Set<SpaceObject> = {
        let decoded = InputDecoder(input: input).decode()

        var objects = Set<SpaceObject>()

        for result in decoded {
            objects.insert(SpaceObject(name: result.a))
            objects.insert(SpaceObject(name: result.b))
        }

        for result in decoded {
            let spaceObjectA = objects.first(where: { $0.name == result.a })!
            let spaceObjectB = objects.first(where: { $0.name == result.b })!

            spaceObjectB.orbits = spaceObjectA
        }

        return objects
    }()

    func part1() -> Int {
        spaceObjects.reduce(0) { (number, spaceObject) -> Int in
            number + spaceObject.numberOfDirectAndIndirectOrbits
        }
    }

    func part2() -> Int {
        let you = spaceObjects.first(where: { $0.name == "YOU" })!
        let san = spaceObjects.first(where: { $0.name == "SAN" })!

        let mutualOrbitNames = Set(you.orbitNames).intersection(Set(san.orbitNames))

        let transfersToMutualOrbitYou = you.orbitNames.firstIndex(where: { mutualOrbitNames.contains($0) })!
        let transfersToMutualOrbitSan = san.orbitNames.firstIndex(where: { mutualOrbitNames.contains($0) })!

        return transfersToMutualOrbitSan + transfersToMutualOrbitYou
    }
}

class SpaceObject: Equatable, Hashable {
    let name: String
    var orbits: SpaceObject?

    init(name: String) {
        self.name = name
    }

    static func == (lhs: SpaceObject, rhs: SpaceObject) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    var numberOfDirectAndIndirectOrbits: Int {
        var value = 0
        if let orbits = orbits {
            value += 1
            value += orbits.numberOfDirectAndIndirectOrbits
        }
        return value
    }

    var orbitNames: [String] {
        var value = [String]()
        if let orbits = orbits {
            value.append(orbits.name)
            value.append(contentsOf: orbits.orbitNames)
        }
        return value
    }
}

struct InputDecoder {
    let input: String

    struct Result: Equatable {
        let a: String
        let b: String
    }

    func decode() -> [InputDecoder.Result] {
        input.split(separator: "\n").map { row in
            let objects = row.split(separator: ")")

            return Result(a: String(objects.first!), b: String(objects.last!))
        }
    }
}
