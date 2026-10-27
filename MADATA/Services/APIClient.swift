import Foundation

enum APIError: LocalizedError {
    case invalidResponse, server(String)
    var errorDescription:String? { switch self { case .invalidResponse: "Respuesta inválida del servidor"; case .server(let m): m } }
}

final class APIClient {
    static let shared = APIClient(); private init() {}
    private let decoder: JSONDecoder = { let d=JSONDecoder(); return d }()

    func send<T:Decodable>(_ path:String, method:String="GET", body:[String:Any]?=nil) async throws -> T {
        guard let url=URL(string:path, relativeTo:AppConfig.apiBaseURL) else { throw APIError.invalidResponse }
        var request=URLRequest(url:url); request.httpMethod=method; request.timeoutInterval=15
        request.setValue("application/json", forHTTPHeaderField:"Accept")
        if let body { request.setValue("application/json", forHTTPHeaderField:"Content-Type"); request.httpBody=try JSONSerialization.data(withJSONObject:body) }
        let (data,response)=try await URLSession.shared.data(for:request)
        guard let http=response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            let msg=(try? JSONSerialization.jsonObject(with:data) as? [String:Any])?["message"] as? String ?? "Error del servidor"
            throw APIError.server(msg)
        }
        return try decoder.decode(T.self,from:data)
    }
}
