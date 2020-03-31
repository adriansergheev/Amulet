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

	public let supportEmail: String = "greenblackstudio@icloud.com"
	public let supportWebsite: String = "https://twitter.com/asergheev"

	public let intentionHeader: String = "Sometimes, you just need to be cheered up."
	public let intentionText: String = """
\nIn our fast-paced world, we forget things we cared about before. The simple joys of life.\n\nCheck-in with the app when you feel like it, or receive a daily notification which will hopefully leave a charming feeling in your soul.
"""
}
// swiftlint:enable all
