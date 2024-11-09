//
//  UserService.swift
//  users
//
//  Created by Utkarsh  Mehta on 09/11/24.
//

import Foundation

class UserService {
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/users") else {
            completion(.failure(.invalidURL))
            return
        }
        
        NetworkManager.shared.performRequest(with: url, completion: completion)
    }
}

