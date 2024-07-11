import Foundation

// MARK: - LocationService

internal protocol LocationService {
    var state: AnySafePublisher<LoadingState> { get }

    func fetchLocations() async throws -> [Location]
}
