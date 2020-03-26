//
//  SharedDate.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-24.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import Foundation

final class GlobalDate {

	public static let shared = GlobalDate()

	let currentDate: Date

	private init() {
		self.currentDate = Date()
	}

}
var dateFormatted: (Date) -> String = { date in
	let dateFormatter = DateFormatter()
	dateFormatter.dateStyle = .medium
	dateFormatter.timeStyle = .none
	return dateFormatter.string(from: date)
}

var isDateCurrentDate: (Date) -> Bool = { date in
	Calendar.current.isDateInToday(date)
}

var validatedDate: (String) -> Date? = { string in
	let dateFormatter = ISO8601DateFormatter()
	return dateFormatter.date(from: string)
}
