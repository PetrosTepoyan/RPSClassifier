//
//  ContentView.swift
//  RPSmobile
//
//  Created by Петрос Тепоян on 6/4/21.
//

import SwiftUI

struct ContentView: View {
	
	@StateObject var classLabelObserved: PreviewHolderManager = PreviewHolderManager()
	@State var label = ""
	
    var body: some View {
		ZStack {
			PreviewHolder(manager: classLabelObserved)
				.onReceive(classLabelObserved.$classLabel, perform: { classLabel in
					updateLabel(classLabel)
				})
			
			VStack {
				Spacer()
				
				Text(label)
					.foregroundColor(.white)
					.padding()
					.background(
						RoundedRectangle(cornerRadius: 15)
							.opacity(0.7)
					)
					.padding(.bottom, 50)
			}
			
			
		}.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
	
	func updateLabel(_ text: String) {
		DispatchQueue.main.async {
			label = text
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
