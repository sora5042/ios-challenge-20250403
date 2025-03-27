//
//  URLSessionProtocol.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/27.
//

import Foundation

public protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
