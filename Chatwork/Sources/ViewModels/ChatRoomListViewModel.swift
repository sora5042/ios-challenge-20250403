//
//  ChatRoomListViewModel.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/28.
//

import Foundation

@MainActor
final class ChatRoomListViewModel: ObservableObject {
    private let roomsService: RoomsService

    @Published
    private(set) var isLoading: Bool = false

    @Published
    private(set) var rows: [Row] = []

    @Published
    var navigation: Navigation?

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
            self.rows = rooms.map { .init(room: $0) }
        } catch {
            self.error = error
        }
    }
    
    func selectedRoom(_ id: Int) async {
        do {
            let room = try await roomsService.fetchRoom(id)
            navigation = .chatRoom(room: room)
        } catch {
            self.error = error
        }
    }
}

extension ChatRoomListViewModel {
    struct Row: Hashable {
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
    
    enum Navigation: Hashable {
        case chatRoom(room: Room)
    }
}

extension ChatRoomListViewModel.Row {
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

extension ChatRoomListViewModel.Row.ChatType {
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
