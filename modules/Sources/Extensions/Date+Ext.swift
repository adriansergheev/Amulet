import Foundation

public extension Date {
	var isPastDate: Bool {
		return self < Date()
	}
}
