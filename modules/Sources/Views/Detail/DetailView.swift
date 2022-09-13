import SwiftUI
import Model
import Shared
import Extensions

struct DetailCellView: View {
	let charm: Charm
	var body: some View {
		VStack(alignment: .leading, spacing: 4) {
			Text(charm.text)
				.foregroundColor(.black)
				.lineLimit(nil)
				.frame(minHeight: 40, alignment: .leading)
			Text(charm.dateFormatted ?? "")
				.foregroundColor(.black)
				.font(AmuletFont.defaultFont(12))
			Divider()
				.background(Color.black)
				.frame(height: 2)
		}
	}
}


struct DetailView: View {
	@Environment (\.modalModeDetail) var modalMode
	@State private var isSharePresented = false
	@State var charms: [Charm] 
	
	public init(charms: [Charm]) {
		self.charms = charms
			.filter { ($0.date?.isPastDate) ?? false }
	}
	
	var body: some View {
		ZStack {
			GradientView(gradientColors: [Color.white, Color.pink, Color.purple])
			CancelButtonView({ self.modalMode.wrappedValue.toggle() })
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
						ForEach(self.charms, id: \.id) { charm in
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
}

#if DEBUG
let demoCharms: [Charm] = demoCharmsText.enumerated().map { Charm(id: $0, text: $1) }

public let demoCharmsText: [String] = [
	"Don't keep texting people who don't want to text you back. You deserve so much more than that.",
	"Try to take one action tonight that will make tomorrow morning just a little easier.",
	"Accept that today won't be perfect. And that's ok.",
	"Slow down. The world can begin and end on your freaking temrs today!",
	"Set a goal for this week. Just one!",
	"Remember that you're human and you're allowed to forget, and you'll remember tomorrow.",
	"Today, give yourself permission to cancel one thing that's just too much. You don't have to do everything.",
	"Things have been piling up and you might need a bit more sleep. Pick a night, and get to sleep early!",
	"Put on the right song and allow yourself to drift away.",
	"Give somebody you love a small gift. Nothing special, just a small gift.",
	"Speaking of rituals. Try and create one for your shower or your bath. A ritual of looking after you. It's comforting to have a series of careful steps and actions that you know you're going to take every morning, where each one makes a difference to your personal care. ✨"
]
struct DetailView_Previews: PreviewProvider {
	static var previews: some View {
		DetailView(charms: demoCharms)
	}
}
#endif
