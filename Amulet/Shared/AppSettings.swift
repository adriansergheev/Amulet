//
//  AppState.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-27.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import Foundation
import Combine
import NotificationCenter

enum NotificationTime: String, CaseIterable {

	case morning
	case noon
	case evening

	var asNumber: Int {
		switch self {
		case .morning:
			return 8
		case .noon:
			return 12
		case .evening:
			return 18
		}
	}
}

final class AppSettings: ObservableObject {

	@Published var notificationsEnabled: Bool = false

	@Published var notificationReceivingTimeIndex: Int = 0 {
		didSet {
			notificationReceivingTime = NotificationTime
				.allCases[self.notificationReceivingTimeIndex]
		}
	}

	@Published private(set) var notificationReceivingTime: NotificationTime = .morning {
		didSet {
			permissions { [weak self] granted in
				guard let `self` = self else { return }

				if granted {
					self.enableLocalNotifications(self.notificationReceivingTime)
				}
			}
		}
	}

	init() {

	}

	// MARK: - local notifications

	func permissions(completion: @escaping (Bool) -> Void) {
		let center = UNUserNotificationCenter.current()
		center.requestAuthorization(options: [.badge, .sound, .alert]) { granted, _ in
			completion(granted)
		}
	}

	private var enableLocalNotifications: (_ time: NotificationTime) -> Void = { time in
		#if DEBUG
		//every 30 sec
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1 * 30, repeats: false)
		#else
		let dateComponents = DateComponents(hour: time.asNumber)
		let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
		#endif

		let content = UNMutableNotificationContent()

		var text: [String] = [
			"Today's charm",
			"Take a minute for yourself.",
			"Cheer yourself up with a charm."
		]

		content.title = text.randomElement() ?? ""
		content.sound = UNNotificationSound.default

		let identifier = UUID().uuidString
		let request = UNNotificationRequest(identifier: identifier,
											content: content,
											trigger: trigger)

		UNUserNotificationCenter.current().add(request) { error in
			if let error = error { }
		}

	}

}
