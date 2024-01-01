//
//  BookService.swift
//  BookCRUD
//
//  Created by Bandit Silachai on 1/1/24.
//

import Foundation
import Alamofire

enum AppError: Error {
    case invalidCredentials
    case userNotFound
    case usernameTaken
    case emailTaken
    case invalidData
    case databaseError(message: String)
    case registrationFailed(reason: String)
    case bookCreationFailed(reason: String)
}

class BookService {
    static let shared = BookService()
    
    func allBooks(completion: @escaping(Result<[Book],Error>) -> Void) {
        guard let url = URL(string: "https://book-crud-api.fly.dev/books") else { return }
        
        AF.request(url, encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let bodyObject = try JSONSerialization.jsonObject(with: data) as? [String:Any] else { return }

                    guard let booksData = bodyObject["data"] else { return }
                    
                    let booksObject = try JSONSerialization.data(withJSONObject: booksData)
                    let books = try JSONDecoder().decode([Book].self, from: booksObject)
                    completion(.success(books))
                    
                } catch {
                    completion(.failure(error))
                    
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func addBook(_ book: AddBook, completion: @escaping(Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "https://book-crud-api.fly.dev/book") else { return }
       
        let params = [ "name": book.name, "author": book.author, "price": book.price ] as? [String: Any]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseData { response in
            
            switch response.result {
            case .success:
                completion(.success(true))
            case .failure(let failure):
                print(failure)
                completion(.failure(AppError.bookCreationFailed(reason: "idk")))
            }
        }
        
    }
    
    func deleteBook(id: Int, completion: @escaping(Result<Bool, Error>) -> Void ) {
        guard let url = URL(string: "https://book-crud-api.fly.dev/book/\(id)") else { return }
        
        AF.request(url, method: .delete, encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case .success:
                completion(.success(true))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
        
        print(id)
    }
}
