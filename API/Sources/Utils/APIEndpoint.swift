//
//  APIEndpoint.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/27.
//

import Foundation

public protocol APIEndpoint {
    var apiClient: APIClient { get }
    var path: String { get }
}
