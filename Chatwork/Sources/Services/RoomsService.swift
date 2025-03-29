//
//  RoomsService.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/28.
//

import API
import Foundation

protocol RoomsService {
    func fetchRooms() async throws -> [Room]
    func fetchRoom(_ id: Int) async throws -> Room
    func fetchMessages(roomID: Int) async throws -> [Message]
}

extension RoomsService {
    func fetchRooms() async throws -> [Room] {
        try await fetchRooms()
    }

    func fetchRoom(_ id: Int) async throws -> Room {
        try await fetchRoom(id)
    }

    func fetchMessages(roomID: Int) async throws -> [Message] {
        try await fetchMessages(roomID: roomID)
    }
}

struct DefaultRoomsService: RoomsService {
    var roomsAPI: RoomsAPI = .init(apiClient: .default)

    func fetchRooms() async throws -> [Room] {
        let response = try await roomsAPI.getRooms()
        return response.map { room in
                .init(
                    roomID: room.room_id,
                    name: room.name,
                    type: .init(chatType: room.type ),
                    unreadNum: room.unread_num,
                    iconPath: room.icon_path,
                    lastUpdateTime: room.last_update_time
                )
        }
    }

    func fetchRoom(_ id: Int) async throws -> Room {
        let response = try await roomsAPI.getRoom(id)
        return .init(
            roomID: response.room_id,
            name: response.name,
            type: .init(chatType: response.type ),
            unreadNum: response.unread_num,
            iconPath: response.icon_path,
            lastUpdateTime: response.last_update_time
        )
    }

    func fetchMessages(roomID: Int) async throws -> [Message] {
        let response = try await roomsAPI.getMessages(.init(force: 1), id: roomID)
        return response.map { message in
                .init(
                    messageID: message.message_id,
                    accountID: message.account.account_id,
                    accountName: message.account.name,
                    iconImageURL: message.account.avatar_image_url,
                    message: message.body,
                    sendTime: message.send_time,
                    updateTime: message.update_time
                )
        }
    }
}

extension Room.ChatType {
    init(chatType: API.Room.ChatType) {
        switch chatType {
        case .my:
            self = .my
        case .direct:
            self = .direct
        case .group:
            self = .group
        }
    }
}

extension RoomsService where Self == DefaultRoomsService {
    static var `default`: RoomsService { DefaultRoomsService() }
}
