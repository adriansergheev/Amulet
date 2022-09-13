import Foundation

public var Current = AppEnvironment()

public struct AppEnvironment {
	public let supportEmail: String = "greenblackstudio@icloud.com"
	public let supportWebsite: String = "https://twitter.com/adriansergheev"
	
	public let intentionHeader: String = "Sometimes, you just need to be cheered up."
	public let intentionText: String = """
\nIn our fast-paced world, we forget things we cared about before. The simple joys of life.\n\nCheck-in with the app when you feel like it, or receive a daily notification which will hopefully leave a charming feeling in your soul.
"""
}
