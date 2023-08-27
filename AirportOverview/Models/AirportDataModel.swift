//
//  AirportDataModel.swift
//  AirportOverview
//
//  Created by Osama Mehdi on 31.07.23.
//

import Foundation

enum Terminals: String, CaseIterable, Identifiable {
    var id: String { UUID().uuidString }
    case allFlights = "All flights"
    case terminal1 = "T1"
    case terminal2 = "T2"
    case terminal1A = "T1A"
    case terminal1B = "T1B"
    case terminal1C = "T1C"
    case terminal1D = "T1D"
    case terminal1E = "T1E"
    case terminal1F = "T1F"
}

enum FlightType: String {
    case Ankünfte
    case Abflüge
}

struct AirportData {
    var arrivalData: [FlightData]
    var departureData: [FlightData]

    let availableArrivalTerminals: [Terminals]
    let availableDepartureTerminals: [Terminals]

    init(arrivalData: [FlightData] = [], departureData: [FlightData] = []) {
        self.arrivalData = arrivalData
        self.departureData = departureData
        self.availableArrivalTerminals = [.allFlights, .terminal2, .terminal1A, .terminal1B, .terminal1C, .terminal1D, .terminal1E, .terminal1F]
        self.availableDepartureTerminals = [.allFlights, .terminal1, .terminal2]
    }

    mutating func setAirportData(arrivalData: [FlightData], departureData: [FlightData]) {
        self.arrivalData = arrivalData
        self.departureData = departureData
    }
}
