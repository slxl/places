import Combine
@testable import Places
import XCTest

// swiftlint:disable implicitly_unwrapped_optional prefer_nimble

internal class ViewModelTests: XCTestCase {
    private var viewModel: CreateLocationComponent.ViewModel!
    private var locationSubject: PassthroughSubject<Location, Never>!
    private var subscriptions = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        locationSubject = PassthroughSubject<Location, Never>()
        viewModel = CreateLocationComponent.ViewModel(locationSubject: locationSubject)
    }

    override func tearDown() {
        viewModel = nil
        locationSubject = nil
        subscriptions = []
        super.tearDown()
    }

    func testValidation() {
        // Initial state
        XCTAssertFalse(viewModel.isValid)

        // Valid latitude and longitude
        viewModel.latitude = "51.5074"
        viewModel.longitude = "0.1278"
        XCTAssertTrue(viewModel.isValid)

        // Invalid latitude
        viewModel.latitude = "invalid"
        XCTAssertFalse(viewModel.isValid)

        // Invalid longitude
        viewModel.latitude = "51.5074"
        viewModel.longitude = "invalid"

        XCTAssertFalse(viewModel.isValid)
    }

    func testValidateAndSave() {
        // Prepare
        var receivedLocation: Location?

        locationSubject.sink { _ in
        } receiveValue: { location in
            receivedLocation = location
        }
        .store(in: &subscriptions)

        // Execute
        viewModel.latitude = "51.5074"
        viewModel.longitude = "0.1278"
        let result = viewModel.validateAndSave()

        // Assert
        XCTAssertTrue(result, "validateAndSave should return true")
        XCTAssertNotNil(receivedLocation)
        XCTAssertEqual(receivedLocation?.name, "")
        XCTAssertEqual(receivedLocation?.coordinates.latitude ?? 0.0, 51.5074, accuracy: 0.001)
        XCTAssertEqual(receivedLocation?.coordinates.longitude ?? 0.0, 0.1278, accuracy: 0.001)
    }

    func testDismiss() {
        let expectation = self.expectation(description: "Completion sent")

        locationSubject.sink { completion in
            if case .finished = completion {
                expectation.fulfill()
            }
        } receiveValue: { _ in
            XCTFail("Unexpected value received")
        }
        .store(in: &subscriptions)

        viewModel.dismiss()

        wait(for: [expectation], timeout: 1.0)
    }
}

// swiftlint:enable implicitly_unwrapped_optional prefer_nimble
