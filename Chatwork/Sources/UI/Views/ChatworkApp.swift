//
//  ChatworkApp.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/27.
//

import SwiftUI

let logger = Logger()

@main
struct ChatworkApp: App {
    @StateObject
    private var navigator: Navigator = .init()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigator.path) {
                switch navigator.rootView {
                case .login:
                    LoginView()
                case .chatList:
                    ChatListView()
                }
            }
            .navigationViewStyle(.stack)
            .environmentObject(navigator)
        }
    }
}

extension ChatworkApp {
    @MainActor
    final class Navigator: ObservableObject {
        enum RootView: Int {
            case login, chatList
        }

        @Published
        private(set) var rootView: RootView

        @Published
        fileprivate var path: NavigationPath = .init()

        init(dataStore: DataStore = SharedData.shared) {
            rootView = dataStore.isLogin ? .chatList : .login
        }

        func switchRootView(to new: RootView) {
            rootView = new
        }

        func popToRootView() {
            path = .init()
            if rootView != .login {
                switchRootView(to: .login)
            }
        }

        func pop() {
            path.removeLast()
        }

        func push<Navigation: Hashable>(_ navigation: Navigation) {
            path.append(navigation)
        }
    }
}
