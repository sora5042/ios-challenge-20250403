//
//  Message.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/29.
//

import Foundation

public struct Message: Decodable {
    public let message_id: Int
    public let account: Account
    public let body: String
    public let send_time: Int
    public let update_time: Int
}

extension Message {
    public struct Account: Decodable {
        public let account_id: Int
        public let name: String
        public let avatar_image_url: String
    }
}
