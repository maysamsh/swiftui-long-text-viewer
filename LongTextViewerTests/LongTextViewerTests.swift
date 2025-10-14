//
//  LongTextViewerTests.swift
//  LongTextViewerTests
//
//  Created by Maysam Shahsavari on 2025-10-13.
//

import Testing
@testable import LongTextViewer

struct LongTextViewerTests {
    let text: String = """
    1 Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    2 Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    3 Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    4 Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    5 Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    6 Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    7 Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    8 Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    9 Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    10 Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    11 Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    12 Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    13 Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    14 Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    15 Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    16 Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    """
    let sut: OptimizedViewModel = .init()
    
    @MainActor
    @Test func reconstructSmallStride() throws {
        sut.splitText(input: text, textChunks: &sut.textChunks, strideLength: 2)
        #expect(sut.textChunks.count == 8)
        let reconstructedText = sut.textChunks
            .map { $0.text }
            .joined()
        print(sut.textChunks[0].text)
        print(sut.textChunks.last!.text)

        #expect(reconstructedText == text)
    }

    @MainActor
    @Test func reconstructLargeStride() throws {
        sut.splitText(input: text, textChunks: &sut.textChunks, strideLength: 20)
        #expect(sut.textChunks.count == 1)
        let reconstructedText = sut.textChunks
            .map { $0.text }
            .joined()
        
        #expect(reconstructedText == text)
    }
}
