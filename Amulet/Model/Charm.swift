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

	let date: String?

	init(id: Int, text: String, date: String? = nil) {
		self.id = id
		self.text = text
		self.date = date
	}
}
