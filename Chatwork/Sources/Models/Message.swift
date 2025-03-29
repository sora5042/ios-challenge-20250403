//
//  Message.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/29.
//

import Foundation

struct Message: Hashable {
    let messageID: String
    let accountID: Int
    let accountName: String
    let iconImageURL: String
    let message: String
    let sendTime: Int
    let updateTime: Int
}
