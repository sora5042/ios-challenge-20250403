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
}

extension RoomsService {
    func fetchRooms() async throws -> [Room] {
        try await fetchRooms()
    }
}

struct DefaultRoomsService: RoomsService {
    var roomsAPI: RoomsAPI = .init(apiClient: .default)

    func fetchRooms() async throws -> [Room] {
        let response = try await roomsAPI.get()
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
