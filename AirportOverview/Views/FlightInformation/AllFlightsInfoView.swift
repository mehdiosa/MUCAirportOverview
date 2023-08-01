//
//  AllFlightsInfoView.swift
//  AirportOverview
//
//  Created by Osama Mehdi on 26.07.23.
//

import SwiftUI

struct AllFlightsInfoView: View {
    var airportData: [FlightData] = []

    var body: some View {
        List {
            if airportData.count <= 0 {
                FlightInfoView(airline: "", departureCity: "", flightNumber: "", status: "", plannedArrivalTime: "", expectedArrivalTime: "", terminal: "")
            } else {
                ForEach(airportData, id: \.number) { flight in
                    FlightInfoView(airline: flight.airline,
                                   departureCity: flight.departureCity,
                                   flightNumber: flight.number,
                                   status: flight.status,
                                   plannedArrivalTime: flight.plannedArrivalTime,
                                   expectedArrivalTime: flight.expectedArrivalTime,
                                   terminal: flight.area)
                }
            }
        }.navigationTitle("All flights")
    }
}

struct AllFlightsView_Previews: PreviewProvider {
    static var previews: some View {
        AllFlightsInfoView()
    }
}
