import Foundation

internal final class LocationMockService: LocationService {
    private enum Constants {
        static let delay: UInt64 = 1_000_000_000
    }

    var stateSubject = SafeCurrentValueSubject(LoadingState.unknown)
    lazy var state: AnySafePublisher<LoadingState> = stateSubject.eraseToAnyPublisher()

    func fetchLocations() async throws -> [Location] {
        stateSubject.value = .isLoading

        try? await Task.sleep(nanoseconds: Constants.delay)

        stateSubject.value = .didLoad

        guard let url = Bundle.main.url(forResource: GlobalConstants.locationsMockURL, withExtension: "json") else {
            throw NSError(domain: "Mock JSON file not found", code: 0, userInfo: nil)
        }

        let jsonData = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(LocationsResponse.self, from: jsonData)

        return response.locations
    }
}
