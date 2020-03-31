//
//  SettingCellView.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-31.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import SwiftUI

struct SettingCellView: View {

	let view: AnyView

	init(_ view: AnyView) {
		self.view = view
	}

	var body: some View {

		ZStack {

			VStack(alignment: .leading, spacing: 8) {

				view

				Divider()
					.background(Color.black)
					.frame(height: 2)

			}
		}
	}
}
