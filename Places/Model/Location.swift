import Foundation

// MARK: - LocationsResponse

internal struct LocationsResponse: Codable {
    let locations: [Location]
}

// MARK: - Location

internal struct Location: Codable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case name
        case coordinates
    }

    let name: String?
    let coordinates: Coordinates

    var wikipediaURL: URL? {
        guard let url = URL(string: "wikipedia://places?WMFLocation=\(coordinates.latitude),\(coordinates.longitude)") else {
            return nil
        }

        return url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try? container.decode(String.self, forKey: .name)
        self.coordinates = try Coordinates(from: decoder)
    }

    init(name: String? = nil, coordinates: Coordinates) {
        self.name = name
        self.coordinates = coordinates
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name && lhs.coordinates == rhs.coordinates
    }
}

// MARK: - Coordinates

internal struct Coordinates: Codable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "long"
    }

    let latitude: Double
    let longitude: Double

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
    }

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
