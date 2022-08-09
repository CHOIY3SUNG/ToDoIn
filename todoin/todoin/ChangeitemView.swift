//
//  ChangeitemView.swift
//  todoin
//
//  Created by Y3SUNG on 2022/08/10.
//

import SwiftUI

struct ChangeitemView: View {
    @Environment(\.managedObjectContext) public var viewContext
    @Environment(\.dismiss) public var dismiss
    @State private var showWidget = false
    
    @State public var itemTitle = ""
    @State private var wakeUp = Date()
    @State private var isShowWidget = false
    
    @FetchRequest(sortDescriptors: []) public var item: FetchedResults<Item>
    var body: some View {
        NavigationView {
            Form {
                DatePicker("Choose Deadline", selection: $wakeUp, in: Date()...)
                    .datePickerStyle(WheelDatePickerStyle()).labelsHidden()
                TextField("Write Todo", text: $itemTitle)
                Toggle(isOn: $showWidget) {
                    Text("Show Widget")
                }
                Button(action: {
                    resaveItem()
                    dismiss()
                }, label: {
                    Text("Save").frame(minWidth: 0, maxWidth: .infinity)
                })
            }
            .navigationTitle("Change")
        }
    }
    
    public func resaveItem() {
        let reItem = Item(context: viewContext)
        reItem.title = itemTitle
        reItem.timestamp = wakeUp
        reItem.isShowWidget = showWidget
        do {
            try viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

struct ChangeitemView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeitemView()
    }
}
