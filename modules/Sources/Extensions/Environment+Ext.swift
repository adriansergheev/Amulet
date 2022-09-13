import Foundation
import SwiftUI

public struct ModalModeSettings: EnvironmentKey {
	public static let defaultValue = Binding<Bool>.constant(false)
}

public struct ModalModeDetail: EnvironmentKey {
	public static let defaultValue = Binding<Bool>.constant(false)
}

public extension EnvironmentValues {
	
	var modalModeSettings: Binding<Bool> {
		get {
			return self[ModalModeSettings.self]
		}
		set {
			self[ModalModeSettings.self] = newValue
		}
	}
	
	var modalModeDetail: Binding<Bool> {
		get {
			return self[ModalModeDetail.self]
		}
		set {
			self[ModalModeDetail.self] = newValue
		}
	}
}
