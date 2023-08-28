//
//  ConferenceScheduleRepository.swift
//  Conference
//
//  Created by Pham, Ashley on 8/29/23.
//

import Foundation
import Combine

class ConferenceScheduleRepository {
    
    var data: AnyPublisher<ConferenceScheduleResult, Never> = CurrentValueSubject(ConferenceScheduleResult.uninitialized).eraseToAnyPublisher()
    
    private let service: ConferenceScheduleService = ConferenceScheduleService()
    private let store: ConferenceScheduleDataStore = ConferenceScheduleDataStore()
    
    init() {
        data = store.data.handleEvents(receiveSubscription: { [weak self] _ in
            self?.getSessions()
        }).eraseToAnyPublisher()
    }
    
    func getSessions() {
        let result = self.service.getSchedule()
        store.put(result)
    }
    
    func add(session: Session) {
        //update the data
        //write the updated data to the data store
        self.service.register(session:session)
    }
    
    func remove(session: Session) {
        //update the data
        //write the updated data to the data store
        self.service.unregister(session:session)
    }
}
