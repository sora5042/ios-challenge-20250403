//
//  UserService.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/28.
//

import API
import Foundation

struct UserService {
    var userAPI: UserAPI = .init(apiClient: .default)

    func fetchUser() async throws -> User {
        let response = try await userAPI.get()
        return .init(
            accountID: response.account_id,
            roomID: response.room_id,
            name: response.name,
            chatworkID: response.chatwork_id,
            organizationID: response.organization_id,
            organizationName: response.organization_name,
            department: response.department,
            title: response.title,
            introduction: response.introduction,
            mail: response.mail,
            avatarImageURL: response.avatar_image_url,
            loginMail: response.login_mail
        )
    }
}
