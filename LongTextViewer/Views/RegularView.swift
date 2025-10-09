//
//  RegularView.swift
//  LongTextViewer
//
//  Created by Maysam Shahsavari on 2025-10-06.
//

import SwiftUI

struct RegularView: View {
    let textToView: String
    let title: String
    
    var body: some View {
        ScrollView {
            Text(title)
            Divider()
            Text(textToView)
        }
        .padding()
    }
}
