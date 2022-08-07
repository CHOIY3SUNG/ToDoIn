//
//  AdditemView.swift
//  todoin
//
//  Created by Y3SUNG on 2022/08/08.
//

import SwiftUI

struct AdditemView: View {
    @Environment(\.managedObjectContext) public var viewContext
    @Environment(\.dismiss) public var dismiss
    
    @State public var itemTitle = ""
    
    @FetchRequest(sortDescriptors: []) public var item: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            Form {
                TextField("", text: $itemTitle)
                Button(action: {
                    saveItem()
                    dismiss()
                }, label: {
                    Text("Save").frame(minWidth: 0, maxWidth: .infinity)
                })
            }
            .navigationTitle("Plus")
        }
    }
    
    public func saveItem() {
        let newItem = Item(context: viewContext)
        newItem.title = itemTitle
        newItem.timestamp = Date()
        do {
            try viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

struct AdditemView_Previews: PreviewProvider {
    static var previews: some View {
        AdditemView()
    }
}
