//
//  ContentView.swift
//  AirportOverview
//
//  Created by Osama Mehdi on 25.07.23.
//

import CoreData
import SwiftSoup
import SwiftUI

struct ContentView: View {
    @ObservedObject var airportDataModel: AirportData = .init()
    @State var airportData: [[String: String]] = [[:]]

    var body: some View {
        ZStack {
            if airportDataModel.isFetching {
                ProgressView("Loading Airport Data")
            } else {
                List {
                    ForEach(airportData, id: \.self) { flightData in
                        if flightData.isEmpty {
                            FlightView(airline: "", departureCity: "", flightNumber: "", status: "", plannedArrivalTime: "", expectedArrivalTime: "", terminal: "")
                            
                        } else {
                            FlightView(airline: flightData["airline"]!,
                                       departureCity: flightData["departureCity"]!,
                                       flightNumber: flightData["number"]!,
                                       status: flightData["status"]!,
                                       plannedArrivalTime: flightData["plannedArrivalTime"]!,
                                       expectedArrivalTime: flightData["expectedArrivalTime"]!,
                                       terminal: flightData["area"]!)
                        }
                    }
                }
            }
        }.task {
            airportData = await airportDataModel.parseData()
            airportDataModel.isFetching = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
