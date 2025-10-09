//
//  LongTextViewerApp.swift
//  LongTextViewer
//
//  Created by Maysam Shahsavari on 2025-10-06.
//

import SwiftUI
enum TextType {
    case longText1
    case longText2
    case longText3
}

struct ViewDestination: Identifiable {
    let id: UUID = UUID()
    let title: String
    let textType: TextType
    
    init(title: String, textType: TextType) {
        self.title = title
        self.textType = textType
    }
}

@main
struct LongTextViewerApp: App {
    let viewsList: [ViewDestination] = [
        ViewDestination(title: "Long Text", textType: .longText1),
        ViewDestination(title: "Very Long Text", textType: .longText2),
        ViewDestination(title: "Massive Text", textType: .longText3)]
    
    @ViewBuilder
    func destinationView(for viewDestination: ViewDestination) -> some View {
        switch viewDestination.textType {
            case .longText1:
            RegularView(textToView: Constants.longText1, title: viewDestination.title)
        case .longText2:
            RegularView(textToView: Constants.longText2, title: viewDestination.title)
        case .longText3:
            OptimizedView(title: viewDestination.title)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                NavigationSplitView(columnVisibility: .constant(.all), sidebar: {
                    List(viewsList) { item in
                        NavigationLink(destination: destinationView(for: item)) {
                            Text(item.title)
                                .foregroundStyle(.primary)
                                .padding()
                        }
                    }
                }, detail: {
                    Text("Select an item from the sidebar")
                })
                .environment(\.mainWindowRect, proxy.frame(in: .global))
            }
        }
    }
}
