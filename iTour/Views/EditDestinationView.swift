//
//  EditDestinationView.swift
//  iTour
//
//  Created by Margarita Mayer on 13/12/23.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var destination: Destination
    @State private var newSightName = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $destination.name)
                TextField("Details", text: $destination.details)
                DatePicker("Date", selection: $destination.date)
                
                Section("Priority"){
                    Picker("Priority", selection: $destination.priority) {
                        Text("Meh").tag(1)
                        Text("Maybe").tag(2)
                        Text("Must").tag(3)
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Sights") {
                    
                    ForEach(destination.sights) { sight in
                        Text(sight.name)
                    }
                    .onDelete(perform: deleteSights)
                    
                    HStack {
                        
                        TextField("Add a new sight to the \(destination.name)", text: $newSightName)
                        
                        Button("Add", action: addSight)
                    }
                }
                
                
            }
            .navigationTitle("Edit destination")
            .navigationBarTitleDisplayMode(.inline)
            
        }
       
    }
    
    func addSight() {
        guard newSightName.isEmpty == false else { return }
        
        withAnimation {
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = ""
        }
    }
    
    func deleteSights(_ indexSet: IndexSet) {
        for index in indexSet {
            let sight1 = destination.sights[index]
            modelContext.delete(sight1)
        }
        
    }
    
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Example Destination", details: "Example details go here and will automatically expand vertically as they are edited.")
        return EditDestinationView(destination: example)
            .modelContainer(container)
       
    } catch {
        fatalError("Failed to create model container.")
    }
}
