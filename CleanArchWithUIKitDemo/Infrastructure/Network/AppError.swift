//
//  AppError.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/9.
//

import Foundation

public protocol AppError: Error {
    var errorDescription: String { get }
}

public enum CommonError: AppError {
    case decodingError(Error)
    case unexpectedError(Error)

    public var errorDescription: String {
        switch self {
        case .decodingError(let error): "Decoding Error: \(error.localizedDescription)"
        case .unexpectedError(let message): "Unexpected Error: \(message)"
        }
    }
}
