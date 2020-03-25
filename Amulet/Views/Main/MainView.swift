//
//  ContentView.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-22.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import SwiftUI

struct MainView: View {

	@ObservedObject
	var viewModel: MainViewModel

	// gradient
	@State var gradient = [Color.red, Color.purple, Color.orange]
	@State var startPoint = UnitPoint(x: 0, y: 0)
	@State var endPoint = UnitPoint(x: 0, y: 2)

	// animation
	@State var textAnimationScale: CGFloat = 1

	//modal
	@State var isSettingsModalPresented = false
	@State var isDetailModalPrestented = false

	var body: some View {
		ZStack {
			LinearGradient(gradient: Gradient(colors: self.gradient),
						   startPoint: self.startPoint, endPoint: self.endPoint)
				.overlay(
					ZStack {
						header()
						main()
						footer()
					}
			)
		}
		.edgesIgnoringSafeArea(.all)
		.onAppear {
			withAnimation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true)) {

				self.startPoint = UnitPoint(x: 1, y: -1)
				self.endPoint = UnitPoint(x: 0, y: 1)

				self.textAnimationScale = 1.05
			}
		}
	}

	func header() -> some View {
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
					.offset(x: -16, y: 0)
			}
			.sheet(isPresented: $isSettingsModalPresented) {
				SettingsView()
					.environment(\.modalModeSettings, self.$isSettingsModalPresented)
			}
			Spacer()
		}
		.animation(nil)
		.offset(x: 0, y: 40)
	}

	func main() -> some View {
		VStack(spacing: 32) {
			Text("Today's charm")
				.font(AmuletFont.defaultFont(36))
				.italic()
				.foregroundColor(.white)
				.multilineTextAlignment(.center)

			Text(viewModel.todaysCharm?.text ?? "")
				.lineLimit(nil)
				.foregroundColor(.white)
				.padding(16)
				.multilineTextAlignment(.center)
				.frame(minWidth: 120, alignment: .center)
		}
		.scaleEffect(textAnimationScale)
	}

	func footer() -> some View {
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
					.buttonStyle(NeumorphicButtonStyle.init(colorScheme: .light))
					.padding(32)
					.sheet(isPresented: $isDetailModalPrestented) {
						DetailView(viewModel: DetailViewModel(charms: self.viewModel.charms))
							.environment(\.modalModeDetail, self.$isDetailModalPrestented)
				}
				Spacer()
			}
		}
		.animation(nil)
	}

}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		MainView(viewModel: MainViewModel())
	}
}
