//
//  BookCRUDViewModel.swift
//  BookCRUD
//
//  Created by Bandit Silachai on 1/1/24.
//

import Foundation

enum ViewState {
    case loading
    case fetched
    case error
}

class BookCRUDViewModel: ObservableObject {
    
    @Published var books: [Book] = []
    @Published var isAuth = false
    @Published var profile: Profile?
    @Published var isBusy = true
    @Published var isLoadingBooks = false
   
    func login(user: UserLogin) {
        AuthManager.shared.login(user: user) { result in
            switch result {
            case .success:
                print(result)
                self.isAuth = true
            case .failure(let failure):
                print(failure)
                self.isAuth = false
            }
        }
    }
    
    func logout() {
        AuthManager.shared.logout()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isAuth = false
        }
    }
    
    func getProfile() {
        AuthManager.shared.profile { result in
            switch result {
            case .success(let data):
                self.profile = data
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func allBook() {
        isLoadingBooks = true
        BookService.shared.allBooks { result in
            switch result {
            case .success(let data):
                self.books = data
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isLoadingBooks = false
                }
            case .failure(let failure):
                print(failure.localizedDescription)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isLoadingBooks = false
                }
            }
        }
    }
    
    func addBook(_ name: String, _ author: String, _ price: Int, completion: @escaping(Result<Bool, Error>) -> Void) {
      
        BookService.shared.addBook(AddBook(name: name, author: author, price: price)) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure:
                completion(.failure(AppError.bookCreationFailed(reason: "idk")))
            }
        }
    }
    
    func deleteBook(withID id: Int) {
        print(id)
        BookService.shared.deleteBook(id: id) { result in
            switch result {
            case .success(let success):
                print("id: \(id) was deleted")
                print(success)
            case .failure(let failure):
                print("fail to delete id: \(id)")
                print(failure)
            }
        }
    }
}

