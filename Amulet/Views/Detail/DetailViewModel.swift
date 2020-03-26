//
//  DetailViewModel.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-25.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {

	@Published
	var charms: [Charm]

	init(charms: [Charm]) {
		//		print("Received: \(charms), date: \(GlobalDate.shared.currentDate)")
		self.charms = charms
		//			.filter { charm in
		//				let current = GlobalDate.shared.currentDate
		//				return current > charm.date ?? current
		//		}
		//		print("Init: \(self.charms), date: \(GlobalDate.shared.currentDate)")
	}
}
