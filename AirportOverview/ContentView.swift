//
//  ContentView.swift
//  AirportOverview
//
//  Created by Osama Mehdi on 25.07.23.
//

import CoreData
import SwiftSoup
import SwiftUI

struct ContentView: View {
    @StateObject private var airportDataViewModel: AirportDataViewModel = .init()

    // TODO: When adding departures either create a view for each tabitem, where the data is passed (as in arrival and departure data) and use this instead of re-using code -> DRY Principle

    var body: some View {
        VStack {
            MucAirportView(mucData: airportDataViewModel.mucAirportData)
        }.background(Color(.white))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
