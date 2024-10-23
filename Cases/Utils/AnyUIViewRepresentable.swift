//
//  AnyUIViewRepresentable.swift
//  Sandbox
//
//  Created by Maxence Mottard on 14/10/2024.
//

import SwiftUI

public struct AnyUIViewRepresentable: UIViewRepresentable {
    let view: UIView

    public init(view: UIView) {
        self.view = view
    }

    public func makeUIView(context: Context) -> UIView {
        view
    }

    public func updateUIView(_ uiView: UIView, context: Context) {}
}
