//
//  ViewControllerRepresentable.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-27.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

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

	func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {

	}

}
