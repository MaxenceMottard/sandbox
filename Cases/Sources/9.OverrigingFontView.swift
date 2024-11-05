//
//  SwiftUIView.swift
//  
//
//  Created by Maxence Mottard on 29/10/2024.
//

import SwiftUI
import Utils

struct SwiftUIView: View {
    var body: some View {
        ScrollViewWrapper {
            Component()
                .monospaced()
        }
    }

    struct Component: View {
        var body: some View {
            Text("Bonjour je suis un beau text")
                .font(.title)
        }
    }
}

#Preview {
    SwiftUIView()
}

struct ScrollViewWrapper<Content: View>: UIViewRepresentable {
    let content: () -> Content

    func makeUIView(context: Context) -> some UIScrollView {
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.panGestureRecognizer.allowedTouchTypes = [
            NSNumber(integerLiteral: UITouch.TouchType.indirect.rawValue)
        ]

        let hostingController = UIHostingController(rootView: content())
        scrollView.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.pin(scrollView)
        hostingController.view.backgroundColor = .clear

        return scrollView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
