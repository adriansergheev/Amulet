//
//  Charm.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-25.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import Foundation

public struct CharmResponse: Codable {
	public let charm: [Charm]
}

public struct Charm: Codable, Identifiable, Equatable {
	public let id: Int
	public let text: String

	private let dateAsString: String?

	public init(id: Int, text: String, dateAsString: String? = nil) {
		self.id = id
		self.text = text
		self.dateAsString = dateAsString
	}

	enum CodingKeys: String, CodingKey {
		case id
		case text
		case dateAsString = "date"
	}

	public var date: Date? {
		if let string = self.dateAsString {
			let dateFormatter = ISO8601DateFormatter()
			return dateFormatter.date(from: string)
		}
		return nil
	}

	// crashes as of xcode 11.4 iOS 13.4 when invoking Date() in external functions
	public var dateFormatted: String? {
		if 	let string = self.dateAsString {

			let dateFormatter = ISO8601DateFormatter()

			if let validated = dateFormatter.date(from: string) {
				let dateFormatter = DateFormatter()
				dateFormatter.dateStyle = .medium
				dateFormatter.timeStyle = .none
				return dateFormatter.string(from: validated)
			}
		}
		return nil
	}
}
