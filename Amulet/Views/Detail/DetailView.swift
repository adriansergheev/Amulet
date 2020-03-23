//
//  DetailView.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-23.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import SwiftUI

struct DetailView: View {

	//injected modal reference
	@Environment (\.modalModeDetail) var modalMode

	// gradient
	@State var gradient = [Color.pink, Color.purple, Color.white]
	@State var startPoint = UnitPoint(x: 0, y: 0)
	@State var endPoint = UnitPoint(x: 0, y: 2)

	var body: some View {
		ZStack {
			LinearGradient(gradient: Gradient(colors: self.gradient),
						   startPoint: self.startPoint, endPoint: self.endPoint)
				.overlay(
					ZStack {
						header()
					}
			)
			main()
		}
		.edgesIgnoringSafeArea(.all)
		//		.onAppear {
		//			withAnimation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
		//
		//				self.startPoint = UnitPoint(x: 1, y: -1)
		//				self.endPoint = UnitPoint(x: 0, y: 1)
		//			}
		//		}
		//		.onTapGesture {
		//			withAnimation (.easeInOut(duration: 3)){
		//						self.startPoint = UnitPoint(x: 1, y: -1)
		//						self.endPoint = UnitPoint(x: 0, y: 1)
		//			}
		//		}
	}

	func header() -> some View {
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

			Spacer()

			Text("It's so lovely to\nsee you here.")
				.foregroundColor(Color.black)
				.font(Font.system(size: 50))
				.italic()

			//			Text("Every day, at the time chosen by you \n a new dose of charm will arrive.\n Stay tuned!")
			Text("Here you can see your previous charms")
				.foregroundColor(.black)

			ScrollView(.vertical, showsIndicators: false) {
				VStack(spacing: 16) {

					ForEach(demoCharms) { charm in
						CellView(charmText: charm.text)
					}

//					ForEach((1...10).reversed(), id: \.self) {
//						CellView(id: $0)
//					}
				}.padding(16)
			}
			.offset(x: 0, y: 32)
		}
		.padding(16)
		.offset(x: 0, y: 60)
	}
}

struct DetailView_Previews: PreviewProvider {
	static var previews: some View {
		DetailView()
	}
}

struct Charm: Identifiable {
	var id: Int
	var text: String
}

private let demoCharmsText: [String] = [
	"Don't keep texting people who don't want to text you back.You deserve so much more than that.",
	"Try to take one action tonight that will make tomorrow morning just a little easier.",
	"Accept that today won't be perfect. And that's ok.",
	"Slow down. The world can begin and end on your freaking temrs today!",
	"Set a goal for this week. Just one!",
	"Remember that you're human and you're allowed to forget, and you'll remember tomorrow.",
	"Today, give yourself permission to cancel one thing that's just too much. You don't have to do everything.",
	"Things have been piling up and you might need a bit more sleep. Pick a night, and get to sleep early!",
	"Put on the right song and allow yourself to drift away.",
	"Give somebody you love a small gift. Nothing special, just a small gift."
]

let demoCharms: [Charm] = demoCharmsText.enumerated().map { Charm(id: $0, text: $1)}

struct CellView: View {

	let charmText: String

	var body: some View {

		VStack {
			Text(charmText)
				.foregroundColor(.black)
			Divider()
				.background(Color.black)
				.frame(height: 2)
		}

	}

}
