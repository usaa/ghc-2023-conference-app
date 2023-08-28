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
            if self?.store.expired == true {
                self?.refresh()
            }
        }).eraseToAnyPublisher()
    }
    
    public func refresh() {
        let loadingResult: ConferenceScheduleResult = .loading
        store.put(loadingResult)
        Task {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            let result = await service.getSchedule()
            store.put(result)
        }
    }
    
    func getSessions() {
        if store.expired {
            self.refresh()
        } else {
            self.store.put(self.store.currentValue)
        }
    }
    
    func add(session: Session) {
        //update the data
        //write the updated data to the data store
        let result = self.service.register(session:session)
        store.put(result)
    }
    
    func remove(session: Session) {
        //update the data
        //write the updated data to the data store
        let result = self.service.unregister(session:session)
        store.put(result)
    }
}
