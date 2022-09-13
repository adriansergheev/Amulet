import SwiftUI
import Model
import ComposableArchitecture
import ApiClient
import Shared

public struct AppReducer: ReducerProtocol {
	
	public struct State: Equatable {
		var charms: CharmsState
		var isDetailPresented: Bool
		var isSettingsPresented: Bool
		
		public enum CharmsState: Equatable {
			case loading
			case loaded([Charm], _ todays: Charm)
			case error(NSError)
		}
		
		public init(
			state: CharmsState,
			isDetailPresented: Bool = false,
			isSettingsPresented: Bool = false
		) {
			self.charms = state
			self.isDetailPresented = isDetailPresented
			self.isSettingsPresented = isSettingsPresented
		}
	}
	
	public enum Action: Equatable {
		case onAppear
		case onCharmsLoaded([Charm], _ todays: Charm)
		case onLoadFailed(NSError)
		case setDetailSheet(isPresented: Bool)
		case setSettingsSheet(isPresented: Bool)
	}
	
	@Dependency(\.mainQueue) var mainQueue
	var amuletClient: AmuletClient
	
	public init(amuletClient: AmuletClient) {
		self.amuletClient = amuletClient
	}
	
	public func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
		switch action {
		case .onAppear:
			state.charms = .loading
			return .task {
				do {
					try await self.mainQueue.sleep(for: 1)
					let result = try await amuletClient.getCharms()
					return .onCharmsLoaded(result.charm	, result.charm.randomElement()!)
				} catch let error {
					return .onLoadFailed(error as NSError)
				}
			}
		case let .onCharmsLoaded(charms, todaysCharm):
			state.charms = .loaded(charms, todaysCharm)
			return .none
		case let .onLoadFailed(error):
			state.charms = .error(error)
			return .none
		case let .setDetailSheet(isPresented: isPresented):
			state.isDetailPresented = isPresented
			return .none
		case let .setSettingsSheet(isPresented: isPresented):
			state.isSettingsPresented = isPresented
			return .none
		}
	}
}


public struct MainView: View {
	@EnvironmentObject var settings: AppSettings
	@State var textAnimationScale: CGFloat = 1
	
	let store: StoreOf<AppReducer>
	@ObservedObject var viewStore: ViewStoreOf<AppReducer>
	
	public init(store: StoreOf<AppReducer>) {
		self.store = store
		self.viewStore = ViewStore(self.store)
	}
	
	public var body: some View {
		ZStack {
			GradientView()
			Group {
				switch viewStore.charms {
				case .loaded(let charms, let todaysCharm):
					Group {
						header()
						main(todaysCharm)
						footer(charms)
					}
					.eraseToAnyView()
				case .loading:
					Group {
						header()
							.disabled(true)
							.opacity(0.1)
						Spinner(isAnimating: true, style: .large)
						footer([])
							.disabled(true)
							.opacity(0.1)
					}
					.eraseToAnyView()
				case .error:
					Group {
						header()
							.disabled(false)
						Text("Error loading charms ;(")
							.lineLimit(nil)
							.foregroundColor(.white)
							.padding(16)
							.multilineTextAlignment(.center)
							.frame(minWidth: 120, alignment: .center)
						footer([])
							.disabled(true)
							.opacity(0.1)
					}
					.eraseToAnyView()
				}
			}
		}
		.onAppear { viewStore.send(.onAppear) }
	}
	private func header() -> some View {
		VStack {
			HStack {
				Spacer()
				Button(action: {
					viewStore.send(.setSettingsSheet(isPresented: true))
				}, label: {
					Image(systemName: "ellipsis.circle")
						.resizable()
						.frame(width: 20, height: 20, alignment: .center)
				})
				.buttonStyle(NeumorphicButtonStyle(colorScheme: .light))
				.padding(.trailing)
			}
			.sheet(isPresented: viewStore.binding(
				get: \.isSettingsPresented,
				send: AppReducer.Action.setSettingsSheet(isPresented:))
			) {
				SettingsView(onCloseTap: { viewStore.send(.setSettingsSheet(isPresented: false))})
					.environmentObject(self.settings)
			}
			Spacer()
		}
		.animation(nil)
	}
	
	private func main(_ todaysCharm: Charm) -> some View {
		VStack(spacing: 32) {
			Text("Today's charm")
				.font(AmuletFont.defaultFont(36))
				.italic()
				.foregroundColor(.white)
				.multilineTextAlignment(.center)
			
			Text(todaysCharm.text)
				.lineLimit(nil)
				.foregroundColor(.white)
				.padding(16)
				.multilineTextAlignment(.center)
				.frame(minWidth: 120, alignment: .center)
		}
		.scaleEffect(textAnimationScale)
		.onAppear {
			withAnimation {
				withAnimation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
					self.textAnimationScale = 1.05
				}
			}
		}
	}
	
	private func footer(_ charms: [Charm]) -> some View {
		VStack {
			Spacer()
			HStack {
				Button(action: {
					viewStore.send(.setDetailSheet(isPresented: true))
				}, label: {
					Image(systemName: "heart")
						.resizable()
						.frame(width: 20, height: 20, alignment: .center)
				})
				.buttonStyle(NeumorphicButtonStyle(colorScheme: .light))
				.padding(.leading)
				.sheet(isPresented: viewStore.binding(
					get: \.isDetailPresented,
					send: AppReducer.Action.setDetailSheet(isPresented:))
				) {
					DetailView(
						charms: charms,
						onCloseTap: { viewStore.send(.setDetailSheet(isPresented: false)) }
					)
				}
				Spacer()
			}
		}
		.padding(.bottom)
		.animation(nil)
	}
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		MainView(
			store: .init(
				initialState: .init(state: .loading),
				reducer: AppReducer(amuletClient: .mock)
			)
		)
	}
}
#endif
