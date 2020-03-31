//
//  CancelButtonView.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-31.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import SwiftUI

struct CancelButtonView: View {

	private let action: () -> Void

	init(_ action: @escaping () -> Void) {
		self.action = action
	}

	var body: some View {
		VStack {
			HStack {
				Spacer()
				Button(action: {
					self.action()
				}, label: {
					AmuletIcons
						.cancel
				})
					.offset(x: -16, y: 0)
			}
			Spacer()
		}
		.offset(x: 0, y: 16)
	}
}
