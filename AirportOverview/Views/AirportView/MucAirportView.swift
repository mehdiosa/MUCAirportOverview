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
                            FlightListView(airportData: mucData.data.arrivalData, terminal: Terminals.allFlights).tabItem {}.tag(Terminals.allFlights)
                            FlightListView(airportData: mucData.data.arrivalData, terminal: Terminals.terminal2).tabItem {}.tag(Terminals.terminal2)
                            FlightListView(airportData: mucData.data.arrivalData, terminal: Terminals.terminal1A).tabItem {}.tag(Terminals.terminal1A)
                            FlightListView(airportData: mucData.data.arrivalData, terminal: Terminals.terminal1B).tabItem {}.tag(Terminals.terminal1B)
                            FlightListView(airportData: mucData.data.arrivalData, terminal: Terminals.terminal1C).tabItem {}.tag(Terminals.terminal1C)
                            FlightListView(airportData: mucData.data.arrivalData, terminal: Terminals.terminal1D).tabItem {}.tag(Terminals.terminal1D)
                            FlightListView(airportData: mucData.data.arrivalData, terminal: Terminals.terminal1E).tabItem {}.tag(Terminals.terminal1E)
                            FlightListView(airportData: mucData.data.arrivalData, terminal: Terminals.terminal1F).tabItem {}.tag(Terminals.terminal1F)
                        }
                        .tabViewStyle(.page).indexViewStyle(.page(backgroundDisplayMode: .never))
                        .listStyle(.plain)
                        .toolbar {
                            createQuickNavButtons(mucData.data.availableArrivalTerminals)
                            reloadToolbarItem()
                        }.toolbarBackground(.hidden, for: .tabBar)
                        .navigationTitle(Text(activePage.rawValue))
                        .navigationBarTitleDisplayMode(.inline)
                    }.tabItem { Label(FlightType.Ankünfte.rawValue, systemImage: "airplane.arrival") }.tag(FlightType.Ankünfte)

                    NavigationStack {
                        TabView(selection: $activeTab) {
                            FlightListView(airportData: mucData.data.departureData, terminal: Terminals.allFlights).tabItem {}.tag(Terminals.allFlights)
                            FlightListView(airportData: mucData.data.departureData, terminal: Terminals.terminal1).tabItem {}.tag(Terminals.terminal1)
                            FlightListView(airportData: mucData.data.departureData, terminal: Terminals.terminal2).tabItem {}.tag(Terminals.terminal2)
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
                    }.tabItem { Label(FlightType.Abflüge.rawValue, systemImage: "airplane.departure") }.tag(FlightType.Abflüge)
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

    @ToolbarContentBuilder
    func createQuickNavButtons(_ availableTerminals: [Terminals]) -> some ToolbarContent {
        ToolbarItemGroup(placement: .status) {
            ForEach(Terminals.allCases) { terminal in
                if availableTerminals.contains(terminal) {
                    Button(action: { activeTab = terminal }) {
                        Label(terminal.rawValue,
                              systemImage:
                              terminal.rawValue == Terminals.allFlights.rawValue ? activeTab == terminal ? "airplane.circle.fill" : "airplane.circle" :
                                  terminal.rawValue == Terminals.terminal1.rawValue ? activeTab == terminal ? "1.circle.fill" : "1.circle" :
                                  terminal.rawValue == Terminals.terminal2.rawValue ? activeTab == terminal ? "2.circle.fill" : "2.circle" :
                                  activeTab == terminal ? terminal.rawValue.dropFirst(2).lowercased() + ".circle.fill" : terminal.rawValue.dropFirst(2).lowercased() + ".circle")
                    }
                }
            }
        }
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
