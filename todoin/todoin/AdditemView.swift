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
    @State private var wakeUp = Date()
    
    @FetchRequest(sortDescriptors: []) public var item: FetchedResults<Item>
    
    var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker("Choose Deadline", selection: $wakeUp, in: Date()...)
                    .datePickerStyle(WheelDatePickerStyle()).labelsHidden()
                TextField("", text: $itemTitle)
                //Text("Date is \(wakeUp, formatter: dateFormatter)")
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
        newItem.timestamp = wakeUp
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
