//
//  ChatRoomListView.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/28.
//

import SwiftUI

struct ChatRoomListView: View {
    @StateObject
    var viewModel: ChatRoomListViewModel = .init()

    var body: some View {
        VStack {
            Header()
            ChatList(
                rows: viewModel.rows
            ) { id in
                await viewModel.selectedRoom(id)
            }
        }
        .background(Color.lightGray)
        .task {
            await viewModel.fetchRooms()
        }
        .navigatorDestination($viewModel.navigation) { navigation in
            switch navigation {
            case .chatRoom(let room):
                ChatRoomView(viewModel: .init(room: room))
                    .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .alert($viewModel.error)
        .loading(isPresented: viewModel.isLoading)
    }
}

private struct Header: View {
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
    var rows: [ChatRoomListViewModel.Row]
    var selectedRoomAction: @MainActor (Int) async -> Void
    
    var body: some View {
        List(rows, id: \.self) { row in
            Row(
                name: row.name,
                iconURL: row.iconURL
            )
            .listRowInsets(EdgeInsets())
            .background(.white)
            .contentShape(Rectangle())
            .onTapGesture {
                Task {
                    await selectedRoomAction(row.id)
                }
            }
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
    ChatRoomListView()
}
