//
//  FlightInfoView.swift
//  AirportOverview
//
//  Created by Osama Mehdi on 26.07.23.
//

import SwiftUI

struct FlightInfoView: View {
    var airline: String
    var departureCity: String
    var flightNumber: String
    var status: String
    var plannedArrivalTime: String
    var expectedArrivalTime: String
    var terminal: String

    var body: some View {
        VStack {
            HStack {
                Text(self.departureCity.count > 0 ? self.departureCity : "").frame(maxWidth: .infinity, alignment: .leading).bold()
                Text(self.terminal.count > 0 ? self.terminal : "").frame(maxWidth: .infinity, alignment: .center).bold()
                Text(self.flightNumber.count > 0 ? self.flightNumber : "").frame(maxWidth: .infinity, alignment: .trailing).bold()
            }.padding(.bottom, 10)

            HStack {
                Text(self.plannedArrivalTime.count > 0 ? "**Geplant:**\n\(self.plannedArrivalTime)" : "").frame(maxWidth: .infinity, alignment: .leading)

                Text(self.expectedArrivalTime.count > 0 ? "**Erwartet:**\n\(self.expectedArrivalTime)" : "").frame(maxWidth: .infinity, alignment: .center)

                Text(self.status.count > 0 ? "**Status:\n\(Text(self.status).foregroundColor(setStatusColor(status: self.status)))**" : "").frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }

    // TODO: Change colors for more consistent output
    private func setStatusColor(status: String) -> Color {
        switch status {
            // Successes
            case "gelandet": return Color(red: 89/255, green: 153/255, blue: 49/255)
            case "Gepäck": return Color(red: 0/255, green: 135/255, blue: 75/255)
            case "beendet": return Color(red: 0/255, green: 102/255, blue: 68/255)

            // neutral
            case "geplant": return Color.black
            case "gestartet": return Color(red: 0/255, green: 82/255, blue: 204/255)
            case "im Anflug": return Color(red: 7/255, green: 71/255, blue: 166/255)

            // warnings
            case "boarding": return Color(red: 255/255, green: 153/255, blue: 31/255)
            case "Check-In": return Color(red: 0/255, green: 135/255, blue: 90/255)

            // Errors and failures
            case "verspätet": return Color(red: 222/255, green: 53/255, blue: 11/255)
            case "annulliert": return Color(red: 191/255, green: 38/255, blue: 0/255)
            default:
                return Color(UIColor.systemBackground)
        }
    }
}

struct FlightView_Previews: PreviewProvider {
    static var previews: some View {
        FlightInfoView(airline: "Lufthansa", departureCity: "Berlin", flightNumber: "EN 8309 (E320)", status: "gelandet", plannedArrivalTime: "15:00", expectedArrivalTime: "15:40", terminal: "T2")
        FlightInfoView(airline: "Lufthansa", departureCity: "Berlin", flightNumber: "EN 8309 (E320)", status: "Gepäck", plannedArrivalTime: "15:00", expectedArrivalTime: "15:40", terminal: "T2")
        FlightInfoView(airline: "Lufthansa", departureCity: "Berlin", flightNumber: "EN 8309 (E320)", status: "beendet", plannedArrivalTime: "15:00", expectedArrivalTime: "15:40", terminal: "T2")
        FlightInfoView(airline: "Lufthansa", departureCity: "Berlin", flightNumber: "EN 8309 (E320)", status: "geplant", plannedArrivalTime: "15:00", expectedArrivalTime: "15:40", terminal: "T2")
        FlightInfoView(airline: "Lufthansa", departureCity: "Berlin", flightNumber: "EN 8309 (E320)", status: "gestartet", plannedArrivalTime: "15:00", expectedArrivalTime: "15:40", terminal: "T2")
        FlightInfoView(airline: "Lufthansa", departureCity: "Berlin", flightNumber: "EN 8309 (E320)", status: "im Anflug", plannedArrivalTime: "15:00", expectedArrivalTime: "15:40", terminal: "T2")
        FlightInfoView(airline: "Lufthansa", departureCity: "Berlin", flightNumber: "EN 8309 (E320)", status: "boarding", plannedArrivalTime: "15:00", expectedArrivalTime: "15:40", terminal: "T2")
        FlightInfoView(airline: "Lufthansa", departureCity: "Berlin", flightNumber: "EN 8309 (E320)", status: "Check-In", plannedArrivalTime: "15:00", expectedArrivalTime: "15:40", terminal: "T2")
        FlightInfoView(airline: "Lufthansa", departureCity: "Berlin", flightNumber: "EN 8309 (E320)", status: "verspätet", plannedArrivalTime: "15:00", expectedArrivalTime: "15:40", terminal: "T2")
        FlightInfoView(airline: "Lufthansa", departureCity: "Berlin", flightNumber: "EN 8309 (E320)", status: "annulliert", plannedArrivalTime: "15:00", expectedArrivalTime: "15:40", terminal: "T2")

//        FlightInfoView(airline: "", departureCity: "", flightNumber: "", status: "", plannedArrivalTime: "", expectedArrivalTime: "", terminal: "")
    }
}
