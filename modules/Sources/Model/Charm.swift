import Foundation

public struct CharmResponse: Codable {
	public let charm: [Charm]
}

public struct Charm: Codable, Identifiable, Equatable {
	public let id: Int
	public let text: String
	private let dateAsString: String?
	
	public init(id: Int, text: String, dateAsString: String? = nil) {
		self.id = id
		self.text = text
		self.dateAsString = dateAsString
	}
	
	enum CodingKeys: String, CodingKey {
		case id
		case text
		case dateAsString = "date"
	}
	
	public lazy var date: Date? = {
		if let string = self.dateAsString {
			let dateFormatter = ISO8601DateFormatter()
			return dateFormatter.date(from: string)
		}
		return nil
	}()
	
	public lazy var dateFormatted: String? = {
		if 	let string = self.dateAsString {
			
			let dateFormatter = ISO8601DateFormatter()
			
			if let validated = dateFormatter.date(from: string) {
				let dateFormatter = DateFormatter()
				dateFormatter.dateStyle = .medium
				dateFormatter.timeStyle = .none
				return dateFormatter.string(from: validated)
			}
		}
		return nil
	}()
}
