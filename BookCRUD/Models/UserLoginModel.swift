//
//  UserLoginModel.swift
//  BookCRUD
//
//  Created by Bandit Silachai on 1/1/24.
//

import Foundation

struct UserLogin {
    let email: String
    let password: String
}

struct Profile: Codable {
    let email: String
    let firstName: String
    let lastName: String
}
