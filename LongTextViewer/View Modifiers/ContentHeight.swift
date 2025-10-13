//
//  ContentHeight.swift
//  LongTextViewer
//
//  Created by Maysam Shahsavari on 2025-10-13.
//

import SwiftUI

private struct ContentHeight: ViewModifier {
    @Binding var height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geo in
                    Color.clear
                        .onAppear {
                            height = geo.size.height
                        }
                        .onChange(of: geo.size.height) { _, newHeight in
                            height = newHeight
                        }
                }
            )
    }
}

public extension View {
    func contentHeight(bind height: Binding<CGFloat>) -> some View {
        modifier(ContentHeight(height: height))
    }
}
