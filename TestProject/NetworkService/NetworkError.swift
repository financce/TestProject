//
//  NetworkError.swift
//  TestProject
//
//  Created by slava on 04/06/2021.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case unknown, apiError(reason: String)

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason):
            return reason
        }
    }
}
