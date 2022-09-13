import Views
import SwiftUI
import Shared

@main
struct Amulet: App {
	var body: some Scene {
		WindowGroup {
			MainView(
				store: .init(
					initialState: .init(state: .loading),
					reducer: AppReducer(amuletClient: .mock)
				)
			)
			.environmentObject(AppSettings())
		}
	}
}
