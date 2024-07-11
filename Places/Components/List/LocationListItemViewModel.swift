import Foundation

extension LocationListComponent {
    struct LocationItemViewModel: Identifiable {
        let id = UUID().uuidString

        let location: Location

        var name: String {
            location.name ?? "unknown location"
        }

        var coordinatesString: String {
            "\(location.coordinates.latitude), \(location.coordinates.longitude)"
        }

        init(location: Location) {
            self.location = location
        }
    }
}
