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
