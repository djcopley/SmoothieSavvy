//
//  NotesEditor.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/13/23.
//

import SwiftUI

struct TextEditorWithDefault: View {
    @Binding var text: String
    @FocusState private var editorIsFocused: Bool
    
    var body: some View {
        TextEditor(text: $text)
            .onSubmit {
                editorIsFocused = false
            }
            .focused($editorIsFocused)
            .overlay(alignment: .topLeading) {
                Text("Notes...")
                    .opacity(text.isEmpty && !editorIsFocused ? 1 : 0)
                    .foregroundColor(.secondary)
                    .padding(8)
            }
    }
}

struct NotesEditor_Previews: PreviewProvider {
    @State static var notes = ""
    static var previews: some View {
        TextEditorWithDefault(text: $notes)
    }
}
