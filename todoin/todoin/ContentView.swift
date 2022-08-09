//
//  ContentView.swift
//  todoin
//
//  Created by Y3SUNG on 2022/08/08.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @Environment(\.managedObjectContext) public var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    
    public var items: FetchedResults<Item>
    
    @State public var addItemView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    HStack {
                        if item.isImportant {
                            Image(systemName: "timer")
                                .foregroundColor(.blue)
                        } else {
                            Image(systemName: "timer")
                                .foregroundColor(.gray)
                        }
                        Text(item.title ?? "")
                        Spacer()
                        if item.timestamp! > Date() {
                            Text(item.timestamp!, style: .relative)
                        } else {
                            Text("-\(item.timestamp!, style: .relative)")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("ToDoIn")
            .sheet(isPresented: $addItemView) {
                AdditemView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        addItemView.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        Text("You can do it!")
    }

    public func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func d_dayCal() {
        
    }
}
