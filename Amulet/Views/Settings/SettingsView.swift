//
//  SettingsView.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-23.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import SwiftUI

struct SettingsView: View {

	@ObservedObject var viewModel: SettingsViewModel

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
		.onAppear { self.viewModel.onAppear() }
		.edgesIgnoringSafeArea(.all)
	}

	private func button() -> some View {
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

	private func main() -> some View {

		VStack(alignment: .leading, spacing: 16) {

			Text("Preferences")
				.font(.title)

			Text("Every day, at the time chosen by you,\na new dose of charm will arrive.\n\nStay tuned!")
				.font(.subheadline)
				.foregroundColor(Color.black)
				.font(AmuletFont.defaultFont(16))
				.multilineTextAlignment(.leading)

			Spacer()

			ScrollView(.vertical, showsIndicators: false) {

				VStack(alignment: .leading, spacing: 32) {

					VStack(spacing: 30) {

						SettingCellView(

							Button(action: {
								print("Show intention")
							}, label: {
								Text("Intention")
								Spacer()
								Image(systemName: "arrow.right")
									.padding(.trailing, 4)
							})
								.foregroundColor(.black)
								.eraseToAnyView()
						)

						SettingCellView(
							Button(action: {
								self.openSystemWideSettings()
							}, label: {
								Text("Push Notifications")
								Spacer()
								Image(systemName: "arrow.right")
									.padding(.trailing, 4)
							})
								.foregroundColor(.black)
								.eraseToAnyView()
						)

						SettingCellView(
							Picker(selection: $viewModel.settings.notificationReceivingTimeIndex, label: Text("Push notification time")) {
								ForEach(0 ..< NotificationTime.allCases.count) { time in
									Text("\(NotificationTime.allCases[time].rawValue)")
								}
							}
							.pickerStyle(SegmentedPickerStyle())
							.disabled(!viewModel.settings.notificationsEnabled)
							.eraseToAnyView()
						)

						SettingCellView(
							Button(action: {
								print("Send email")
							}, label: {
								Text("Reach Out")
								Spacer()
								Image(systemName: "arrow.right")
									.padding(.trailing, 4)
							})
								.foregroundColor(.black)
								.eraseToAnyView()
						)

						SettingCellView(
							Button(action: {
								print("Show credits")
							}, label: {
								Text("Credits")
								Spacer()
								Image(systemName: "arrow.right")
									.padding(.trailing, 4)
							})
								.foregroundColor(.black)
								.eraseToAnyView()
						)

					}
					.padding(16)

					VStack(alignment: .leading, spacing: 4) {

//						Text("Terms / Privacy")
//							.fontWeight(.semibold)
//							.font(AmuletFont.defaultFont(14))
						Text("Version: \(UIApplication.appVersion)")
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

	private func openSystemWideSettings() {
		guard let stringURL = URL(string: UIApplication.openSettingsURLString) else { return }
		UIApplication.shared.open(stringURL)
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView(viewModel: SettingsViewModel(AppSettings()))
	}
}

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
