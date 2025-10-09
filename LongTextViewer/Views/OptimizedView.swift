//
//  OptimizedView.swift
//  LongTextViewer
//
//  Created by Maysam Shahsavari on 2025-10-06.
//

import SwiftUI

struct OptimizedView: View {
    let title: String
    @State var textChunks: [String] = []
    @State var visibleChunks: [String] = []
    @State var shouldShowProgressView: Bool = false
    
    var body: some View {
        ScrollView {
            Text(title)
            Divider()
            ForEach(visibleChunks, id: \.self) { text in
                Text(text)
                    .disabled(true)
                    .lineLimit(nil)
            }
            
            if shouldShowProgressView {
                HStack {
                    ProgressView()
                }
            }
            
            if !visibleChunks.isEmpty {
                Rectangle()
                    .background(Color.clear)
                    .foregroundStyle(Color.clear)
                    .onBecomingVisible {
                        Task {
                            await fetchNext()
                        }
                    }
            }
            
        }
        .padding()
        .task {
            let indices = Constants.longText2.indices(of: "\n")
            print("Number of indices: \(indices.ranges.count)")
            var isStart: Bool = true
            var startIndex: String.Index?
            var endIndex: String.Index?
            stride(from: 0, through: indices.ranges.count - 1, by: 5).forEach { index in
                if isStart {
                    startIndex = indices.ranges[index].lowerBound
                } else {
                    endIndex = indices.ranges[index].upperBound
                    if let startIndex, let endIndex = endIndex {
                        let chunk = String(Constants.longText2[startIndex..<endIndex])
                        textChunks.append(chunk)
                    }
                }
                isStart.toggle()
            }
            
            if let lastRange = indices.ranges.last, lastRange.upperBound != endIndex {
                textChunks.append(String(Constants.longText2[lastRange.upperBound...]))
            }
            
            visibleChunks.append(textChunks.removeFirst())
        }
    }
    
    private func fetchNext() async {
        guard !textChunks.isEmpty else {
            return
        }
        
        withAnimation {
            shouldShowProgressView = true
        }
        
        try? await Task.sleep(nanoseconds: 200_000_000)
        
        withAnimation {
            visibleChunks.append(textChunks.removeFirst())
            shouldShowProgressView = false
        }
    }
}
