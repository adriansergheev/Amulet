//
//  Feedback.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-27.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

/*
https://github.com/sergdort/CombineFeedback
*/

import Foundation
import Combine

struct Feedback<State, Event> {
    let run: (AnyPublisher<State, Never>) -> AnyPublisher<Event, Never>
}

extension Feedback {
    init<Effect: Publisher>(effects: @escaping (State) -> Effect) where Effect.Output == Event, Effect.Failure == Never {
        self.run = { state -> AnyPublisher<Event, Never> in
            state
                .map { effects($0) }
                .switchToLatest()
                .eraseToAnyPublisher()
        }
    }
}
