//
//  LoginView.swift
//  BookCRUD
//
//  Created by Bandit Silachai on 1/1/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject private var vm: BookCRUDViewModel

    var body: some View {
        VStack(content: {
            Text("Login")
                .font(.title).bold()
            VStack(content: {
                TextField("Email", text: $email)
                    .padding(.horizontal, 10)
                    .frame(height: 50)
                    .border(Color.gray.opacity(0.5), width: 1)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                SecureField("Password", text: $password)
                    .padding(.horizontal, 10)
                    .frame(height: 50)
                    .border(Color.gray.opacity(0.5), width: 1)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            })
            .padding(.horizontal, 16)
            Button("Login", systemImage: "person") {
                print("hi")
                vm.login(user: UserLogin(email: email, password: password))
            }
            .buttonStyle(.borderedProminent)
        })
    }
}

#Preview {
    LoginView()
}
