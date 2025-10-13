//
//  IdentifiableText.swift
//  LongTextViewer
//
//  Created by Maysam Shahsavari on 2025-10-13.
//

import Foundation

struct IdentifiableText: Identifiable, Equatable {
    let id: UUID = UUID()
    let text: String
}
