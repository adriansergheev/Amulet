//
//  SettingsView.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-23.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import SwiftUI
import Shared

struct SettingsView: View {

	@ObservedObject var viewModel: SettingsViewModel

	//injected modal reference
	@Environment (\.modalModeSettings) var modalMode

	@State var isIntentModalPresented = false

	var body: some View {
		ZStack {
			GradientView(gradientColors: [Color.purple, Color.white])
			CancelButtonView({ self.modalMode.wrappedValue.toggle() })
			main()
		}
		.onAppear { self.viewModel.onAppear() }
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
								self.isIntentModalPresented.toggle()
							}, label: {
								Text("Intention")
								Spacer()
								Image(systemName: "arrow.right")
									.padding(.trailing, 4)
							})
								.foregroundColor(.black)
								.sheet(isPresented: $isIntentModalPresented) {
									IntentionView(isPresented: self.$isIntentModalPresented)
							}
							.eraseToAnyView()
						)

						SettingCellView(
							Button(action: {
								self.onOpenSystemSettings()
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
								self.onReachOutViaEmail()
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
								self.onCredits()
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

	private func onOpenSystemSettings() {
		guard let stringURL = URL(string: UIApplication.openSettingsURLString) else { return }
		UIApplication.shared.open(stringURL)
	}

	private func onReachOutViaEmail() {
		if let emailUrl = URL(string: "mailto:\(Current.supportEmail)") {
			UIApplication.shared.open(emailUrl, options: [:], completionHandler: nil)
		}
	}

	private func onCredits() {
		if let supportUrl = URL(string: Current.supportWebsite) {
			UIApplication.shared.open(supportUrl)
		}
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView(viewModel: SettingsViewModel(AppSettings()))
	}
}
