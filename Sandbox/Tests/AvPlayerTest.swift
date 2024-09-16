//
//  AvPlayer Test.swift
//  Sandbox
//
//  Created by Maxence Mottard on 05/09/2024.
//

import SwiftUI
import AVKit
import AVFoundation

struct AvPlayerTest: UIViewControllerRepresentable {
    let url: URL

    private let player: AVPlayer

    init(url: URL) {
        self.url = url
        self.player = AVPlayer(url: url)
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let viewController = AVPlayerViewController()
        viewController.player = player

        return viewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}

#Preview {
    AvPlayerTest(url: URL(string: "https://file-examples.com/storage/fef44df12666d835ba71c24/2017/04/file_example_MP4_480_1_5MG.mp4")!)
        .ignoresSafeArea()
}
