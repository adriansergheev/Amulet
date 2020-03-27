//
//  SharedDate.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-24.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import Foundation
import Combine
import CombineExt

final class GlobalDate {

	private init() { }

	static var dateFormatted: (Date) -> String = { date in
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .none
		return dateFormatter.string(from: date)
	}

	static var isDateCurrentDate: (Date) -> Bool = { date in
		Calendar.current.isDateInToday(date)
	}

	static var validatedDate: (String) -> Date? = { string in
		let dateFormatter = ISO8601DateFormatter()
		return dateFormatter.date(from: string)
	}

}
