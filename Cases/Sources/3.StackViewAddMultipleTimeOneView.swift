//
//  3.StackViewAddMultipleTimeOneView.swift
//  Sandbox
//
//  Created by Maxence Mottard on 10/10/2024.
//

import SwiftUI
import Utils

struct StackViewAddMultipleTimeOneView: View {
    var body: some View {
        VStack {
            AnyUIViewRepresentable(view: stackView)
            Button(action: { addLabel() }) {
                Text("Add Label")
            }
        }
    }

    private func addLabel() {
        if let label {
            stackView.addArrangedSubview(label)
        }
    }

    private weak var label: UILabel? {
        let label = UILabel()
        label.text = "Je suis un label"

        return label
    }

    private var stackView: UIStackView = .init()
}

#Preview {
    StackViewAddMultipleTimeOneView()
}
