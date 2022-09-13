import SwiftUI
import Shared

struct IntentionView: View {

	@Binding var isPresented: Bool

	var body: some View {
		ZStack {

			GradientView(gradientColors: [.pink, .white])

			CancelButtonView({ self.isPresented = false })

			VStack(alignment: .leading, spacing: 36) {
				Text(Current.intentionHeader)
					.font(.title)
					.foregroundColor(.black)
					.bold()
					.italic()

				Text(Current.intentionText)
					.font(.subheadline)
					.font(AmuletFont.defaultFont(22))
					.multilineTextAlignment(.leading)

				Spacer()
			}
			.padding(EdgeInsets(top: 128, leading: 22, bottom: 22, trailing: 22))
		}
	}
}

struct IntentionView_Previews: PreviewProvider {
	static var previews: some View {
		IntentionView(isPresented: Binding.constant(true))
	}
}
