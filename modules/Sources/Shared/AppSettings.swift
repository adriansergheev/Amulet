import Foundation
import Combine
import NotificationCenter

public enum NotificationTime: String, CaseIterable {
	
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

final public class AppSettings: ObservableObject {
	
	@Published public var notificationsEnabled: Bool = false
	
	@Published public var notificationReceivingTimeIndex: Int = 0 {
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
	
	public init() {
		
	}
	
	// MARK: - Local notifications
	
	public func permissions(completion: @escaping (Bool) -> Void) {
		let notificationCenter = UNUserNotificationCenter.current()
		notificationCenter.requestAuthorization(options: [.badge, .sound, .alert]) { granted, _ in
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
		
		let uniqueIdentifier = UIDevice.current.identifierForVendor?.uuidString ?? ""
		
		UNUserNotificationCenter
			.current()
			.removePendingNotificationRequests(withIdentifiers: [uniqueIdentifier])
		
		let request = UNNotificationRequest(identifier: uniqueIdentifier,
																				content: content,
																				trigger: trigger)
		
		UNUserNotificationCenter.current().add(request) { error in
			if let error = error {
#if DEBUG
				print("UNUserNotificationCenter error: \(error)")
#endif
			}
		}
	}
}
