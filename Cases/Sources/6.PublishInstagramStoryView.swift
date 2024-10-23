//
//  PublishInstagramStory.swift
//  Sandbox
//
//  Created by Maxence Mottard on 16/09/2024.
//

import SwiftUI
import PhotosUI

public struct PublishInstagramStoryView: View {
    @State var pickedItem: PhotosPickerItem? = nil
    @State var imageData: Data? = nil

    public init() {}

    public var body: some View {
        VStack {
            PhotosPicker(
                "Pick a picture",
                selection: $pickedItem,
                matching: .images
            )

            Group {
                if let imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                } else {
                    Color.red
                }
            }
            .frame(width: 300, height: 300)
            .aspectRatio(contentMode: .fit)

            Button(
                "Publish to story",
                action: { publishToStory() }
            )
            .disabled(imageData == nil)
        }
        .onChange(of: pickedItem) { _, pickedItem in
            Task {
                if let pickedItem,
                   let data = try? await pickedItem.loadTransferable(type: Data.self) {
                    self.imageData = data
                }
            }
        }
    }

    private func publishToStory() {
        let urlScheme = URL(string: "instagram-stories://share?source_application=com.maxencemottard.sandbox")!

        guard let imageData,
              UIApplication.shared.canOpenURL(urlScheme) else {
            return
        }

        let pasteboardItems: [String: Any] = [
            "com.instagram.sharedSticker.stickerImage": imageData,
            "com.instagram.sharedSticker.backgroundTopColor": "#00A099",
            "com.instagram.sharedSticker.backgroundBottomColor": "#2FAB66",
        ]
        UIPasteboard.general.setItems([pasteboardItems], options: [:])
        UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
    }
}

#Preview {
    PublishInstagramStoryView()
}
