//
//  FlightTypeView.swift
//  AirportOverview
//
//  Created by Osama Mehdi on 01.08.23.
//

import SwiftUI

struct MucAirportView: View {
    @State var mucData: MucAirportData

    @State var activeTab: String = "All flights"
    @State var title: String = ""

    var body: some View {
        TabView {
            NavigationStack {
                TabView(selection: $activeTab) {
                    AllFlightsInfoView(airportData: mucData.data.arrivalData).tabItem { Label("Overview", systemImage: "airplane.arrival") }.tag("All flights")
                    TerminalsInfoView(airportData: mucData.data.arrivalData, terminal: "T2").tabItem { Label("Terminal 2", systemImage: "2.square") }.tag("Terminal 2")
                    TerminalsInfoView(airportData: mucData.data.arrivalData, terminal: "T1A").tabItem { Label("Terminal 1A", systemImage: "a.square") }.tag("Terminal 1A")
                    TerminalsInfoView(airportData: mucData.data.arrivalData, terminal: "T1B").tabItem { Label("Terminal 1B", systemImage: "b.square") }.tag("Terminal 1B")
                    TerminalsInfoView(airportData: mucData.data.arrivalData, terminal: "T1C").tabItem { Label("Terminal 1C", systemImage: "c.square") }.tag("Terminal 1C")
                    TerminalsInfoView(airportData: mucData.data.arrivalData, terminal: "T1D").tabItem { Label("Terminal 1D", systemImage: "d.square") }.tag("Terminal 1D")
                    TerminalsInfoView(airportData: mucData.data.arrivalData, terminal: "T1E").tabItem { Label("Terminal 1E", systemImage: "e.square") }.tag("Terminal 1E")
                }
                .navigationTitle(Text(activeTab))
                .navigationBarTitleDisplayMode(.inline)
                .tabViewStyle(.page).indexViewStyle(.page(backgroundDisplayMode: .always))
                .listStyle(.plain)
                .toolbar { reloadToolbarItem() }.toolbarBackground(.hidden, for: .automatic)
            }.tabItem { Label("Arrivals", systemImage: "airplane.arrival") }

            NavigationStack {
                TabView(selection: $activeTab) {
                    AllFlightsInfoView(airportData: mucData.data.departureData).tabItem { Label("Overview", systemImage: "airplane.arrival") }.tag("All flights")
                    TerminalsInfoView(airportData: mucData.data.departureData, terminal: "T2").tabItem { Label("Terminal 2", systemImage: "2.square") }.tag("Terminal 2")
                    TerminalsInfoView(airportData: mucData.data.departureData, terminal: "T1").tabItem { Label("Terminal 1", systemImage: "1.square") }.tag("Terminal 1")
                }
                .navigationTitle(Text(activeTab))
                .navigationBarTitleDisplayMode(.inline)
                .tabViewStyle(.page).indexViewStyle(.page(backgroundDisplayMode: .always))
                .listStyle(.plain)
                .toolbar { reloadToolbarItem() }.toolbarBackground(.hidden, for: .automatic)
            }.tabItem { Label("Departures", systemImage: "airplane.departure") }
        }
    }

    @ToolbarContentBuilder
    func reloadToolbarItem() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                Task {
                    mucData.data.setAirportData(arrivalData: await mucData.loadData("arrivals"),
                                                departureData: await mucData.loadData("departures"))
                }
            } label: {
                Label("reload", systemImage: "arrow.clockwise")
            }
        }
    }
}
