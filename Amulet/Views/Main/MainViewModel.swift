//
//  MainViewModel.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-22.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import Foundation
import Combine
//import CombineExt

final class MainViewModel: ObservableObject {

	@Published private(set) var state = State.idle

	private let input = PassthroughSubject<Event, Never>()

	private var bag = Set<AnyCancellable>()

	init() {
		Publishers
			.system(initial: state,
					reduce: Self.reduce,
					scheduler: RunLoop.main,
					feedbacks: [
						Self.load(),
						Self.userInput(input: input.eraseToAnyPublisher())

			])
			//		.print("👽 State machine:")
			.assign(to: \.state, on: self)
			.store(in: &bag)
	}

	deinit {
		bag.removeAll()
	}

	func send(event: Event) {
		input.send(event)
	}

}

extension MainViewModel {
	enum State {
		case idle // do nothing
		case loading // spinner
		case loaded([Charm], _ todays: Charm?) // do nothing
		case error(Error) // show "not loaded" text or random charm
	}

	enum Event {
		case onAppear
		case onCharmsLoaded([Charm], _ todays: Charm?)
		case onLoadFailed(Error)
	}
}

extension MainViewModel {
	static func reduce(_ state: State, _ event: Event) -> State {
		switch state {
		case .idle:
			switch event {
			case .onAppear:
				return .loading
			default:
				return state
			}
		case .loading:
			switch event {
			case .onLoadFailed(let error):
				return .error(error)
			case .onCharmsLoaded(let charms, let todaysCharm):
				return .loaded(charms, todaysCharm)
			default:
				return state
			}
		case .loaded:
			return state
		case .error:
			return state
		}
	}

	static func load() -> Feedback<State, Event> {

		Feedback { (state: State) -> AnyPublisher<Event, Never> in

			guard case .loading = state else {
				return Empty().eraseToAnyPublisher()
			}

			return AmuletAPI
				.getItems()
				.map { Event.onCharmsLoaded($0.charm, getTodaysCharm($0.charm)) }
				.catch { Just(Event.onLoadFailed($0))}
				.receive(on: DispatchQueue.main)
				.eraseToAnyPublisher()
		}
	}

	private static var getTodaysCharm: ([Charm]) -> Charm = { charms in
		(charms.first(where: {
			if let date = $0.date {
				return Calendar.current.isDateInToday(date)
			} else {
				return false
			}
		}) ?? charms.randomElement()! // fall back to random charm
		)
	}

	static func userInput(input: AnyPublisher<Event, Never>)
		-> Feedback<State, Event> { Feedback { _ in input }
	}
}
