//
//  5.MemoryLeaks.swift
//  
//
//  Created by Maxence Mottard on 23/10/2024.
//

import Foundation

class Dependency {
    var isEnabled: Bool {
        true
    }
}

class Dependency2 {
    var isEnabled = false

    var checkIsEnabled: (() -> Bool)?

    init(checkIsEnabled: @escaping () -> Bool) {
        self.checkIsEnabled = checkIsEnabled
    }
}

class MemoryLeaks {
    let dependency = Dependency()
    var dependency2: Dependency2?

    enum CatchingSelfMethod {
        case localVariable
        case withWeakKeyword
        case withoutWeakKeyword
        case catchingDependency
        case implicitSelf
    }

    init(cathingSelfMethod type: CatchingSelfMethod) {
        switch type {

        // Test when catching dependency with a local variable
        case .localVariable:
            let dependency = dependency
            dependency2 = Dependency2(
                checkIsEnabled: { dependency.isEnabled }
            )

        // Test when catching dependency with weak self to access with `self?.dependency`
        case .withWeakKeyword:
            dependency2 = Dependency2(
                checkIsEnabled: { [weak self] in
                    self?.dependency.isEnabled ?? false
                }
            )

        // Test when catching dependency without weak self to access directly with `self.dependency`
        case .withoutWeakKeyword:
            dependency2  = Dependency2(
                checkIsEnabled: {
                    self.dependency.isEnabled
                }
            )

        // Test when catching dependency
        case .catchingDependency:
            dependency2  = Dependency2(
                checkIsEnabled: { [dependency] in
                    dependency.isEnabled
                }
            )

        // Test when catching dependency
        case .implicitSelf:
            dependency2  = Dependency2(
                checkIsEnabled: { [weak self] in
                    guard let self else { return false }

                    // implicit self
                    return dependency.isEnabled
                }
            )

        }
    }
}
