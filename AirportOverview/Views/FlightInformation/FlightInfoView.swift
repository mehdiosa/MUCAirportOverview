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
        // TODO: Think of something (maybe something else than a small message) to show the user that there was an error when loading the data.
        VStack {
            HStack {
                Text(self.departureCity.count > 0 ? self.departureCity : "").frame(maxWidth: .infinity, alignment: .leading).bold()
                Text(self.terminal.count > 0 ? self.terminal : "").frame(maxWidth: .infinity, alignment: .center).bold()
                Text(self.flightNumber.count > 0 ? self.flightNumber : "").frame(maxWidth: .infinity, alignment: .trailing).bold()
            }.padding(.bottom, 10)

            HStack {
                Text(self.plannedArrivalTime.count > 0 ? "**Geplant:**\n\(self.plannedArrivalTime)" : "").frame(maxWidth: .infinity, alignment: .leading)

                Text(self.expectedArrivalTime.count > 0 ? "**Erwartet:**\n\(self.expectedArrivalTime)" : "").frame(maxWidth: .infinity, alignment: .center)

                Text(self.status.count > 0 ? "**Status:**\n\(Text(self.status).foregroundColor(setStatusColor(status: self.status)))" : "").frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }

    // TODO: CHANGE COLORS ACCORDING TO COLOR THEORY MAYBE
    private func setStatusColor(status: String) -> Color {
        switch status {
        case "gestartet": return Color(red: 53/255, green: 113/255, blue: 170/255) // Blue
        case "verspätet": return Color(red: 219/255, green: 68/255, blue: 57/255) // Orange or Red
        case "im Anflug": return Color(red: 104/255, green: 152/255, blue: 202/255) // Light blue
        case "gelandet": return Color.blue // darker blue?
        case "Gepäck": return Color(red: 98/255, green: 159/255, blue: 173/255) // yellow
        case "beendet": return Color.green
        case "annuliert": return Color.red
        case "boarding": return Color.orange
        case "Check-In": return Color.green
        case "geplant": return Color.blue
        default:
            return Color(UIColor.systemBackground)
        }
    }
}

struct FlightView_Previews: PreviewProvider {
    static var previews: some View {
        FlightInfoView(airline: "Lufthansa", departureCity: "Berlin", flightNumber: "EN 8309 (E320)", status: "beendet", plannedArrivalTime: "15:00", expectedArrivalTime: "15:40", terminal: "T2")

//        FlightInfoView(airline: "", departureCity: "", flightNumber: "", status: "", plannedArrivalTime: "", expectedArrivalTime: "", terminal: "")
    }
}
