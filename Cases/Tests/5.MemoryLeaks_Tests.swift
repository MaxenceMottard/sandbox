//
//  5.MemoryLeaks_Tests.swift
//
//
//  Created by Maxence Mottard on 23/10/2024.
//

@testable import Cases
import Testing

@Suite("5.MemoryLeaks")
class MemoryLeaks_Tests {
    var memoryLeaksInstance: MemoryLeaks!

    @Test func createLocalVariableToPreventMemoryLeak() async throws {
        memoryLeaksInstance = MemoryLeaks(cathingSelfMethod: .localVariable)

        weak var weakMemoryLeaks = memoryLeaksInstance
        weak var weakDependency = memoryLeaksInstance?.dependency
        weak var weakDependency2 = memoryLeaksInstance?.dependency2

        memoryLeaksInstance = nil

        #expect(weakMemoryLeaks == nil)
        #expect(weakDependency == nil)
        #expect(weakDependency2 == nil)
    }

    @Test func usingWeakSelfToPreventMemoryLeak() async throws {
        memoryLeaksInstance = MemoryLeaks(cathingSelfMethod: .withWeakKeyword)

        weak var weakMemoryLeaks = memoryLeaksInstance
        weak var weakDependency = memoryLeaksInstance?.dependency
        weak var weakDependency2 = memoryLeaksInstance?.dependency2

        memoryLeaksInstance = nil

        #expect(weakMemoryLeaks == nil)
        #expect(weakDependency == nil)
        #expect(weakDependency2 == nil)
    }

    @Test func dontUseWeakSelfToPreventMemoryLeak() async throws {
        memoryLeaksInstance = MemoryLeaks(cathingSelfMethod: .withoutWeakKeyword)

        weak var weakMemoryLeaks = memoryLeaksInstance
        weak var weakDependency = memoryLeaksInstance?.dependency
        weak var weakDependency2 = memoryLeaksInstance?.dependency2

        memoryLeaksInstance = nil

        #expect(weakMemoryLeaks != nil)
        #expect(weakDependency != nil)
        #expect(weakDependency2 != nil)
    }
}
