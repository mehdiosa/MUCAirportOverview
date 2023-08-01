//
//  MucAirportData.swift
//  AirportOverview
//
//  Created by Osama Mehdi on 31.07.23.
//

import Foundation
import SwiftSoup

struct MucAirportData {
    // TODO: Loading Arrivals and Departure Data can either be done by passing a type ("arrivals" or "departures") that is passed to the URL OR loading all data at once and then adding a key:value pair to the dictionary which can then be used to determine whether the flight is a arrriving or departing flight -> Best idea is the one where the data is only loaded when the tab is shown, however, this could cause delays as in everytime the tab is changed, data must first be loaded (which takes a few seconds depending on the internet connection) and only then can be shown -> Better if this can be run either in the background or be done directly when opening/reloading the app
    
    var data: AirportData
    
    init(data: AirportData = AirportData()) {
        self.data = data
    }
    
    func loadData(_ type: String) async -> [FlightData] {
        let airportHTML = Task { await self.getData(type: type,
                                                    // TODO: Add slider for how many hours back the user wants to go
                                                    current: formatDate(Calendar.current.date(byAdding: .hour, value: -2, to: Date.now) ?? Date.now),
                                                    // TODO: THIS NEEDS TO BE SET TO DAY INSTEAD OF HOUR
                                                    until: formatDate(Calendar.current.date(byAdding: .day, value: 1, to: Date.now) ?? Date.now)) }
        var flightData: [FlightData] = []
    
        do {
            // Get Table Data
            guard let elements: Elements = try? await SwiftSoup.parse(airportHTML.value).getElementsByClass("fp-flights-table-large") else {
                return []
            }
        
            // Get data of flights
            let flightItems = try elements.array()[0].getElementsByClass("fp-flight-item")
        
            // parse data and create data type which carry all information of each flight
            for flights in flightItems {
                let airline = try flights.getElementsByClass("fp-flight-airline")[0].text()
                let departureCity = try flights.getElementsByClass("fp-flight-airport")[0].text()
                let number = try flights.getElementsByClass("fp-flight-number")[0].text()
                let status = try flights.getElementsByClass("fp-flight-status")[0].text()
                // Departure time
                let time_other = try flights.getElementsByClass("fp-flight-time-other")[0].text()
            
                // Time flight is planned and expected at munich airport
                let times_muc = try flights.getElementsByClass("fp-flight-time-muc")[0].text().components(separatedBy: "|")
            
                let area = try flights.getElementsByClass("fp-flight-area")[0].text()
            
                // Append flight data array with data type
                flightData.append(FlightData(airline: airline,
                                             departureCity: departureCity,
                                             number: number, status: status,
                                             timeOther: time_other,
                                             plannedArrivalTime: times_muc[0].trimmingCharacters(in: .whitespaces),
                                             expectedArrivalTime: times_muc[1].trimmingCharacters(in: .whitespaces),
                                             area: area)
                )
            }
            
            return flightData
        } catch let Exception.Error(type, message) {
            print(type)
            print(message)
        } catch {
            print("error")
        }
        return []
    }

    func getData(type: String, current: String, until: String) async -> String {
        guard let url = URL(string: "https://www.munich-airport.de/flightsearch/" + type + "?from=" + current + "&per_page=1000&min_date=" + current + "&max_date=" + until) else {
            return "Invalid URL"
        }
    
        let _ = print(url)
    
        do {
            let contents = try String(contentsOf: url)
            return contents
        } catch {
            // contents could not be loaded
            print("Could not load contents")
        }
        return "Error"
    }
    
    private func formatDate(_ timestamp: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter.string(from: timestamp)
    }
}
