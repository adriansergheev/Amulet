import SwiftUI

struct GradientView: View {
	
	var gradient = [Color.red, Color.purple, Color.orange]
	
	@State var startPoint = UnitPoint(x: 0, y: 0)
	@State var endPoint = UnitPoint(x: 0, y: 2)
	
	init(gradientColors: [Color] = [.red, .purple, .orange]) {
		self.gradient = gradientColors
	}
	
	var body: some View {
		ZStack {
			LinearGradient(
				gradient: Gradient(colors: self.gradient),
				startPoint: self.startPoint, endPoint: self.endPoint
			)
			.edgesIgnoringSafeArea(.all)
			.onAppear {
				withAnimation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
					self.startPoint = UnitPoint(x: 1, y: -1)
					self.endPoint = UnitPoint(x: 0, y: 1)
				}
			}
		}
	}
}

struct GradientView_Previews: PreviewProvider {
	static var previews: some View {
		GradientView()
	}
}
