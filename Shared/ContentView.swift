//
//  ContentView.swift
//  Shared
//
//  Created by Malcolm Hall on 24/06/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // define a source of truth for the sort order
    @AppStorage("SortAscending") var sortAscending = true
    
    var body: some View {
        NavigationView {
            FetchedItems(sortAscending: sortAscending)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button(action: { sortAscending.toggle() } ) {
                                Label("Date", systemImage: sortAscending ? "chevron.down" : "chevron.up")
                            }
                        } label: {
                            Image(systemName:"ellipsis.circle")
                        }
                    }
                }
            }
        }
}


struct FetchedItems: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest
    private var items: FetchedResults<Item>

    init(sortAscending: Bool) {
        let sortDescriptors = [SortDescriptor(\Item.timestamp, order: sortAscending ? .forward : .reverse)]
        _items = FetchRequest(sortDescriptors: sortDescriptors, animation: .default)
    }
    
    var body: some View {
        List {
            ForEach(items) { item in
                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            #if os(iOS)
            ToolbarItem(placement: .navigation) {
                EditButton()
            }
            #endif

            ToolbarItem(placement: .primaryAction) {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
                
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

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

    private func deleteItems(offsets: IndexSet) {
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
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
