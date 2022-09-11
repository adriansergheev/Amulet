import Modules
import SwiftUI

@main
struct Amulet: App {
	var body: some Scene {
		WindowGroup {
			MainView(viewModel: MainViewModel())
				.environmentObject(AppSettings())
		}
	}
}
