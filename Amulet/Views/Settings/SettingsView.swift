//
//  SettingsView.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-23.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import SwiftUI

private var settingsMock: [Charm] = (0...8).map { Charm(id: $0, text: "Setting: \($0)")}

struct SettingsView: View {

	//injected modal reference
	@Environment (\.modalModeSettings) var modalMode

	// gradient
	@State var gradient = [Color.purple, Color.white]
	@State var startPoint = UnitPoint(x: 0, y: 0)
	@State var endPoint = UnitPoint(x: 0, y: 2)

	var body: some View {
		ZStack {
			LinearGradient(gradient: Gradient(colors: self.gradient),
						   startPoint: self.startPoint, endPoint: self.endPoint)
				.onAppear {
					withAnimation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true)) {

						self.startPoint = UnitPoint(x: 1, y: -1)
						self.endPoint = UnitPoint(x: 0, y: 1)

					}
			}
			button()
			main()
		}
		.edgesIgnoringSafeArea(.all)
	}

	func button() -> some View {
		VStack {
			HStack {
				Spacer()
				Button(action: {
					self.modalMode.wrappedValue.toggle()
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

	func main() -> some View {

		VStack(alignment: .leading, spacing: 16) {

			Text("Preferences")
				.font(.title)

			Text("Every day, at the time chosen by you\na new dose of charm will arrive.\nStay tuned!")
				.font(.subheadline)
				.foregroundColor(Color.black)
				.font(AmuletFont.defaultFont(16))
				.multilineTextAlignment(.leading)

			Spacer()

			ScrollView(.vertical, showsIndicators: false) {

				VStack(alignment: .leading) {

					VStack(spacing: 16) {
						ForEach(settingsMock, id: \.id) { setting in
							SettingCellView(text: setting.text)
						}
					}
					.padding(16)

					VStack(alignment: .leading, spacing: 4) {

						Text("Terms / Privacy")
							.fontWeight(.semibold)
							.font(AmuletFont.defaultFont(14))
						Text("Version: 1.0.0")
							.fontWeight(.thin)
							.multilineTextAlignment(.leading)
							.font(AmuletFont.defaultFont(12))
					}.padding()

					Spacer()
				}
			}
		}
		.animation(nil)
		.padding(EdgeInsets(top: 64, leading: 16, bottom: 16, trailing: 16))
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView()
	}
}

struct SettingCellView: View {

	let text: String

	var body: some View {

		VStack(alignment: .leading, spacing: 4) {
			Text(text)
				.foregroundColor(.black)
				.lineLimit(nil)
				.frame(minHeight: 20, alignment: .leading)

			Divider()
				.background(Color.black)
				.frame(height: 2)
		}

	}

}
