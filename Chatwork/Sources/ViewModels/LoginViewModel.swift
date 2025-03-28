//
//  LoginViewModel.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/28.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    let userService: UserService
    let dataStore: DataStore & SecuredDataStore

    @Published
    private(set) var isLoading: Bool = false

    @Published
    var error: Error?

    init(
        userService: UserService = .init(),
        dataStore: DataStore & SecuredDataStore = SharedData.shared
    ) {
        self.userService = userService
        self.dataStore = dataStore
    }

    func login(token: String) async {
        dataStore.apiToken = token
        await fetchUser()
    }

    private func fetchUser() async {
        isLoading = true
        defer { isLoading = false }

        do {
            _ = try await userService.fetchUser()
            dataStore.isLogin = true
        } catch {
            dataStore.remove(credential: "apiToken")
            self.error = error
        }
    }
}
