//
//  ConferenceScheduleDataStore.swift
//  Conference
//
//  Created by Pham, Ashley on 9/1/23.
//

import Foundation
import Combine


public class ConferenceScheduleDataStore {

    @Published private(set) var currentValue: ConferenceScheduleResult = ConferenceScheduleResult.uninitialized
    lazy var data: AnyPublisher<ConferenceScheduleResult, Never> = $currentValue.eraseToAnyPublisher()
    var minutesToLive: Double
    private var secondsToLive: TimeInterval {
        return minutesToLive * 60
    }
    var expired: Bool { return dataAge + secondsToLive < currentTime() }

    var dateCached: Date? {
        if dataAge == 0 {
            return nil
        } else {
            return Date(timeIntervalSince1970: dataAge)
        }
    }
    var dataAge: TimeInterval = 0
    /// Returns the current time in seconds, used to determine lifespan of data
    var currentTime: () -> TimeInterval = { Date().timeIntervalSince1970 }

    public init(minutesToLive: Double = 0.08) {
        self.minutesToLive = minutesToLive
        if let storedTime = UserDefaults.standard.data(forKey: "ConferenceScheduleStorageTime"),
           let storageTime = try? JSONDecoder().decode(StorageTime.self, from: storedTime) {
            dataAge = storageTime.storageTimeInterval
            if let storedData = UserDefaults.standard.data(forKey: "ConferenceSchedule"),
               let cache = try? JSONDecoder().decode(ConferenceSchedule.self, from: storedData) {
                if expired {
                    clear()
                } else {
                    put(.success(data:cache))
                }
            }
        }
    }

    func put(_ result: ConferenceScheduleResult) {
        switch(result) {
        case .uninitialized:
            dataAge = 0
        default:
            dataAge = currentTime()
        }
        self.persist(schedule: result)
        currentValue = result
    }

    func clear() {
        dataAge = 0
        currentValue = ConferenceScheduleResult.uninitialized
    }
    
    private func persist(schedule: ConferenceScheduleResult) {
        //persist data
        let data = schedule.data
        guard let encodedData = try? JSONEncoder().encode(data) else { return }
        UserDefaults.standard.set(encodedData, forKey: "ConferenceSchedule")
        //persist time of data
        guard let encodedStorageTime = try? JSONEncoder().encode(StorageTime(timeInterval: currentTime())) else { return }
        UserDefaults.standard.set(encodedStorageTime, forKey: "ConferenceScheduleStorageTime")
    }
}

class StorageTime: Codable {
    private var storageTime: Double
    var storageTimeInterval: TimeInterval {
        return storageTime / 1000
    }
    init(timeInterval: TimeInterval) {
        self.storageTime = timeInterval * 1000
    }
}
