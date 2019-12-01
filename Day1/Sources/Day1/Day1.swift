struct Module {
    let mass: Double

    func fuelRequirement(part: Part) -> Int {
        switch part {
        case .one:
            return Int((mass / 3).rounded(.down)) - 2
        case .two:
            let main = fuelRequirement(part: .one)
            return main + extraFuel(forFuel: main)
        }
    }

    private func extraFuel(forFuel fuel: Int) -> Int {
        let extra = fuel / 3 - 2

        guard extra > 0 else { return 0 }

        return extra + extraFuel(forFuel: extra)
    }
}

struct StructuredInput {
    let input: String

    var masses: [Double] {
        input.split(separator: "\n").compactMap({ Double($0) })
    }
}

enum Part {
    case one
    case two
}
