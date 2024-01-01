//
//  BookModel.swift
//  BookCRUD
//
//  Created by Bandit Silachai on 1/1/24.
//

import Foundation

struct Book: Codable, Identifiable {
    let id: Int?
    let name: String
    let author: String
    let price: Int
}

struct AddBook {
    let name: String
    let author: String
    let price: Int
}
