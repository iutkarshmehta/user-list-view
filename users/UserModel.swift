//
//  UserModel.swift
//  users
//
//  Created by Utkarsh  Mehta on 09/11/24.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
}

