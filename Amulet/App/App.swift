import modules
import SwiftUI

@main
struct Amulet: App {
	var body: some Scene {
		WindowGroup {
			MainView(viewModel: MainViewModel())
		}
	}
}
