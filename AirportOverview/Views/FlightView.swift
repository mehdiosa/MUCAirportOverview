//
//  FlightView.swift
//  AirportOverview
//
//  Created by Osama Mehdi on 26.07.23.
//

import SwiftUI

struct FlightView: View {
    var airline: String
    var departureCity: String
    var flightNumber: String
    var status: String
    var plannedArrivalTime: String
    var expectedArrivalTime: String
    var terminal: String

    var body: some View {
        // TODO: Think of something (maybe something else than a small message) to show the user that there was an error when loading the data.
        VStack {
            HStack {
                Text(departureCity.count > 0 ? departureCity : "NO DATA").frame(maxWidth: .infinity, alignment: .leading).bold()
                Text(terminal.count > 0 ? terminal : "").frame(maxWidth: .infinity, alignment: .center).bold()
                Text(flightNumber.count > 0 ? flightNumber : "").frame(maxWidth: .infinity, alignment: .trailing).bold()
            }.padding(.bottom, 10)

            HStack {
                Text(plannedArrivalTime.count > 0 ? "Geplant:\n" + plannedArrivalTime : "").frame(maxWidth: .infinity, alignment: .leading)

                Text(expectedArrivalTime.count > 0 ? "Erwartet:\n" + expectedArrivalTime : "").frame(maxWidth: .infinity, alignment: .center)

                Text(status.count > 0 ? "Status:\n" + status : "").frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

struct FlightView_Previews: PreviewProvider {
    static var previews: some View {
        FlightView(airline: "Lufthansa", departureCity: "Berlin", flightNumber: "EN 8309 (E320)", status: "beendet", plannedArrivalTime: "15:00", expectedArrivalTime: "15:40", terminal: "T2")

//        FlightView(airline: "", departureCity: "", flightNumber: "", status: "", plannedArrivalTime: "", expectedArrivalTime: "", terminal: "")
    }
}
