//
//  DetailView.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-23.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import SwiftUI
import Model

struct DetailView: View {

	@ObservedObject var viewModel: DetailViewModel

	//injected modal reference
	@Environment (\.modalModeDetail) var modalMode

	@State private var isSharePresented = false

	var body: some View {
		ZStack {
			GradientView(gradientColors: [Color.white, Color.pink, Color.purple])
			CancelButtonView({ self.modalMode.wrappedValue.toggle() })
			main()
		}
	}

	func main() -> some View {

		VStack(alignment: .leading, spacing: 32) {

			Spacer(minLength: 60)

			Text("It's so lovely to\nsee you.")
				.foregroundColor(Color.black)
				.font(AmuletFont.defaultFont(50))
				.italic()
				.minimumScaleFactor(0.8)

			Text("Here you can see your previous charms:")
				.foregroundColor(.black)

			ScrollView(.vertical, showsIndicators: false) {
				VStack(spacing: 16) {
					ForEach(viewModel.charms, id: \.id) { charm in
						Button(action: {
							self.isSharePresented.toggle()
						}) {
							DetailCellView(charm: charm)
						}
						.sheet(isPresented: self.$isSharePresented) {
							ActivityViewController(activityItems: [charm.text])
						}
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
