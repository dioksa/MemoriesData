//
//  ContentView.swift
//  MemoriesData
//
//  Created by Oksana Dionisieva on 16.01.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Memory]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        MemoryDetailView(item: item, saveAction: saveChanges)
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .long, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                if !items.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .overlay {
                if items.isEmpty {
                    ContentUnavailableView(label: {
                        Text("No memories added yet...")
                            .padding(16)
                    }, description: {
                        Image(.memoIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 320, height: 320)
                            .cornerRadius(80)
                            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
                    }, actions: {
                        Button("Add new memory") {
                            addItem()
                        }
                    })
                }
            }
        } detail: { }
    }

    private func addItem() {
        withAnimation {
            let newItem = Memory(timestamp: Date(), title: "", memoDescription: "")
            modelContext.insert(newItem)
            try! modelContext.save()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
                saveChanges()
            }
        }
    }

    private func saveChanges() {
        try? modelContext.save()
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Memory.self, inMemory: true)
}
