//
//  DetailView.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-23.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import SwiftUI

struct DetailView: View {

	@ObservedObject
	var viewModel: DetailViewModel

	//injected modal reference
	@Environment (\.modalModeDetail) var modalMode

	// gradient
	@State var gradient = [Color.white, Color.pink, Color.purple]
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

		VStack(alignment: .leading, spacing: 32) {

			Spacer(minLength: 60)

			Text("It's so lovely to\nsee you.")
				.foregroundColor(Color.black)
				.font(AmuletFont.defaultFont(50))
				.italic()

			Text("Here you can see your previous charms:")
				.foregroundColor(.black)

			ScrollView(.vertical, showsIndicators: false) {
				VStack(spacing: 16) {
					ForEach(viewModel.charms, id: \.id) { charm in
						DetailCellView(charm: charm)
					}
				}
				.padding(16)
			}
		}
		.padding(16)
		.animation(nil)
	}
}

struct DetailView_Previews: PreviewProvider {
	static var previews: some View {
		DetailView(viewModel: DetailViewModel(charms: demoCharms))
	}
}

struct DetailCellView: View {

	let charm: Charm

	var body: some View {

		VStack(alignment: .leading, spacing: 4) {
			Text(charm.text)
				.foregroundColor(.black)
				.lineLimit(nil)
				.frame(minHeight: 40, alignment: .leading)

			Text(charm.dateFormatted ?? "")
				.font(AmuletFont.defaultFont(12))

			Divider()
				.background(Color.black)
				.frame(height: 2)
		}

	}

}
