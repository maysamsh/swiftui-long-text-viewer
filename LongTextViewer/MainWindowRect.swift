//
//  MainWindowRect.swift
//  LongTextViewer
//
//  Created by Maysam Shahsavari on 2025-10-08.
//

import SwiftUI

private struct MainWindowSizeKey: EnvironmentKey {
    static let defaultValue: CGRect = .zero
}

extension EnvironmentValues {
    var mainWindowRect: CGRect {
        get { self[MainWindowSizeKey.self] }
        set { self[MainWindowSizeKey.self] = newValue }
    }
}
