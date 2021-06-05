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
	
	func updateUIView(_ uiView: PreviewView, context: UIViewRepresentableContext<PreviewHolder>) {
	}
	
	
	typealias UIViewType = PreviewView
}

extension PreviewHolder: PreviewViewDelegate {
	
	func didPredictLabel(_ label: String) {
		DispatchQueue.main.async {
			manager.classLabel = label
		}
		
	}
	
	func didPredictProbs(_ label: [String : Double]) {
		DispatchQueue.main.async {
			manager.identity = label
		}
	}
}

class PreviewHolderManager: ObservableObject {
	@Published var classLabel: String = "Not detected"
	@Published var identity: [String : Double] = [:]
}
