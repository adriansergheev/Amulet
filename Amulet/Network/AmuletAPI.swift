//
//  AmuletAPI.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-25.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import Foundation
import Combine

enum NetworkEnvironment {
	case mock
	case prod
}

enum AmuletAPI {
	enum AmuletError: LocalizedError, Identifiable {

		case addressUnreachable(URL)
		case invalidResponse
		case invalidMock(Error?)

		var errorDescription: String? {
			switch self {
			case .invalidResponse:
				return "The server responded with garbage."
			case .addressUnreachable(let url):
				return "\(url.absoluteString) is unreachable."
			case .invalidMock:
				return "Can't load the mock json"
			}
		}

		var id: String { localizedDescription }
	}

	typealias Response = AnyPublisher<CharmResponse, AmuletError>

	static func getItems(environment: NetworkEnvironment = Current.networkEnvironment) -> Response {

		let url = AmuletBaseURL.url.appendingPathComponent(".json/")
		let apiReqQueue = DispatchQueue(label: "AmuletAPI", qos: .default, attributes: .concurrent)

		let decoder = JSONDecoder()

		let errorResponse: (Error?) -> AnyPublisher<CharmResponse, AmuletError> = { error in
			AnyPublisher<CharmResponse, AmuletError>.create { subscriber in
				subscriber.send(completion: .failure(.invalidMock(error)))
				return AnyCancellable {}
			}
		}

		switch environment {
		case .mock:
			if let filepath = Bundle.main.path(forResource: "AmuletMock", ofType: "json") {
				do {

					let url = URL(fileURLWithPath: filepath)
					let data = try Data(contentsOf: url)

					#if DEBUG
					let text = try decoder.decode(CharmResponse.self, from: data)
					print(text)
					#endif

					let parsed = try decoder.decode(CharmResponse.self, from: data)
					return AnyPublisher<CharmResponse, AmuletError>.create { subscriber in
						subscriber.send(parsed)
						subscriber.send(completion: .finished)
						return AnyCancellable {}
					}

				} catch let error {

					#if DEBUG
					print("Could not be loaded: \(error)")
					#endif

					return errorResponse(error)
				}
			} else {
				return errorResponse(nil)
			}
		case .prod:
			return URLSession
				.shared
				.dataTaskPublisher(for: url)
				.subscribe(on: apiReqQueue)
				.retry(3)
				.timeout(.seconds(10), scheduler: apiReqQueue)
				.map(\.data)
				.decode(type: CharmResponse.self, decoder: decoder)
				.mapError { error -> AmuletError in
					switch error {
					case is URLError:
						return AmuletError.addressUnreachable(url)
					default:
						return AmuletError.invalidResponse
					}
			}
			.eraseToAnyPublisher()
		}
	}
}
