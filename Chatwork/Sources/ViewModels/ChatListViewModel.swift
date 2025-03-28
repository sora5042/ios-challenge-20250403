//
//  ChatListViewModel.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/28.
//

import Foundation

@MainActor
final class ChatListViewModel: ObservableObject {
    let roomsService: RoomsService

    @Published
    private(set) var isLoading: Bool = false

    @Published
    private(set) var rooms: [Room] = []

    @Published
    var error: Error?

    init(
        roomsService: RoomsService = .default
    ) {
        self.roomsService = roomsService
    }

    func fetchRooms() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let rooms = try await roomsService.fetchRooms()
            self.rooms = rooms.map { .init(room: $0) }
        } catch {
            self.error = error
        }
    }
}

extension ChatListViewModel {
    struct Room: Hashable {
        let id: Int
        let name: String
        let type: ChatType
        let iconURL: URL?
        let lastUpdateTime: Int
        
        enum ChatType: Hashable {
            case my
            case direct
            case group
        }
    }
}

extension ChatListViewModel.Room {
    init(room: Room) {
        self.init(
            id: room.roomID,
            name: room.name,
            type: .init(type: room.type),
            iconURL: .init(string: room.iconPath),
            lastUpdateTime: room.lastUpdateTime
        )
    }
}

extension ChatListViewModel.Room.ChatType {
    init(type: Room.ChatType) {
        switch type {
        case .my:
            self = .my
        case .direct:
            self = .direct
        case .group:
            self = .group
        }
    }
}
