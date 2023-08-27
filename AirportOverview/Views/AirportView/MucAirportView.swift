//
//  FlightTypeView.swift
//  AirportOverview
//
//  Created by Osama Mehdi on 01.08.23.
//

import SwiftUI

struct MucAirportView: View {
    @State var mucData: MucAirportData

    @State var activeTab: Terminals = .allFlights
    @State var activePage: FlightType = .Ankünfte

    var body: some View {
        VStack {
            if mucData.isFetching {
                ProgressView("Lade Fluginformationen...").background(Color(UIColor.systemBackground))
            } else {
                TabView(selection: $activePage) {
                    NavigationStack {
                        TabView(selection: $activeTab) {
                            AllFlightsInfoView(airportData: mucData.data.arrivalData).tabItem {}.tag(Terminals.allFlights)
                            TerminalsInfoView(airportData: mucData.data.arrivalData, terminal: "T2").tabItem {}.tag(Terminals.terminal2)
                            TerminalsInfoView(airportData: mucData.data.arrivalData, terminal: "T1A").tabItem {}.tag(Terminals.terminal1A)
                            TerminalsInfoView(airportData: mucData.data.arrivalData, terminal: "T1B").tabItem {}.tag(Terminals.terminal1B)
                            TerminalsInfoView(airportData: mucData.data.arrivalData, terminal: "T1C").tabItem {}.tag(Terminals.terminal1C)
                            TerminalsInfoView(airportData: mucData.data.arrivalData, terminal: "T1D").tabItem {}.tag(Terminals.terminal1D)
                            TerminalsInfoView(airportData: mucData.data.arrivalData, terminal: "T1E").tabItem {}.tag(Terminals.terminal1E)
                            TerminalsInfoView(airportData: mucData.data.arrivalData, terminal: "T1F").tabItem {}.tag(Terminals.terminal1F)
                        }
                        .tabViewStyle(.page).indexViewStyle(.page(backgroundDisplayMode: .never))
                        .listStyle(.plain)
                        .toolbar {
                            createQuickNavButtons(mucData.data.availableArrivalTerminals)
                            reloadToolbarItem()
                        }.toolbarBackground(.hidden, for: .tabBar)
                        .navigationTitle(Text(activePage.rawValue))
                        .navigationBarTitleDisplayMode(.inline)
                    }.tabItem { Label("Ankünfte", systemImage: "airplane.arrival") }.tag(FlightType.Ankünfte)

                    NavigationStack {
                        TabView(selection: $activeTab) {
                            AllFlightsInfoView(airportData: mucData.data.departureData).tabItem {}.tag(Terminals.allFlights)
                            TerminalsInfoView(airportData: mucData.data.departureData, terminal: "T1").tabItem {}.tag(Terminals.terminal1)
                            TerminalsInfoView(airportData: mucData.data.departureData, terminal: "T2").tabItem {}.tag(Terminals.terminal2)
                        }
                        .tabViewStyle(.page).indexViewStyle(.page(backgroundDisplayMode: .never))
                        .listStyle(.plain)
                        .toolbar {
                            createQuickNavButtons(mucData.data.availableDepartureTerminals)
                            reloadToolbarItem()
                        }
                        .toolbarBackground(.hidden, for: .tabBar)
                        .navigationTitle(Text(activePage.rawValue))
                        .navigationBarTitleDisplayMode(.inline)
                    }.tabItem { Label("Abflüge", systemImage: "airplane.departure") }.tag(FlightType.Abflüge)
                }
                .toolbar {}.toolbarBackground(.hidden, for: .tabBar)
            }
        }.task { await reloadData() }
    }

    @ToolbarContentBuilder
    func reloadToolbarItem() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                Task {
                    await reloadData()
                }
            } label: {
                Label("reload", systemImage: "arrow.clockwise")
            }
        }
    }

    // This could be used as an extension in the future
    @ToolbarContentBuilder
    func createQuickNavButtons(_ availableTerminals: [Terminals]) -> some ToolbarContent {
        ToolbarItemGroup(placement: .status) {
            ForEach(Terminals.allCases) { terminal in
                if availableTerminals.contains(terminal) {
                    Button(action: { activeTab = terminal }) {
                        Label(terminal.rawValue,
                              systemImage:
                              terminal.rawValue == "All flights" ? activeTab == terminal ? "airplane.circle.fill" : "airplane.circle" :
                                  terminal.rawValue == "T1" ? activeTab == terminal ? "1.circle.fill" : "1.circle" :
                                  terminal.rawValue == "T2" ? activeTab == terminal ? "2.circle.fill" : "2.circle" :
                                  activeTab == terminal ? terminal.rawValue.dropFirst(2).lowercased() + ".circle.fill" : terminal.rawValue.dropFirst(2).lowercased() + ".circle")
                    }
                }
            }
        }
    }

    // This could be used as an extension in the future
    private func getAllTerminals(_ data: [FlightData]) -> [String] {
        var terminals = [String]()
        for flight in data {
            if !terminals.contains(flight.area) {
                terminals.append(flight.area)
            }
        }
        return terminals
    }

    private func reloadData() async {
        mucData.isFetching = true
        mucData.data.setAirportData(arrivalData: await mucData.loadData("arrivals"),
                                    departureData: await mucData.loadData("departures"))
        mucData.isFetching = false
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}

struct MucAirportView_Previews: PreviewProvider {
    static var previews: some View {
        MucAirportView(mucData: MucAirportData(data: AirportData(arrivalData: [
            FlightData(airline: "Lufthansa", departureCity: "Sibiu (SBZ)", number: "LH 1665 (CRJ9)", status: "beendet", timeOther: "14:10", plannedArrivalTime: "14:55", expectedArrivalTime: "14:50", area: "T2"),
            FlightData(airline: "Lufthansa", departureCity: "Porto (OPO)", number: "LH 1783 (A20N)", status: "beendet", timeOther: "11:10", plannedArrivalTime: "14:55", expectedArrivalTime: "14:55", area: "T1A"),
            FlightData(airline: "EGYPTAIR", departureCity: "Kairo (CAI)", number: "MS 787 (A20N)", status: "beendet", timeOther: "12:05", plannedArrivalTime: "14:55", expectedArrivalTime: "15:00", area: "T1B"),
        ], departureData: [
            FlightData(airline: "Lufthansa", departureCity: "Sibiu (SBZ)", number: "LH 1665 (CRJ9)", status: "beendet", timeOther: "14:10", plannedArrivalTime: "14:55", expectedArrivalTime: "14:50", area: "T2"),
            FlightData(airline: "Lufthansa", departureCity: "Porto (OPO)", number: "LH 1783 (A20N)", status: "beendet", timeOther: "11:10", plannedArrivalTime: "14:55", expectedArrivalTime: "14:55", area: "T2"),
            FlightData(airline: "EGYPTAIR", departureCity: "Kairo (CAI)", number: "MS 787 (A20N)", status: "beendet", timeOther: "12:05", plannedArrivalTime: "14:55", expectedArrivalTime: "15:00", area: "T2"),
        ])))
    }
}
