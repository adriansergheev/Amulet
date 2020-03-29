//
//  Current.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-26.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import Foundation

// swiftlint:disable all
var Current = AppEnvironment()

struct AppEnvironment {
	#if DEBUG
	private (set)var networkEnvironment: NetworkEnvironment = .mock
	#else
	private (set)var networkEnvironment: NetworkEnvironment = .prod
	#endif
	
}
// swiftlint:enable all
