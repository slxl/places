import Combine
@testable import Places
import XCTest

// swiftlint:disable implicitly_unwrapped_optional prefer_nimble
internal class LocationListComponentTests: XCTestCase {
    private var viewModel: LocationListComponent.ViewModel!
    private var networkService: LocationMockService!
    private var router: RouterMock!

    override func setUp() {
        super.setUp()
        networkService = LocationMockService()
        router = RouterMock()
        viewModel = LocationListComponent.ViewModel(deps: .init(service: networkService, router: router))
    }

    override func tearDown() {
        viewModel = nil
        networkService = nil
        router = nil
        super.tearDown()
    }

    func testLoadData() {
        // Given
        let expectation = expectation(description: "Data loaded successfully")

        // When
        viewModel.loadData()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.viewModel.items.count, 4)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)
    }

    func testOnCreateTap() {
        // When
        viewModel.onCreateTap()

        // Then
        XCTAssertTrue(viewModel.showingAddLocation)
    }

    func testOnLocationTap() {
        // Given
        let item = LocationListComponent.LocationItemViewModel(
            location: Location(name: "Test Location", coordinates: .init(latitude: 1, longitude: 1))
        )

        // When
        viewModel.onLocationTap(item: item)

        // Then
        XCTAssertEqual(router.route, Route.wikipedia(item.location))
    }

    func testShowingAddLocationBinding() {
        // Given
        let expectation = expectation(description: "Show add location state updated")

        // When
        viewModel.locationSubject.send(Location(name: "Test Location", coordinates: .init(latitude: 1, longitude: 1)))

        // Then
        DispatchQueue.main.async {
            XCTAssertFalse(self.viewModel.showingAddLocation)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}

// swiftlint:enable implicitly_unwrapped_optional prefer_nimble
