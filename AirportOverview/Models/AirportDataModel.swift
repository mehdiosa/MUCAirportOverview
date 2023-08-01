//
//  AirportDataModel.swift
//  AirportOverview
//
//  Created by Osama Mehdi on 31.07.23.
//

import Foundation

struct AirportData {
    var arrivalData: [FlightData]
    var departureData: [FlightData]

    init(arrivalData: [FlightData] = [], departureData: [FlightData] = []) {
        self.arrivalData = arrivalData
        self.departureData = departureData
    }

    mutating func setAirportData(arrivalData: [FlightData], departureData: [FlightData]) {
        self.arrivalData = arrivalData
        self.departureData = departureData
    }
}
