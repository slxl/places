import Combine
import Foundation
import SwiftUI

extension LocationListComponent {
    class ViewModel: ObservableObject {
        // Observables
        @Published var items: [LocationItemViewModel] = []
        @Published var showingAddLocation = false
        @Published private(set) var isRefreshing = false

        // Public
        let deps: Deps
        let locationSubject = PassthroughSubject<Location, Never>()

        // Private
        private let localItems = SafeCurrentValueSubject<[LocationItemViewModel]>([])
        private var subs = Set<AnyCancellable>()

        // MARK: - Lifecycle

        init(deps: Deps) {
            self.deps = deps

            bindActivityIndicator()
            bindAddLocation()
        }

        // MARK: - Network

        func loadData() {
            Task {
                do {
                    let locations = try await deps.service.fetchLocations()

                    await MainActor.run {
                        self.items += locations.map { .init(location: $0) }
                    }
                } catch {
                    // catch errors
                }
            }
        }

        // MARK: - User actions

        func onCreateTap() {
            showingAddLocation = true
        }

        func onLocationTap(item: LocationItemViewModel) {
            deps.router.process(route: .wikipedia(item.location))
        }

        // MARK: - Constructors

        func createLocationViewModel() -> CreateLocationComponent.ViewModel {
            CreateLocationComponent.ViewModel(locationSubject: self.locationSubject)
        }

        // MARK: - Private

        private func bindActivityIndicator() {
            deps.service.state
                .receive(on: DispatchQueue.main)
                .map { $0 == .isLoading }
                .sink { [weak self] isLoading in
                    self?.isRefreshing = isLoading
                }
                .store(in: &subs)
        }

        private func bindAddLocation() {
            locationSubject
                .receive(on: DispatchQueue.main)
                .sink { _ in
                    self.showingAddLocation = false
                } receiveValue: { [weak self] location in
                    let locationItemViewModel = LocationItemViewModel(location: location)
                    self?.items.append(locationItemViewModel)
                }
                .store(in: &subs)
        }
    }
}
