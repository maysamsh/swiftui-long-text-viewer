//
//  OptimizedViewModel.swift
//  LongTextViewer
//
//  Created by Maysam Shahsavari on 2025-10-13.
//
import Foundation
import Combine
import OSLog

final class OptimizedViewModel: ObservableObject {
    @Published var textChunks: [IdentifiableText] = []
    @Published var visibleChunks: [IdentifiableText] = []
    @Published var contentHeight: CGFloat = 0
    @Published var scrollViewHeight: CGFloat = 0
    
    var needsScrolling: Bool {
        contentHeight > scrollViewHeight
    }
    
    init() {
        
    }
    
    /// Splits the given text into smaller parts, separated by the break-line character (`\n`).
    /// - Parameters:
    ///   - input: Input text
    ///   - textChunks: An array to represent the input the text.
    ///   - visibleChunks: An array of string that's used as the data source for the text on screen.
    ///   - strideLength: The number of pieces separated by the break-line character that becomes an item in `textChunks`.
    func splitText(input: String,
                           textChunks: inout [IdentifiableText],
                           strideLength: Int) {
        let indices = input.indices(of: "\n")
        if indices.ranges.count <= strideLength {
            textChunks = [IdentifiableText(text: input)]
            return
        }
        let logger = Logger()
        logger.log("Number of indices: \(indices.ranges.count)")
        var startIndex: String.Index? = input.startIndex
        var endIndex: String.Index?
        
        stride(from: strideLength - 1, through: indices.ranges.count - 1, by: strideLength).forEach { index in
            endIndex = indices.ranges[index].upperBound
            if let start = startIndex, let end = endIndex {
                let chunk = String(input[start..<end])
                textChunks.append(IdentifiableText(text: chunk))
                startIndex =  indices.ranges[index].upperBound
            }
            
        }
        if let endIndex, endIndex < input.endIndex {
            textChunks.append(IdentifiableText(text: String(input[endIndex...])))
        }
    }
    
    /// Fetches the next chunk of text and appends it to the visible array, with a 200ms delay
    func fetchNext() async {
        guard !textChunks.isEmpty else {
            return
        }
        try? await Task.sleep(nanoseconds: 10_000_000)
        visibleChunks.append(textChunks.removeFirst())
    }
}
