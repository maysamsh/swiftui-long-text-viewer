# Lazy Text Rendering for large texts in SwiftUI

This small demo shows a technique for displaying large text content in a SwiftUI scroll view without freezing the UI or making the layout sluggish.

The idea is simple: split the text into chunks, render only a few at a time, and load more as the user scrolls down.

---

## Overview

When you drop a long piece of text into a SwiftUI `ScrollView`, SwiftUI tries to layout everything at once. That’s fine for a few paragraphs, but if the text is really large, it can cause noticeable lag and block the main thread for a while.

To get around that, I split the input text into smaller parts and only show a few of them at any given time. When the user reaches the end of the visible text, a custom view modifier detects it and loads the next chunk.

---

## How it works

1. The input text is split into chunks based on newline (`\n`) characters.  
2. Two arrays are created: one for all chunks (`textChunks`) and one for visible chunks (`visibleChunks`).  
3. The `onBecomingVisible` modifier, attached to an invisible view at the bottom of the list, triggers when it scrolls into view.  
4. When triggered, it pops the next chunk from `textChunks` and appends it to `visibleChunks`.  
5. If the text is too short to fill the scroll view, the view automatically keeps loading more chunks until the content is taller than the scroll area or there’s nothing left.

This way, the scroll view has enough time to layout its children without blocking the UI.

Read the article here https://maysamsh.me/2025/10/13/lazy-text-rendering-for-large-texts-in-swiftui/
