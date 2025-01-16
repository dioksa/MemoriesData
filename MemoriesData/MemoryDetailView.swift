//
//  MemoryDetailView.swift
//  MemoriesData
//
//  Created by Oksana Dionisieva on 16.01.2025.
//

import SwiftUI

struct MemoryDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String
    @State private var memoDescription: String

    let item: Memory
    let saveAction: () -> Void

    init(item: Memory, saveAction: @escaping () -> Void) {
        self.item = item
        self.saveAction = saveAction
        self._title = State(initialValue: item.title)
        self._memoDescription = State(initialValue: item.memoDescription ?? "")
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Edit Memory")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)

                TextField("Enter a title...", text: $title)
                    .font(.title2)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)

                Text("Memory Description")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                TextEditor(text: $memoDescription)
                    .frame(minHeight: 200, maxHeight: 300)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)

                Button(action: {
                    item.title = title
                    item.memoDescription = memoDescription
                    saveAction()
                    dismiss()
                }) {
                    Text("Save Changes")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Memory.self, inMemory: true)
}

