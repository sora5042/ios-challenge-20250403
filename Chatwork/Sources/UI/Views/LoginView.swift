//
//  LoginView.swift
//  Chatwork
//
//  Created by Sora Oya on 2025/03/27.
//

import SwiftUI

struct LoginView: View {
    @StateObject
    var viewModel: LoginViewModel = .init()

    var body: some View {
        VStack {
            title
            Spacer()
            LoginForm { token in
                await viewModel.login(token: token)
            }
            Spacer()
        }
        .padding()
    }

    private var title: some View {
        Text("APIトークンを入力してログインしてください")
            .font(.title)
            .padding()
            .padding(.top, 30)
    }
}

private struct LoginForm: View {
    @State private var apiToken = ""
    var loginAction: @MainActor (String) async -> Void

    @FocusState
    private var isFocused: Bool

    var body: some View {
        VStack(spacing: 30) {
            TextField("APIトークン", text: $apiToken)
                .focused($isFocused)
                .textFieldStyle(.roundedBorder)
            Button {
                Task {
                    await loginAction(apiToken)
                }
            } label: {
                Text("ログイン")
                    .font(.title3)
                    .foregroundStyle(.black)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(.teal)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    LoginView()
}
