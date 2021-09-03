//
//  Alarm.swift
//  Refresh
//
//  Created by Jose Torres-Vargas on 7/17/21.
//

import Foundation

class Alarm {
    var alertDate: Date
    var label: String
    var animeId: Int
    var active: Bool
    var alarmId: Int?
    var airingDate: Date?
    
    init(on date: Date, for label: String, with id: Int, isActive: Bool) {
        self.alertDate = date
        self.label = label
        self.animeId = id
        self.active = isActive
    }
    
    private func setAlarmFor(date: Date) {
        print("Setting alarm for \(date)")
    }
    
    static func airingDay(seconds until: Double) -> (Date) {
        let timeZoneOffset = TimeZone.current.secondsFromGMT()
        let timeZoneEpochOffset = (until + Double(timeZoneOffset))
        let airingDate = Date(timeIntervalSince1970: timeZoneEpochOffset)
        //print("Airing Date: \(airingDate)")
        return airingDate
    }
}
