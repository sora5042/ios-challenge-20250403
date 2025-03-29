//
//  ChatViewModel.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/29.
//

import Foundation

@MainActor
final class ChatRoomViewModel: ObservableObject {
    private let roomsService: RoomsService
    private let room: Room

    @Published
    private(set) var isLoading: Bool = false

    @Published
    private(set) var messages: [Message] = []

    private(set) var title: String

    @Published
    var error: Error?

    init(
        room: Room,
        roomsService: RoomsService = .default
    ) {
        self.room = room
        self.roomsService = roomsService
        self.title = room.name
    }

    func fetchMessages() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let messages = try await roomsService.fetchMessages(roomID: room.roomID)
            self.messages = messages.map { .init(message: $0) }
        } catch {
            self.error = error
        }
    }
}

extension ChatRoomViewModel {
    struct Message: Hashable {
        let messageID: String
        let accountID: Int
        let name: String
        let iconURL: URL?
        let message: String
        let sendTime: Int
        let updateTime: Int
    }
}

extension ChatRoomViewModel.Message {
    init(message: Message) {
        self.init(
            messageID: message.messageID,
            accountID: message.accountID,
            name: message.accountName,
            iconURL: .init(string: message.iconImageURL),
            message: message.message,
            sendTime: message.sendTime,
            updateTime: message.updateTime
        )
    }
}
