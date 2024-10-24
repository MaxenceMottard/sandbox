//
//  8.BindingBetweenTwoViewModels.swift
//  Cases
//
//  Created by Maxence Mottard on 24/10/2024.
//

import Foundation
import SwiftUI

@Observable
class ViewModel1 {
    var total: Int = .zero
}

@Observable
class ViewModel2 {
    var items: [Int] = []
}

public class Coordinator {
    let viewModel1: ViewModel1
    let viewModel2: ViewModel2

    public init() {
        self.viewModel1 = ViewModel1()
        self.viewModel2 = ViewModel2()

        observeChangesSecondWay()
    }

    func observeChangesFirstWay() async {
        func observationTrackingStream<T>(
            _ apply: @escaping () -> T
        ) -> AsyncStream<T> {
            AsyncStream { continuation in
                @Sendable func observe() {
                    let result = withObservationTracking {
                        apply()
                    } onChange: {
                        DispatchQueue.main.async {
                            observe()
                        }
                    }
                    continuation.yield(result)
                }
                observe()
            }
        }

        let changes = observationTrackingStream { [viewModel2] in
            viewModel2.items
        }

        for await items in changes {
            viewModel1.total = items.reduce(0, +)
        }
    }

    func observeChangesSecondWay() {
        let items = withObservationTracking { [viewModel2] in
            viewModel2.items
        } onChange: {
            Task { [weak self] in
                self?.observeChangesSecondWay()
            }
        }

        viewModel1.total = items.reduce(0, +)
    }
}

public struct BindingBetweenTwoViewModelsView: View {
    let coordinator: Coordinator

    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    public var body: some View {
        VStack {
            Text("Total: \(coordinator.viewModel1.total)")
                .font(.largeTitle)

            HStack {
                ForEach(coordinator.viewModel2.items, id: \.hashValue) { item in
                    Text("\(item)")
                }
            }

            Button(
                "Add item",
                action: { coordinator.viewModel2.items.append(3) }
            )
        }
    }
}

#Preview {
    let coordinator = Coordinator()

    return BindingBetweenTwoViewModelsView(coordinator: coordinator)
}
