//
//  ContentView.swift
//  iTour
//
//  Created by Margarita Mayer on 13/12/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var sortOrder = SortDescriptor(\Destination.name)
    @State private var searchText = ""
    @State var dateIsChosen = false
    
    var body: some View {
        NavigationStack() {
            DestinationListingView(sort: sortOrder, searchString: searchText, isChosenDate: dateIsChosen)
            
            .navigationTitle("iTour")
            .searchable(text: $searchText)
            
            .toolbar {
                
                Button("Add Destination", systemImage: "plus", action: addDestination)
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Name")
                            .tag(SortDescriptor(\Destination.name))

                        Text("Priority")
                            .tag(SortDescriptor(\Destination.priority, order: .reverse))

                        Text("Date")
                            .tag(SortDescriptor(\Destination.date))
                    }
                    .pickerStyle(.inline)
                }
                
                
                
                Toggle("Sort", systemImage: "star", isOn: $dateIsChosen)
                
                    
                
                
            }
        }
        
    }

    
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
    }
}
//
//#Preview {
//    ContentView()
//}
