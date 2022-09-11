//
//  AmuletConstants.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-22.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import Foundation
import SwiftUI
import Model

struct AmuletFont {
	static var defaultFont: (CGFloat) -> Font = { Font.system(size: $0) }
}

struct AmuletColors { }

struct AmuletIcons {
	static let cancel: some View = Image(systemName: "multiply")
		.resizable()
		.frame(width: 20, height: 20, alignment: .center)
		.foregroundColor(.black)

	// Crashes as of iOS 13.4 Xcode 11.4 when used in external views

	//	static let more: some View = Image(systemName: "heart")
	//		.resizable()
	//		.frame(width: 20, height: 20, alignment: .center)
	//
	//	static let settings: some View = Image(systemName: "ellipsis.circle")
	//		.resizable()
	//		.frame(width: 20, height: 20, alignment: .center)
}

