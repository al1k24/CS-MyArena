//
//  NetworkError.swift
//  CS-MyArena
//
//  Created by Алик on 21.02.2021.
//

import Foundation

enum NetworkError: Error {
    case invalidData
    case invalidToken
}

extension NetworkError {
    var errorDescription: String? {
        switch self {
        case .invalidData:
            return NSLocalizedString("Invalid data", comment: "")
        case .invalidToken:
            return NSLocalizedString("Invalid token", comment: "")
        }
    }
}
