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
                invisibleView
                    .onBecomingVisible {
                        Task {
                            await fetchNext()
                        }
                    }
            }
            
        }
        .padding()
        .task {
            splitText(input: Constants.longText3,
                        textChunks: &textChunks,
                        visibleChunks: &visibleChunks,
                        strideLength: 5)
        }
    }
    
    private var invisibleView: some View {
        Rectangle()
            .background(Color.clear)
            .foregroundStyle(Color.clear)
    }
    
    /// Splits the given text into smaller parts, separated by the break-line character (`\n`).
    /// - Parameters:
    ///   - input: Input text
    ///   - textChunks: An array to represent the input the text.
    ///   - visibleChunks: An array of string that's used as the data source for the text on screen.
    ///   - strideLength: The number of pieces separated by the break-line character that becomes an item in `textChunks`.
    private func splitText(input: String,
                             textChunks: inout [String],
                             visibleChunks: inout [String],
                             strideLength: Int) {
        let indices = input.indices(of: "\n")
        if indices.ranges.count <= strideLength {
            visibleChunks = [input]
            return
        }
        print("Number of indices: \(indices.ranges.count)")
        var isStart: Bool = true
        var startIndex: String.Index?
        var endIndex: String.Index?
        stride(from: 0, through: indices.ranges.count - 1, by: strideLength).forEach { index in
            if isStart {
                startIndex = indices.ranges[index].lowerBound
            } else {
                endIndex = indices.ranges[index].upperBound
                if let startIndex, let endIndex = endIndex {
                    let chunk = String(input[startIndex..<endIndex])
                    textChunks.append(chunk)
                }
            }
            isStart.toggle()
        }
        
        if let lastRange = indices.ranges.last, lastRange.upperBound != endIndex {
            textChunks.append(String(input[lastRange.upperBound...]))
        }
        
        visibleChunks.append(textChunks.removeFirst())
    }
    
    /// Fetches the next chunk of text and appends it to the visible array, with a 200ms delay
    private func fetchNext() async {
        guard !textChunks.isEmpty else {
            return
        }
        
        shouldShowProgressView = true
        try? await Task.sleep(nanoseconds: 200_000_000)
        visibleChunks.append(textChunks.removeFirst())
        shouldShowProgressView = false
    }
}
