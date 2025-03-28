//
//  User.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/27.
//

public struct User: Decodable {
    /// アカウントID
    public let account_id: Int
    /// ルームID
    public let room_id: Int
    /// 表示名
    public let name: String
    /// Chatwork ID
    public let chatwork_id: String
    /// 組織ID
    public let organization_id: Int?
    /// 組織名
    public let organization_name: String?
    /// 所属
    public let department: String?
    /// 役職
    public let title: String?
    /// 自己紹介
    public let introduction: String?
    /// メールアドレス
    public let mail: String?
    /// アバター画像URL
    public let avatar_image_url: String
    /// Chatwork登録メールアドレス（ログインメールアドレス）
    public let login_mail: String
}
