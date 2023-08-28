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

    init() {
    }

    func put(_ result: ConferenceScheduleResult) {
        currentValue = result
    }

    func clear() {
        currentValue = ConferenceScheduleResult.uninitialized
    }
}
