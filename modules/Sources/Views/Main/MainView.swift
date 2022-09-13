import SwiftUI
import Model
import ComposableArchitecture
import ApiClient
import Shared

public struct AppReducer: ReducerProtocol {
	public enum State: Equatable {
		case loading
		case loaded([Charm], _ todays: Charm)
		case error(NSError)
	}
	public enum Action: Equatable {
		case onAppear
		case onCharmsLoaded([Charm], _ todays: Charm)
		case onLoadFailed(NSError)
	}
	
	var amuletClient: AmuletClient
	
	public init(amuletClient: AmuletClient) {
		self.amuletClient = amuletClient
	}
	
	public func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
		switch action {
		case .onAppear:
			state = .loading
			return .task {
				do {
					try await Task.sleep(nanoseconds: NSEC_PER_SEC / 2) // 0.5 sec delay
					let result = try await amuletClient.getCharms()
					return .onCharmsLoaded(result.charm	, result.charm.randomElement()!)
				} catch let error {
					return .onLoadFailed(error as NSError)
				}
			}
		case let .onCharmsLoaded(charms, todaysCharm):
			state = .loaded(charms, todaysCharm)
			return .none
		case let .onLoadFailed(error):
			state = .error(error)
			return .none
		}
	}
}


public struct MainView: View {
	@EnvironmentObject var settings: AppSettings
	@State var textAnimationScale: CGFloat = 1
	@State var isSettingsModalPresented = false
	@State var isDetailModalPrestented = false
	
	let store: StoreOf<AppReducer>
	
	public init(store: StoreOf<AppReducer>) {
		self.store = store
	}
	
	public var body: some View {
		WithViewStore(self.store) { viewStore in
			ZStack {
				GradientView()
				Group {
					switch viewStore.state {
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
	}
	private func header() -> some View {
		VStack {
			HStack {
				Spacer()
				Button(action: {
					self.isSettingsModalPresented.toggle()
				}, label: {
					Image(systemName: "ellipsis.circle")
						.resizable()
						.frame(width: 20, height: 20, alignment: .center)
				})
				.buttonStyle(NeumorphicButtonStyle.init(colorScheme: .light))
				.padding(.trailing)
			}
			.sheet(isPresented: $isSettingsModalPresented) {
				SettingsView(viewModel: SettingsViewModel(self.settings))
					.environment(\.modalModeSettings, self.$isSettingsModalPresented)
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
					self.isDetailModalPrestented.toggle()
				}, label: {
					Image(systemName: "heart")
						.resizable()
						.frame(width: 20, height: 20, alignment: .center)
				})
				.buttonStyle(NeumorphicButtonStyle(colorScheme: .light))
				.padding(.leading)
				.sheet(isPresented: $isDetailModalPrestented) {
					DetailView(charms: charms)
						.environment(\.modalModeDetail, self.$isDetailModalPrestented)
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
				initialState: .loading,
				reducer: AppReducer(amuletClient: .mock)
			)
		)
	}
}
#endif
