//
//  OptimizedView.swift
//  LongTextViewer
//
//  Created by Maysam Shahsavari on 2025-10-06.
//

import SwiftUI

struct OptimizedView: View {
    let title: String
    @StateObject private var viewModel: OptimizedViewModel = .init()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .zero) {
                Text(title)
                Divider()
                ForEach(viewModel.visibleChunks) { item in
                    Text(item.text)
                        .disabled(true)
                        .lineLimit(nil)
                }
                if !viewModel.visibleChunks.isEmpty {
                    invisibleView
                        .onBecomingVisible {
                            Task {
                                try? await Task.sleep(nanoseconds: 10_000_000)
                                await viewModel.fetchNext()
                            }
                        }
                }
            }
            .contentHeight(bind: $viewModel.contentHeight)
        }
        .contentHeight(bind: $viewModel.scrollViewHeight)
        .padding()
        .onChange(of: viewModel.visibleChunks, { _, _ in
            /// If the text is not large enough after the first call to `fetchNext()` the view
            /// keeps fetching content until the content size of the scroll view is large enough
            /// to work with the fetch logic or all the content is shown
            if viewModel.needsScrolling == false, viewModel.textChunks.isEmpty == false {
                Task {
                    try? await Task.sleep(nanoseconds: 10_000_000)
                    await viewModel.fetchNext()
                }
            }
        })
        .task {
            viewModel.splitText(input: Constants.longText1, textChunks: &viewModel.textChunks, strideLength: 5)
            if !viewModel.textChunks.isEmpty {
                viewModel.visibleChunks.append(viewModel.textChunks.removeFirst())
            }
        }
    }
    
    private var invisibleView: some View {
        Rectangle()
            .background(Color.clear)
            .foregroundStyle(Color.clear)
    }
}

