//
//  MemoryDetailView.swift
//  MemoriesData
//
//  Created by Oksana Dionisieva on 16.01.2025.
//

import SwiftUI

struct MemoryDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var memoDescription: String

    let item: Memory
    let saveAction: () -> Void

    init(item: Memory, saveAction: @escaping () -> Void) {
        self.item = item
        self.saveAction = saveAction
        self._memoDescription = State(initialValue: item.memoDescription ?? "")
    }

    var body: some View {
        VStack {
            Text("Shared memory: \n \(item.title) at \(item.timestamp, format: Date.FormatStyle(date: .complete, time: .standard))")
                .multilineTextAlignment(.center)
                .padding()

            TextEditor(text: $memoDescription)
                .frame(height: 200)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)

            Button("Save") {
                item.memoDescription = memoDescription
                saveAction()
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 16)
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Memory.self, inMemory: true)
}
