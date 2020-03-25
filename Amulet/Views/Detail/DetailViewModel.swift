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

	init(charms: [Charm]) { self.charms = charms }

	@Published
	var charms: [Charm]

}
