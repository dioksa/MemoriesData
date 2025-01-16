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
                    NavigationLink(destination: MemoryDetailView(item: item, saveAction: saveChanges)) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.title.isEmpty ? "Untitled Memory" : item.title)
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text(item.timestamp, format: Date.FormatStyle(date: .long, time: .shortened))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                if !items.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                            .foregroundColor(.accentColor)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                                .labelStyle(.iconOnly)
                                .foregroundColor(.accentColor)
                        }
                    }
                }
            }
            .overlay {
                if items.isEmpty {
                    emptyStateView
                }
            }
            .background(Color(.systemGroupedBackground))
        } detail: { }
    }

    private var emptyStateView: some View {
        VStack {
            Image("memo_icon")
                .resizable()
                .scaledToFit()
                .frame(width: 380, height: 380)
                .foregroundColor(.gray.opacity(0.5))
                .cornerRadius(180)
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
                .padding()
            Text("No memories added yet...")
                .font(.title3)
                .foregroundColor(.gray)
                .padding(.bottom, 8)
            Button(action: addItem) {
                Text("Add New Memory")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 32)
        }
        .padding()
    }

    private func addItem() {
        withAnimation {
            let newItem = Memory(timestamp: Date(), title: "", memoDescription: "")
            modelContext.insert(newItem)
            saveChanges()
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

