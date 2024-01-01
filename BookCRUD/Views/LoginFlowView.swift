//
//  LoginFlowView.swift
//  BookCRUD
//
//  Created by Bandit Silachai on 1/1/24.
//

import Foundation

import SwiftUI

struct LoginFlowView: View {
    @EnvironmentObject private var vm: BookCRUDViewModel

    var body: some View {
        Group {
            if vm.isBusy {
                LoadingView()
            } else {
                if vm.isAuth {
                    ContentView()
                        .onAppear(perform: {
                            vm.allBook()
                            vm.getProfile()
                        })
                } else {
                    LoginView()
                }
            } 
        }
        
    }
}



#Preview {
    LoginFlowView()
        .environmentObject(BookCRUDViewModel())
}
