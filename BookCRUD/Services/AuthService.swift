//
//  AuthService.swift
//  BookCRUD
//
//  Created by Bandit Silachai on 1/1/24.
//

import Foundation
import Alamofire

enum LoginError: Error {
    case invalidCredentials
    case networkError
}

class AuthManager {
    static let shared = AuthManager()
    
    func login(user: UserLogin ,completion: @escaping(Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://book-crud-api.fly.dev/login") else { return }
        let params = ["email": user.email, "password": user.password]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case .success:
                completion(.success("Login is success"))
            case .failure(let failure):
                print("error on auth")
                print(failure)
                completion(.failure(failure))
            }
        }
    }
    
    func logout() {
        guard let logoutURL = URL(string: "https://book-crud-api.fly.dev/logout") else {
            return
        }

        AF.request(logoutURL).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let bodyObject = try JSONSerialization.jsonObject(with: data) as? [String:Any] else {return}
                    print(bodyObject)
                } catch {
                    
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func profile(completion: @escaping(Result<Profile, Error>) -> Void) {
        guard let profileURL = URL(string: "https://book-crud-api.fly.dev/profile") else {
            return
        }

        AF.request(profileURL).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let bodyObject = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                          let dataArray = bodyObject["data"] as? [[String: String]] ,
                          let firstObject = dataArray.first,
                          let email = firstObject["email"],
                          let firstName = firstObject["first_name"],
                          let lastName = firstObject["last_name"]
                    else {
                        return
                    }
                    completion(.success(Profile(email: email, firstName: firstName, lastName: lastName)))
                } catch let error {
                    completion(.failure(error))
                }
                
            case .failure(let failure):
                print(failure)
                completion(.failure(failure))
            }
        }
    }
}
