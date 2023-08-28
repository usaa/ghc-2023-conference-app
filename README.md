# conference

## Audience

This project is intended for use by 2023 Grace Hopper Conference Attendees attending SESS - 1434 - Building a robust mobile app: From concept to app. 

## Pre-requisties

Skills
- [ ] Xcode
- [ ] Swift
- [ ] Git 

Attendess are welcomed to participate in the session if they just choose to listen and follow along via presentation.

Optional 
- [ ] Macbook
- [ ] Minimum Xcode 14 installed


## Getting started

During the lab we will build an app for conference attendees. The app will let attendess view conference sessions, register for sessions, and view their schedule. 

## Steps

The lab is organized into steps. We will be building the app in steps. Steps are provided via tags on the project. If ever attendees get lost or have trouble keeping up, you can clone a particular tag to keep up with the session.

```
git clone -b step-1 https://github.com/usaa/ghc-2023-conference-app.git
```

- [Step 1 - Create Initial Conference Schedule View](https://github.com/usaa/ghc-2023-conference-app/tree/step-1)
- [Step 2 - MVVM - Create Conference Schedule Model and View Model](https://github.com/usaa/ghc-2023-conference-app/tree/step-2)
- [Step 3 - MVVM - Create My Schedule View and View Model ](https://github.com/usaa/ghc-2023-conference-app/tree/step-3)
- [Step 4 - MVVM - Expand on our Conference Schedule Model](https://github.com/usaa/ghc-2023-conference-app/tree/step-4)
- [Step 5 - Add Tab View, Add indicator for registration, Mock registration service](https://github.com/usaa/ghc-2023-conference-app/tree/step-5)
- [Step 6 - Expand on the mocked service](https://github.com/usaa/ghc-2023-conference-app/tree/step-6)
- [Step 7 - Repository - Create a repository which manages data for both views](https://github.com/usaa/ghc-2023-conference-app/tree/step-7)
- [Step 8 - Reactive Programming - Conference Schedule View observation on Conference Schedule Result](https://github.com/usaa/ghc-2023-conference-app/tree/step-8)
- [Step 9 - Reactive Programming - My Schedule View observation on Conference Schedule Result](https://github.com/usaa/ghc-2023-conference-app/tree/step-9)
- [Step 10 - Reactive Programming - Updates to Conference Schedule](https://github.com/usaa/ghc-2023-conference-app/tree/step-10)
- [Step 11 - Caching](https://github.com/usaa/ghc-2023-conference-app/tree/step-11)
- [Step 12 - Performance in Caching](https://github.com/usaa/ghc-2023-conference-app/tree/step-12)
- [Step 13 - Dependency Injection](https://github.com/usaa/ghc-2023-conference-app/tree/step-13)
- [Step 14 - Dependency Injection - Unit Tests](https://github.com/usaa/ghc-2023-conference-app/tree/step-14)
- [Step 15 - SwiftUI - UI Enhancements to the App](https://github.com/usaa/ghc-2023-conference-app/tree/step-15)

## Code Snippets for a speedier Demo

### Step 5

Modify isRegistered Bool
```swift
func register(session: Session) -> ConferenceSchedule {
    if let s = self.conferenceSchedule.sessions?.firstIndex(of: session) {
        var registerSession = session
        registerSession.isRegistered = true
        self.conferenceSchedule.sessions?[s] = registerSession
    }
    return self.conferenceSchedule
}

func unregister(session: Session) -> ConferenceSchedule {
    if let s = self.conferenceSchedule.sessions?.firstIndex(of: session) {
        var registerSession = session
        registerSession.isRegistered = false
        self.conferenceSchedule.sessions?[s] = registerSession
    }
    return self.conferenceSchedule
}
```

### Step 6

Persist `conferenceSchedule` in register and unregister functions.
```swift
guard let encodedData = try? JSONEncoder().encode(self.conferenceSchedule) else {
    return self.conferenceSchedule
}
UserDefaults.standard.set(encodedData, forKey: "ServiceConferenceSchedule")
return self.conferenceSchedule
```

Access the persisted data from `getSchedule`
```swift
func getSchedule() -> ConferenceSchedule {
    if let storedData = UserDefaults.standard.data(forKey: "ServiceConferenceSchedule"),
        let data = try? JSONDecoder().decode(ConferenceSchedule.self, from: storedData) {
        self.conferenceSchedule = data
        return data
    }
    return self.conferenceSchedule
}
```

### Step 8

ConferenceScheduleResult enum
```swift
enum ConferenceScheduleResult {
    case uninitialized
    case success(data: ConferenceSchedule)
    
    var data: ConferenceSchedule {
        switch self {
        case .uninitialized:
            return ConferenceSchedule(userID: 98765, sessions: [])
        case let .success(data):
            return data
        }
    }
}
```

Set up view model to subscribe on data
```swift
let result = self.repository.data.map { $0 }
result
    .receive(on: DispatchQueue.main)
    .sink {
        self.result = $0
    }
    .store(in: &cancellables)
```

### Step 9

Set up view model to subscribe on data
```swift
let data = repository.data.map { $0.data }
data
    .receive(on: DispatchQueue.main)
    .sink {
        self.result = .success(data: $0)
    }
    .store(in: &cancellables)
```


### Step 11

Caching
```swift
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

    public init(minutesToLive: Double = 5.0) {
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

```

### Step 12

Refresh function
```swift
public func refresh() {
    //let loadingResult: ConferenceScheduleResult = .loading
    //store.put(loadingResult)
    Task {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        let result = service.getSchedule()
        store.put(result)
    }
}
```

### Step 13

DataStore protocol

```swift
protocol DataStore {
    var data: AnyPublisher<ConferenceScheduleResult, Never> { get }
    var currentValue: ConferenceScheduleResult { get }
    var minutesToLive: Double { get }
    var expired: Bool { get }
    var dateCached: Date? { get }
    func put(_ result: ConferenceScheduleResult)
    func clear()
}
```

Dependency Initialization
```swift
let service = ConferenceScheduleService()
let store = ConferenceScheduleDataStore(minutesToLive: 0.5)
let conferenceScheduleRepository: ConferenceScheduleRepository
let conferenceScheduleViewModel: ConferenceScheduleViewModel
let myScheduleViewModel: MyScheduleViewModel
    
init() {
    self.conferenceScheduleRepository = ConferenceScheduleRepository(service: self.service, store: self.store)
    self.conferenceScheduleViewModel = ConferenceScheduleViewModel(repository: self.conferenceScheduleRepository)
    self.myScheduleViewModel = MyScheduleViewModel(repository: self.conferenceScheduleRepository)
}
```

## Authors and acknowledgment
Ashley Pham and Jennifer Kartchner

## License
This project is Open Source software released under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0.html)

USAA reserves the right to remove the contents of our github at any time, without notice.
