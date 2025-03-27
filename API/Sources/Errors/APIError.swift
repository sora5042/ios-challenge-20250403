//
//  APIError.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/27.
//

import Foundation

public enum APIError: Error {
    case data(Data, Int?)
    case decodeError(Data, Error)
    case message(String)
    case invalidResponse
    case cancelled
    case unauthorized(Data)
    case unknown(Error)
}
