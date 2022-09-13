import XCTest
import ComposableArchitecture
import ApiClient
@testable import Views

@MainActor
final class MainViewTests: XCTestCase {
	func testHappyPath() async {
		let amuletClient = AmuletClient.mock
		let store = TestStore(
			initialState: AppReducer.State(state: .loading),
			reducer: AppReducer(amuletClient: amuletClient)
		)
		
		let mainQueue = DispatchQueue.test
		store.dependencies.mainQueue = mainQueue.eraseToAnyScheduler()
		
		let charms = try! await amuletClient.getCharms()
		
		_ = await store.send(.onAppear)
		await mainQueue.advance(by: 1)
		_ = await store.receive(.onCharmsLoaded(charms.charm, charms.charm.last!)) {
			$0.charms = .loaded(charms.charm, charms.charm.last!)
		}
	}
	
	func testUnhappyPath() async {
		let store = TestStore(
			initialState: AppReducer.State(state: .loading),
			reducer: AppReducer(amuletClient: .failing)
		)
		
		let mainQueue = DispatchQueue.test
		store.dependencies.mainQueue = mainQueue.eraseToAnyScheduler()
				
		_ = await store.send(.onAppear)
		await mainQueue.advance(by: 1)
		_ = await store.receive(.onLoadFailed(AmuletClient.AmuletError.invalidResponse as NSError)) {
			$0.charms = .error(AmuletClient.AmuletError.invalidResponse as NSError)
		}
	}
}
