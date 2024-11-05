//
//  10.TransparentTap.swift
//  Cases
//
//  Created by Maxence Mottard on 05/11/2024.
//

import SwiftUI

struct TransparentTap: View {
  @State var count = 0

  var body: some View {
      Text("Count: \(count)")
          .font(.title3)

      List {
          Section("With Buttton") {
              Button(action: { incrementCount() }) {
                  Text("Click qui ne fonctionne pas sur les zones transparentes")
                      .padding(50)
                      .border(.black)
              }
              .buttonStyle(CustomButtonStyle())

              Button(action: { incrementCount() }) {
                  Text("Click qui fonctionne grâce au background color")
                      .padding(50)
                      .border(.black)
                      .background(.yellow)
              }
              .buttonStyle(CustomButtonStyle())

              Button(action: { incrementCount() }) {
                  Text("Click qui fonctionne sur les zones transparentes grace au .contentShape(Rectangle())")
                      .padding(50)
                      .border(.black)
                      .contentShape(Rectangle())
              }
              .buttonStyle(CustomButtonStyle())
          }

          Section("With .onTapGesture() modifier") {
              Text("Click qui ne fonctionne pas sur les zones transparentes")
                  .padding(50)
                  .border(.black)
                  .onTapGesture { incrementCount() }

              Text("Click qui fonctionne sur les zones transparentes grace au .contentShape(Rectangle())")
                  .padding(50)
                  .border(.black)
                  .contentShape(Rectangle())
                  .onTapGesture { incrementCount() }
          }
      }
      .listStyle(.grouped)
  }

  private func incrementCount() {
    count += 1
  }

  private struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
      configuration.label
        .opacity(
          configuration.isPressed ? 0.5 : 1
        )
    }
  }
}

#Preview {
  TransparentTap()
}
