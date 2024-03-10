//
//  DestinationListingView.swift
//  iTour
//
//  Created by Margarita Mayer on 14/12/23.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse), SortDescriptor(\Destination.name)]) var destinations: [Destination]
    
    
    var body: some View {
        List {
            ForEach(destinations) { destination in
                NavigationLink(destination: EditDestinationView(destination: destination)) {
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        Text(destination.date.formatted(date: .long, time: .shortened))
                        
                    }
                
                }
                
            }
            .onDelete(perform: deleteDestinations)
        }
    }
    
    init(sort: SortDescriptor<Destination>, searchString: String, isChosenDate: Bool) {
    
        _destinations = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
        }, sort: [sort])
        
        let now = Date.now

            _destinations = Query(filter: #Predicate {
                if isChosenDate {
                 return $0.date > now
                } else {
                    return true
                }
            }, sort: [sort])
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "", isChosenDate: false)}
