//
//  SharedDate.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-24.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import Foundation

final class SharedDate {

	public static let shared = SharedDate()

	private init() { }

	var currentDate: () -> Date = {
		Date(timeIntervalSinceNow: 0)
	}

	var isDateCurrentDate: (Date) -> Bool = { date in
		Calendar.current.isDateInToday(date)
	}

}

//TODO: Formatter
