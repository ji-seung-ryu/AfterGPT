import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidServerConnection
    case invalidStatusCode(Int)
    case noDataReceived
    case serializationError(String)
    case invalidJSONString
    
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("올바르지 않은 URL입니다.", comment: "Invalid URL")
        case .invalidServerConnection:
            return NSLocalizedString("서버에 연결할 수 없습니다.\nWiFi 및 데이터 연결 상태를 확인해주세요.", comment: "Invalid server connection")
        case .invalidStatusCode(let code):
            return NSLocalizedString("올바르지 않은 상태 코드: \(code)", comment: "Invalid status code")
        case .noDataReceived:
            return NSLocalizedString("서버로부터 데이터를 수신하지 못했습니다.", comment: "No data received from the server")
        case .serializationError(let message):
            return NSLocalizedString("올바른 공유 url을 입력했는지 확인해주세요. 제대로 입력했음에도 계속해서 에러가 발생할 경우, 관리자에게 문의해주세요.", comment: "JSON Serialization Error")
        case .invalidJSONString:
            return NSLocalizedString("올바르지 않은 JSON 형식입니다.", comment: "Invalid JSON Error")
        }

    }
}

