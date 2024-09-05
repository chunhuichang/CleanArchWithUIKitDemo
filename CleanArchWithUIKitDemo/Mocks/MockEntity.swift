//
//  MockEntity.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/29.
//

import Foundation

public protocol MockEntity {
    associatedtype T
    static var mockValue: T { get }
}
