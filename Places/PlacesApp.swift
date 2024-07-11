import SwiftUI

@main
internal struct PlacesApp: App {
    var body: some Scene {
        WindowGroup {
            LocationListComponent.LocationListView(
                viewModel: .init(
                    deps: .init(
                        service: LocationNetworkService(),
                        router: Router()
                    )
                )
            )
        }
    }
}
