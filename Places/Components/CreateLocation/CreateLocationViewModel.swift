import Combine
import Foundation

extension CreateLocationComponent {
    class ViewModel: ObservableObject {
        @Published var name: String = ""
        @Published var latitude: String = ""
        @Published var longitude: String = ""
        @Published var isValid = false

        private let locationSubject: PassthroughSubject<Location, Never>
        private var subs = Set<AnyCancellable>()

        init(locationSubject: PassthroughSubject<Location, Never>) {
            self.locationSubject = locationSubject

            bindVaidation()
        }

        // MARK: - Public

        func validateAndSave() -> Bool {
            guard
                let latitudeDouble = Double(latitude),
                let longitudeDouble = Double(longitude) else {
                return false
            }

            let location = Location(
                name: name,
                coordinates: Coordinates(
                    latitude: latitudeDouble,
                    longitude: longitudeDouble
                )
            )

            locationSubject.send(location)

            return true
        }

        func dismiss() {
            locationSubject.send(completion: .finished)
        }

        // MARK: - Private

        private func bindVaidation() {
            Publishers.CombineLatest($latitude, $longitude)
                .compactMap { latitude, longitude in
                    Double(latitude) != nil && Double(longitude) != nil
                }
                .assign(to: \.isValid, on: self)
                .store(in: &subs)
        }
    }
}
