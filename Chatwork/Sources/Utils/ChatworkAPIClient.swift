//
//  ChatworkAPIClient.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/27.
//

import API
import Foundation

struct ChatworkAPIClient: APIClient {
    init(
        session: URLSessionProtocol = URLSession.shared,
        dataStore: SecuredDataStore = SharedData.shared
    ) {
        self.session = session
        self.dataStore = dataStore
    }

    var baseURL: String {
        "https://api.chatwork.com/v2"
    }

    let session: URLSessionProtocol
    private let dataStore: SecuredDataStore
    private let decoder: JSONDecoder = .init()

    func data(method: HTTPMethod, path: String? = nil, parameters: Parameters? = nil) async throws -> Data {
        let dictionary = try (parameters?.convertToDictionary() ?? [:])
        let apiToken = dataStore.apiToken ?? ""

        var request = urlRequest(method: method, path: path, parameters: dictionary)
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue(apiToken, forHTTPHeaderField: "x-chatworktoken")

        logger.debug([
            "URL: \(method) \(baseURL) \(path ?? "")",
            "Params: \(String(describing: parameters))"
        ].joined(separator: "\n"))
        return try await data(request)
    }

    func response<Response: Decodable>(method: HTTPMethod, path: String?, parameters: Parameters?) async throws -> Response {
        do {
            let data = try await data(method: method, path: path, parameters: parameters)
            return try decode(data)
        } catch {
            throw error
        }
    }

    private func decode<Response: Decodable>(_ data: Data) throws -> Response {
        do {
            let decoded = try decoder.decode(Response.self, from: data)
            return decoded
        } catch {
            logger.debug([
                "Response: \(String(describing: String(data: data, encoding: .utf8)))",
                "Error: \(error)"
            ].joined(separator: "\n"))
            throw APIError.decodeError(data, error)
        }
    }
}

extension APIClient where Self == ChatworkAPIClient {
    static var `default`: APIClient {
        ChatworkAPIClient()
    }
}
