import Foundation
import UIKit
import SwiftUI

/*
 https://stackoverflow.com/questions/56533564/showing-uiactivityviewcontroller-in-switui
 */

struct ActivityViewController: UIViewControllerRepresentable {
	
	var activityItems: [Any]
	var applicationActivities: [UIActivity]?
	
	func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
		let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
		return controller
	}
	
	func updateUIViewController(_ uiViewController: UIActivityViewController,
															context: UIViewControllerRepresentableContext<ActivityViewController>) {
	}
}
