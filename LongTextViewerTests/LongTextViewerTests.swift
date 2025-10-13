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
    1Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                2Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                3Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                4Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                5Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                6Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                7Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                8Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                9Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                10Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                11Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                12Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                13Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                14Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                15Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                16Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    """
    let sut: OptimizedViewModel = .init()
    
    @Test func reconstruct() async throws {
        // adding tests
    }

}
