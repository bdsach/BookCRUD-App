//
//  BookCRUDApp.swift
//  BookCRUD
//
//  Created by Bandit Silachai on 1/1/24.
//

import SwiftUI

@main
struct BookCRUDApp: App {
    @StateObject private var vm = BookCRUDViewModel()
    
    var body: some Scene {
        WindowGroup {
            LoginFlowView()
                .environmentObject(vm)
                .onAppear(perform: {
                    checkCookie()
                })
        }
    }
    
    private func checkCookie() {
        DispatchQueue.main.async {
            let cookies = HTTPCookieStorage.shared

            print(cookies)
            if let cookies = HTTPCookieStorage.shared.cookies {
                print("All Cookies: from APP")
                for cookie in cookies {
                    print("Name: \(cookie.name)")
                    print("Value: \(cookie.value)")
                    print("Domain: \(cookie.domain)")
                    print("Path: \(cookie.path)")
                    print("Expires: \(cookie.expiresDate!)")
                    print("Secure: \(cookie.isSecure)")
                    print("HttpOnly: \(cookie.isHTTPOnly)")
                    print("----------")
                    if !cookie.value.isEmpty {
                        vm.isAuth = true
                        vm.isBusy = false
                    } else {
                        vm.isAuth = false
                        vm.isBusy = false
                    }
                }
            }
            vm.isBusy = false
        }
    }
}

