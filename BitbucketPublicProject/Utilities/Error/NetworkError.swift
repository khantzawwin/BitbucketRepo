//
//  NetworkError.swift
//  BitbucketPublicProject
//
//  Created by Khant Zaw Win on 19/6/21.
//

import Foundation

enum NetworkError: Error{
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
