import class UIKit.UIApplication

internal class Router: RouterProtocol {
    func process(route: Route) {
        switch route {
        case let .wikipedia(location):
            if let url = location.wikipediaURL {
                UIApplication.shared.open(url)
            }
        }
    }
}
