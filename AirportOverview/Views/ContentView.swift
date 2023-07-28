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
    @ObservedObject var airportDataModel: AirportData = .init()
    @State var airportData: [[String: String]] = [[:]]
    @State var activeTab: String = "All flights"
    @State var title: String = ""

    var body: some View {
        VStack {
            if airportDataModel.isFetching {
                ProgressView("Loading Airport Data")
            } else {
                NavigationStack {
                    TabView(selection: $activeTab) {
                        AllFlightsView(airportData: airportData).tabItem { Label("Overview", systemImage: "airplane.arrival") }.tag("All flights")
                        TerminalsView(airportData: airportData, terminal: "T2").tabItem { Label("Terminal 2", systemImage: "2.square") }.tag("Terminal 2")
                        TerminalsView(airportData: airportData, terminal: "T1A").tabItem { Label("Terminal 1A", systemImage: "a.square") }.tag("Terminal 1A")
                        TerminalsView(airportData: airportData, terminal: "T1B").tabItem { Label("Terminal 1B", systemImage: "b.square") }.tag("Terminal 1B")
                        TerminalsView(airportData: airportData, terminal: "T1C").tabItem { Label("Terminal 1C", systemImage: "c.square") }.tag("Terminal 1C")
                        TerminalsView(airportData: airportData, terminal: "T1D").tabItem { Label("Terminal 1D", systemImage: "d.square") }.tag("Terminal 1D")
                        TerminalsView(airportData: airportData, terminal: "T1E").tabItem { Label("Terminal 1E", systemImage: "e.square") }.tag("Terminal 1E")
                    }
                    .navigationTitle(Text(activeTab))
                    .navigationBarTitleDisplayMode(.inline)
                    .tabViewStyle(.page).indexViewStyle(.page(backgroundDisplayMode: .always))
                    .listStyle(.plain)
                }.toolbarBackground(.hidden, for: .automatic)
            }
        }.task {
            airportData = await airportDataModel.loadData()
            airportDataModel.isFetching = false
        }.background(Color(.white))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
