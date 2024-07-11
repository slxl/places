import Foundation

// swiftformat:sort
internal enum Route: Equatable {
    case wikipedia(Location)

    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.wikipedia(location1), .wikipedia(location2)):
            return location1 == location2
        }
    }
}
