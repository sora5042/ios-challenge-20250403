//
//  ChatRoomView.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/29.
//

import SwiftUI

struct ChatRoomView: View {
    @StateObject
    var viewModel: ChatRoomViewModel

    var body: some View {
        VStack {
            Header(title: viewModel.title)
            ChatList(
                messages: viewModel.messages
            )
        }
        .background(Color.lightGray)
        .task {
            await viewModel.fetchMessages()
        }
        .alert($viewModel.error)
        .loading(isPresented: viewModel.isLoading)
    }
}

private struct Header: View {
    var title: String

    @Environment(\.dismiss)
    private var dismiss

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                    
                }
                Spacer()
                Text(title)
                    .lineLimit(1)
                Spacer()
            }
        }
        .font(.headline)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.deepNavy)
    }
}

private struct ChatList: View {
    var messages: [ChatRoomViewModel.Message]

    var body: some View {
        ScrollView {
            ForEach(messages, id: \.self) { message in
                Row(
                    name: message.name,
                    message: message.message,
                    iconURL: message.iconURL
                )
            }
        }
    }
}

private struct Row: View {
    var name: String
    var message: String
    var iconURL: URL?

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            AsyncImage(url: iconURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                case .failure:
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                default:
                    EmptyView()
                }
            }
            VStack(alignment: .leading, spacing: 15) {
                Text(name)
                    .font(.body.bold())
                Text(message)
                    .font(.body )
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ChatRoomView(
        viewModel: .init(
            room: .init(
                roomID: 1,
                name: "テスト",
                type: .my,
                unreadNum: 0,
                iconPath: "",
                lastUpdateTime: 0
            )
        )
    )
}
