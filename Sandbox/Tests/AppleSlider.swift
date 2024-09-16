//
//  ContentView.swift
//  Sandbox
//
//  Created by Maxence Mottard on 05/09/2024.
//

import SwiftUI

struct AppleSlider: View {
    @State private var isDragging = false
    @State private var draggingValue: Float = 0
    
    let total: Float
    
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Color.white
                    .overlay(Color.black.opacity(0.1))
                
                let sliderWidthRatio = CGFloat(draggingValue / total)
                let sliderWidth = geometry.size.width * sliderWidthRatio
                
                Rectangle()
                    .fill(.yellow)
                    .frame(width: sliderWidth)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { dragValue in
                        if !isDragging {
                            isDragging = true
                        }
                        
                        let width = Float(geometry.size.width)
                        let xRatio = width / total
                        let xTranslation = Float(dragValue.translation.width)
                        
                        let newValue = value + xTranslation / xRatio
                        draggingValue = min(total, max(0, newValue))
                    }
                    .onEnded { _ in
                        isDragging = false
                        value = draggingValue
                    }
            )
        }
        .frame(height: isDragging ? 12 : 5)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, isDragging ? 0 : 3)
        .animation(.easeIn(duration: 0.12), value: isDragging)
        .onChange(of: value) { _, newValue in
            draggingValue = newValue
        }
        .onAppear { draggingValue = value }
    }
}

struct AppleSlider_Previews: View {
    @State var value: Float = 55
    
    var body: some View {
        VStack {
            AppleSlider(total: 200, value: $value)
            
            HStack {
                Button(action: { value -= 15 }) {
                    Image(systemName: "minus")
                        .padding()
                }
                
                Spacer()
                
                Button(action: { value += 15 }) {
                    Image(systemName: "plus")
                        .padding()
                }
            }
        }
        .padding()
    }
}

#Preview {
    AppleSlider_Previews()
}
