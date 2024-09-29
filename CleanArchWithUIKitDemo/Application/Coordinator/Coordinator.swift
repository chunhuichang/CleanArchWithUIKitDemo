//
//  Coordinator.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/30.
//

import UIKit

/// Protocol that all coordinators should conform to
public protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
}

public extension Coordinator {
    func add(child: Coordinator) {
        childCoordinators.append(child)
    }

    func remove(child: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
}

public enum PresentationView: CaseIterable {
    case UIKit
    case SwiftUI
}
