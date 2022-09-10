//
//  Environment+Ext.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-23.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import Foundation
import SwiftUI

struct ModalModeSettings: EnvironmentKey {
	static let defaultValue = Binding<Bool>.constant(false)
}

struct ModalModeDetail: EnvironmentKey {
	static let defaultValue = Binding<Bool>.constant(false)
}

extension EnvironmentValues {

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
