//
//  2.AvPlayer.swift
//  Sandbox
//
//  Created by Maxence Mottard on 05/09/2024.
//

import SwiftUI
import AVKit
import AVFoundation

struct AvPlayerView<Content: View>: UIViewControllerRepresentable {
    let url: URL
    let content: Content

    private let player: AVPlayer

    init(url: URL, content: () -> Content) {
        self.url = url
        self.player = AVPlayer(url: url)
        self.content = content()
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let viewController = AVPlayerViewController()
        viewController.player = player

        let contentViewController = UIHostingController(rootView: content.ignoresSafeArea())
        viewController.addChild(contentViewController)
        viewController.contentOverlayView?.addSubview(contentViewController.view)

        if let contentOverlayView = viewController.contentOverlayView {
            contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
            contentViewController.view.pin(contentOverlayView)
        }

        return viewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}

struct AvPlayerView_Previews: View {
    var body: some View {
        AvPlayerView(
            url: URL(string: "https://videos.pexels.com/video-files/5752729/5752729-uhd_2560_1440_30fps.mp4")!,
            content: {
                Text("Je suis au centre!")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.red.opacity(0.2))
            }
        )
        .ignoresSafeArea()
    }
}

#Preview {
    AvPlayerView_Previews()
}
