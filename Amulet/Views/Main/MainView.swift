//
//  ContentView.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-22.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import SwiftUI

struct MainView: View {

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

				self.textAnimationScale += 0.05
			}
		}
		//		.onTapGesture {
		//			withAnimation (.easeInOut(duration: 3)){
		//				self.startPoint = UnitPoint(x: 1, y: -1)
		//				self.endPoint = UnitPoint(x: 0, y: 1)
		//			}
		//		}
	}

	func header() -> some View {
		VStack {
			HStack {
				Spacer()
				Button(action: {
					self.isSettingsModalPresented.toggle()
				}, label: {
					//					Text("More")
					//					.foregroundColor(.black)

					AmuletIcons
						.settings
				})
					.buttonStyle(NeumorphicButtonStyle.init(colorScheme: .light))
					.offset(x: -16, y: 0)
			}
			.sheet(isPresented: $isSettingsModalPresented) { SettingsView() }
			Spacer()
		}
		.offset(x: 0, y: 40)
	}

	func main() -> some View {
		VStack(spacing: 32) {
			Text("Today's charm")
				.font(.system(size: 36))
				.italic()
				.foregroundColor(.white)
				.multilineTextAlignment(.center)
				.scaleEffect(textAnimationScale)
				.animation(
					Animation.spring().speed(0.1).repeatForever(autoreverses: true)
			)

			Text(
				"""
		Speaking of rituals. Try and create one for your shower or your bath. A ritual of looking after you. It's comforting to have a series of careful steps and actions that you know you're going to take every morning, where each one makes a difference to your personal care. ✨
		"""
			)
				.foregroundColor(.white)
				.padding(16)
				.multilineTextAlignment(.center)
				.scaleEffect(textAnimationScale)
				.animation(
					Animation.spring().speed(0.1).repeatForever(autoreverses: true)
			)
		}
	}

	func footer() -> some View {
		VStack {
			Spacer()

			HStack {
				Button(action: {
					self.isDetailModalPrestented.toggle()
				}, label: {
					//					Text("Previous magic")
					//						.foregroundColor(.black)
					AmuletIcons
						.more
				})
					.buttonStyle(NeumorphicButtonStyle.init(colorScheme: .light))
					.padding(32)
					.sheet(isPresented: $isDetailModalPrestented) {
						DetailView()
							.environment(\.modalModeDetail, self.$isDetailModalPrestented)
				}
				Spacer()
			}
		}
	}

}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
	}
}
