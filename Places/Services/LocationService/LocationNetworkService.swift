import Foundation

internal final class LocationNetworkService: LocationService {
    var stateSubject = SafeCurrentValueSubject(LoadingState.unknown)
    lazy var state: AnySafePublisher<LoadingState> = stateSubject.eraseToAnyPublisher()

    func fetchLocations() async throws -> [Location] {
        stateSubject.value = .isLoading

        guard let url = URL(string: GlobalConstants.locationsURL) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        stateSubject.value = .didLoad

        let decoder = JSONDecoder()
        let response = try decoder.decode(LocationsResponse.self, from: data)

        return response.locations
    }
}
