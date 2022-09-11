import Modules
import SwiftUI

@main
struct Amulet: App {
	var body: some Scene {
		WindowGroup {
			MainView(
				store: .init(
					initialState: .loading,
					reducer: AppReducer(amuletClient: .mock)
				)
			)
			.environmentObject(AppSettings())
		}
	}
}
