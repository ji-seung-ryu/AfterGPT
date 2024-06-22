import Foundation

struct APIManager {
    static var apiUrl: String {
        guard let apiUrl = Bundle.main.object(forInfoDictionaryKey: "Server_URL") as? String else {
            fatalError("Server_URL not defined in Info.plist")
        }
        return apiUrl
    }
}
