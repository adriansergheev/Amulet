//
//  ContentView.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-22.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import SwiftUI

struct MainView: View {

	@ObservedObject var viewModel: MainViewModel
	@EnvironmentObject var settings: AppSettings

	// animation
	@State var textAnimationScale: CGFloat = 1

	//modal
	@State var isSettingsModalPresented = false
	@State var isDetailModalPrestented = false

	var body: some View {
		ZStack {
			GradientView()

			content
				.onAppear { self.viewModel.send(event: .onAppear) }
		}
	}

	private var content: some View {

		switch viewModel.state {
		case .loaded(let charms, let todaysCharm):
			return Group {
				header()
				main(todaysCharm)
				footer(charms)
			}
			.eraseToAnyView()
		case .idle, .loading:
			return Group {
				header()
					.disabled(true)
					.opacity(0.1)
				Spinner(isAnimating: true, style: .large)
				footer([])
					.disabled(true)
					.opacity(0.1)
			}
			.eraseToAnyView()
		case .error:
			return Group {
				header()
					.disabled(false)
				Text("Error loading charms ;(")
					.lineLimit(nil)
					.foregroundColor(.white)
					.padding(16)
					.multilineTextAlignment(.center)
					.frame(minWidth: 120, alignment: .center)
				footer([])
					.disabled(true)
					.opacity(0.1)
			}
			.eraseToAnyView()
		}
	}

	private func header() -> some View {
		VStack {
			HStack {
				Spacer()
				Button(action: {
					self.isSettingsModalPresented.toggle()
				}, label: {
					Image(systemName: "ellipsis.circle")
						.resizable()
						.frame(width: 20, height: 20, alignment: .center)
				})
					.buttonStyle(NeumorphicButtonStyle.init(colorScheme: .light))
					.padding(.trailing)
			}
			.sheet(isPresented: $isSettingsModalPresented) {
				SettingsView(viewModel: SettingsViewModel(self.settings))
					.environment(\.modalModeSettings, self.$isSettingsModalPresented)
					.environmentObject(self.settings)
			}
			Spacer()
		}
		.animation(nil)
	}

	private func main(_ todaysCharm: Charm?) -> some View {
		VStack(spacing: 32) {
			Text("Today's charm")
				.font(AmuletFont.defaultFont(36))
				.italic()
				.foregroundColor(.white)
				.multilineTextAlignment(.center)

			Text(todaysCharm?.text ?? "Can't load today's charm ;(")
				.lineLimit(nil)
				.foregroundColor(.white)
				.padding(16)
				.multilineTextAlignment(.center)
				.frame(minWidth: 120, alignment: .center)
		}
		.scaleEffect(textAnimationScale)
		.onAppear {
			withAnimation {
				withAnimation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
					self.textAnimationScale = 1.05
				}
			}
		}
	}

	private func footer(_ charms: [Charm]) -> some View {
		VStack {
			Spacer()

			HStack {
				Button(action: {
					self.isDetailModalPrestented.toggle()
				}, label: {
					Image(systemName: "heart")
						.resizable()
						.frame(width: 20, height: 20, alignment: .center)
				})
					.buttonStyle(NeumorphicButtonStyle(colorScheme: .light))
					.padding(.leading)
					.sheet(isPresented: $isDetailModalPrestented) {
						DetailView(viewModel: DetailViewModel(charms: charms))
							.environment(\.modalModeDetail, self.$isDetailModalPrestented)
				}
				Spacer()
			}
		}
		.padding(.bottom)
		.animation(nil)
	}

}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		MainView(viewModel: MainViewModel())
	}
}
