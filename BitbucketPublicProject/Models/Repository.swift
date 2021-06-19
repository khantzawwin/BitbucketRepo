//
//  Repository.swift
//  BitbucketPublicProject
//
//  Created by Khant Zaw Win on 19/6/21.
//

import Foundation


struct Repository: Codable {
    let uuid: String
    let name: String
    let full_name: String
    let language: String
    let scm: String
    let description: String
    let created_on: String
    let type: String
    let owner : User
    
    func formatted_created_on() -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = dateFormatter.date(from:created_on)!
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        return dateFormatter2.string(from: date)
    }
}

struct User: Codable {
    let uuid: String
    let display_name: String
    let links: Link
}

struct Link: Codable {
    let avatar: Avatar
}

struct Avatar: Codable {
    let href: String
}

struct RepositoryResponse: Codable {
    let values: [Repository]
    let next : String
}
