import Modules
import SwiftUI

@main
struct Amulet: App {
	var body: some Scene {
		WindowGroup {
			MainView()
				.environmentObject(AppSettings())
		}
	}
}
