//
//  DetailViewModel.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-25.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import Foundation
import Combine
import Model

final class DetailViewModel: ObservableObject {

	@Published
	var charms: [Charm]

	init(charms: [Charm]) {

		self.charms = charms
			.filter { ($0.date?.isPastDate) ?? false }
	}
}
