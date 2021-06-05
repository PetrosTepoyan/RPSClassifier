//
//  PreviewHolder.swift
//  RPSmobile
//
//  Created by Петрос Тепоян on 6/5/21.
//

import Foundation
import SwiftUI

struct PreviewHolder: UIViewRepresentable {
	
	@ObservedObject var manager: PreviewHolderManager
	
	func makeUIView(context: UIViewRepresentableContext<PreviewHolder>) -> PreviewView {
		let previewView = PreviewView.init()
		previewView.delegate = self
		return previewView
	}
	
	func updateUIView(_ uiView: PreviewView, context: UIViewRepresentableContext<PreviewHolder>) {}
	
	
	typealias UIViewType = PreviewView
}

extension PreviewHolder: PreviewViewDelegate {
	
	func didPredictLabel(_ label: String) {
		DispatchQueue.main.async {
			manager.classLabel = label
		}
		
	}
}

class PreviewHolderManager: ObservableObject {
	@Published var classLabel: String = "Not detected"
}
