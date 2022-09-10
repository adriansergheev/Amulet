//
//  Spinner.swift
//  Amulet
//
//  Created by Andrian Sergheev on 2020-03-27.
//  Copyright © 2020 Andrian Sergheev. All rights reserved.
//

import SwiftUI
import UIKit

struct Spinner: UIViewRepresentable {
    let isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.hidesWhenStopped = true
		spinner.color = .white
        return spinner
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
