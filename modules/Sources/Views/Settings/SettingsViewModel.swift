//
//  SettingsViewModel.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-29.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import Foundation
import Shared

final class SettingsViewModel: ObservableObject {

	@Published var settings: AppSettings

	init(_ appSettings: AppSettings) {
		self.settings = appSettings
	}

	func onAppear() {
		settings.permissions { [weak self] granted in
			guard let `self` = self else { return }
			DispatchQueue.main.async {
				self.settings.notificationsEnabled = granted
			}
		}
	}
}
