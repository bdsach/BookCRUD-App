//
//  ProfileView.swift
//  BookCRUD
//
//  Created by Bandit Silachai on 1/1/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var vm: BookCRUDViewModel

    var body: some View {
        NavigationView(content: {
            List(content: {
                Section {
                    HStack(content: {
                        Rectangle()
                            .fill(.clear)
                            .frame(width: 50,height: 50)
                            .overlay {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .foregroundStyle(.blue)
                            }
                        VStack(alignment: .leading ,content: {
                            Text("\(vm.profile?.firstName ?? "Firstname") \(vm.profile?.lastName ?? "Lastname")")
                            Text(vm.profile?.email ?? "test@email.com")
                                .foregroundStyle(.secondary)
                        })
                    })
                }
                
                Section("Manage") {
                    Button("Edit Profile", systemImage: "rectangle.and.pencil.and.ellipsis") {
                    }
                }
                
                Section("Account") {
                    Label {
                        Button(action: {
                            vm.logout()
                        }, label: {
                            Text("Logout")
                                    .font(.body)
                                    .foregroundColor(.primary)
                        })
                    } icon: {
                        Image(systemName: "lock.slash.fill")
                            .foregroundStyle(.red)
                    }
                }
            })
            .navigationTitle("Profile")
        })
    }
}

#Preview {
    ProfileView()
        .environmentObject(BookCRUDViewModel())
}
