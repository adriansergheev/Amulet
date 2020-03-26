//
//  Charm.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-25.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import Foundation

struct CharmResponse: Codable {
	let charm: [Charm]
}

struct Charm: Codable, Identifiable {
	let id: Int
	let text: String

	private let dateAsString: String?

	init(id: Int, text: String, dateAsString: String? = nil) {
		self.id = id
		self.text = text
		self.dateAsString = dateAsString
	}

	enum CodingKeys: String, CodingKey {
		case id
		case text
		case dateAsString = "date"
	}

	var date: Date? {
		if let string = self.dateAsString {
			return validatedDate(string)
		}
		return nil
	}

	// crashes as of xcode 11.4 iOS 13.4 when using shared closures from GlobalDate.shared
	var dateFormatted: String? {
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

	//	var dateFormatted: String? {
	//		if let validated = self.date {
	//			return GlobalDate.shared.dateFormatted(validated)
	//		}
	//		return nil
	//	}
}
