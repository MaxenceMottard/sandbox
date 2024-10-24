//
//  ObservableState.swift
//  Sandbox
//
//  Created by Maxence Mottard on 13/10/2024.
//

import SwiftUI

@Observable
@dynamicMemberLookup
class ObservableViewModel {
    private var state: State

    struct State {
        var title: String = "123"
    }

    enum Action {
        case appendString(String)
    }

    init(state: State) {
        self.state = state
    }

    public subscript<Value>(dynamicMember keyPath: KeyPath<State, Value>) -> Value {
        self.state[keyPath: keyPath]
    }

    func appendString(_ string: String) {
        state.title += string
    }
}

struct ObservableView: View {
    @State var viewModel: ObservableViewModel

    var body: some View {
        Button(action: { viewModel.appendString(".") }) {
            Text(viewModel.title)
        }
        .onChange(of: viewModel.title) { _, newValue in
            print(newValue)
        }
        .onAppear {
            viewModel.appendString("_init_")
        }
    }
}

#Preview {
    ObservableView(
        viewModel: ObservableViewModel(
            state: ObservableViewModel.State()
        )
    )
}
