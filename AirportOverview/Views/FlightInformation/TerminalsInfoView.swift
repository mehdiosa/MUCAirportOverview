//
//  TerminalsInfoView.swift
//  AirportOverview
//
//  Created by Osama Mehdi on 26.07.23.
//

import SwiftUI

struct TerminalsInfoView: View {
    var airportData: [FlightData] = []
    // TODO: CHANGE THIS TO TERMINALS AND MERGE ALLFLIGHTSINFO WITH THIS VIEW TO CREATE ONE VIEW INSTEAD OF MULTIPLE VIEWS -> DRY PRINCIPLE
    var terminal: String = ""

    var body: some View {
        displayTerminalData(terminal)
    }

    @ViewBuilder
    func displayTerminalData(_ terminal: String) -> some View {
        let terminalData = getTerminalData(terminal)

        if terminalData.isEmpty {
            Text("Keine Fluginformationen für Terminal " + terminal.dropFirst() + " verfügbar.")
        }
        else {
            List {
                ForEach(terminalData) { flight in
                    FlightInfoView(airline: flight.airline,
                                   departureCity: flight.departureCity,
                                   flightNumber: flight.number,
                                   status: flight.status,
                                   plannedArrivalTime: flight.plannedArrivalTime,
                                   expectedArrivalTime: flight.expectedArrivalTime,
                                   terminal: flight.area)
                }
            }
        }
    }

    private func getTerminalData(_ terminal: String) -> [FlightData] {
        var terminalData = [FlightData]()

        for flight in airportData {
            if flight.area == terminal {
                terminalData.append(flight)
            }
        }
        return terminalData
    }
}

struct TerminalsView_Previews: PreviewProvider {
    static var previews: some View {
        TerminalsInfoView(airportData: [
            FlightData(airline: "Lufthansa", departureCity: "Sibiu (SBZ)", number: "LH 1665 (CRJ9)", status: "beendet", timeOther: "14:10", plannedArrivalTime: "14:55", expectedArrivalTime: "14:50", area: "T2"),
            FlightData(airline: "Lufthansa", departureCity: "Porto (OPO)", number: "LH 1783 (A20N)", status: "beendet", timeOther: "11:10", plannedArrivalTime: "14:55", expectedArrivalTime: "14:55", area: "T2"),
            FlightData(airline: "EGYPTAIR", departureCity: "Kairo (CAI)", number: "MS 787 (A20N)", status: "beendet", timeOther: "12:05", plannedArrivalTime: "14:55", expectedArrivalTime: "15:00", area: "T2"),
        ], terminal: "T2")
    }
}
