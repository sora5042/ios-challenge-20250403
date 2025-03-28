//
//  ChatListView.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/28.
//

import SwiftUI

struct ChatListView: View {
    @StateObject
    var viewModel: ChatListViewModel = .init()

    var body: some View {
        VStack {
            Header()
            ChatList(
                rooms: viewModel.rooms
            )
        }
        .background(Color.lightGray)
        .task {
            await viewModel.fetchRooms()
        }
        .alert($viewModel.error)
        .loading(isPresented: viewModel.isLoading)
    }
}

struct Header: View {
    var body: some View {
        VStack {
            Text("すべてのチャット")
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.deepNavy)
    }
}

private struct ChatList: View {
    var rooms: [ChatListViewModel.Room]

    var body: some View {
        List(rooms, id: \.self) { room in
            Row(
                name: room.name,
                iconURL: room.iconURL
            )
            .listRowInsets(EdgeInsets())
            .background(.white)
        }
        .listStyle(.plain)
    }
}

private struct Row: View {
    var name: String
    var iconURL: URL?

    var body: some View {
        HStack(spacing: 20) {
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
            Text(name)
                .font(.body)
        }
        .padding(10)
        .background(.white)
        .foregroundStyle(.black)
    }
}

#Preview {
    ChatListView()
}
