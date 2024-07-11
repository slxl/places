import Foundation

internal enum LocationListComponent {
    struct Deps {
        let service: LocationService
        let router: RouterProtocol
    }
}
