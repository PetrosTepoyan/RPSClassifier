//
//  RPSClassifierGray.swift
//  RPSmobile
//
//  Created by Петрос Тепоян on 6/5/21.
//

import Foundation
import UIKit
import CoreML


struct RPSClassifierGray {
	
	var model: RPS_classifier_gray!
	
	init() {
		let configuration = MLModelConfiguration()
		configuration.allowLowPrecisionAccumulationOnGPU = false
		model = try! RPS_classifier_gray(configuration: configuration)
	}
	
	func predict(image: UIImage) -> String? {
		let grayBuffer = pixelBufferGray(image: image)
		
		let input = RPS_classifier_grayInput(conv2d_21_input: grayBuffer!)
		
		let label = try? model.prediction(input: input).classLabel
		
		return label
	}
}

public func pixelBufferGray(image: UIImage, width: Int = 150, height: Int = 150) -> CVPixelBuffer? {
	
	var pixelBuffer : CVPixelBuffer?
	let attributes = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue]
	
	let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(width), Int(height), kCVPixelFormatType_OneComponent8, attributes as CFDictionary, &pixelBuffer)
	
	guard status == kCVReturnSuccess, let imageBuffer = pixelBuffer else {
		return nil
	}
	
	CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
	
	let imageData =  CVPixelBufferGetBaseAddress(imageBuffer)
	
	guard let context = CGContext(data: imageData,
								  width: Int(width),
								  height:Int(height),
								  bitsPerComponent: 8,
								  bytesPerRow: CVPixelBufferGetBytesPerRow(imageBuffer),
								  space: CGColorSpaceCreateDeviceGray(),
								  bitmapInfo: CGImageAlphaInfo.none.rawValue) else {
		return nil
	}
	
	context.translateBy(x: 0, y: CGFloat(height))
	context.scaleBy(x: 1, y: -1)
	let ciimage = CIImage(image: image)
	let tmpcontext = CIContext(options: nil)
	let cgimage =  tmpcontext.createCGImage(ciimage!, from: ciimage!.extent)
	
	context.draw(cgimage!, in: CGRect(x:0, y:0, width:CGFloat(width), height:CGFloat(height)))
	UIGraphicsPushContext(context)
	UIGraphicsPopContext()
	CVPixelBufferUnlockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
	
	return imageBuffer
	
}
