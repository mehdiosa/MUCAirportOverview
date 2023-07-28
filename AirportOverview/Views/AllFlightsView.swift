//
//  AllFlightsView.swift
//  AirportOverview
//
//  Created by Osama Mehdi on 26.07.23.
//

import SwiftUI

struct AllFlightsView: View {
    var airportData: [[String: String]] = [[:]]

    var body: some View {
        List {
            ForEach(airportData, id: \.self) { flightData in
                if flightData.isEmpty {
                    FlightView(airline: "", departureCity: "", flightNumber: "", status: "", plannedArrivalTime: "", expectedArrivalTime: "", terminal: "").padding()

                } else {
                    FlightView(airline: flightData["airline"]!,
                               departureCity: flightData["departureCity"]!,
                               flightNumber: flightData["number"]!,
                               status: flightData["status"]!,
                               plannedArrivalTime: flightData["plannedArrivalTime"]!,
                               expectedArrivalTime: flightData["expectedArrivalTime"]!,
                               terminal: flightData["area"]!).padding()
                }
            }
        }.navigationTitle("All flights")
    }
}

struct AllFlightsView_Previews: PreviewProvider {
    static var previews: some View {
        AllFlightsView()
    }
}
