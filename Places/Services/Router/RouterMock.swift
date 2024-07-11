import Foundation

internal class RouterMock: RouterProtocol {
    var route: Route?

    func process(route: Route) {
        self.route = route
    }
}
