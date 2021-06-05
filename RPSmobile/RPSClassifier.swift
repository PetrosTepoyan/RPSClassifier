//
//  RPSClassifier.swift
//  RPSmobile
//
//  Created by Петрос Тепоян on 6/5/21.
//

import Foundation
import CoreML
import UIKit


struct RPSClassifier {
	
	var model: RPS_classifier!
	
	init() {
		let configuration = MLModelConfiguration()
		configuration.allowLowPrecisionAccumulationOnGPU = false
		model = try! RPS_classifier(configuration: configuration)
	}
	
	func predict(image: UIImage) -> String? {
		let buffer = pixelBufferFromImage(image: image)
		let input = RPS_classifierInput(conv2d_input: buffer)
		
		let label = try? model.prediction(input: input).classLabel
		
		return label
	}
}

func pixelBufferFromImage(image: UIImage) -> CVPixelBuffer {
	func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {

		let newHeight = newWidth
		UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
		image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return newImage!
	}
	
	
	
	
	let ciimage = CIImage(image: resizeImage(image: image, newWidth: 150) )
	
	//let cgimage = convertCIImageToCGImage(inputImage: ciimage!)
	let tmpcontext = CIContext(options: nil)
	let cgimage =  tmpcontext.createCGImage(ciimage!, from: ciimage!.extent)
	
	let cfnumPointer = UnsafeMutablePointer<UnsafeRawPointer>.allocate(capacity: 1)
	let cfnum = CFNumberCreate(kCFAllocatorDefault, .intType, cfnumPointer)
	let keys: [CFString] = [kCVPixelBufferCGImageCompatibilityKey, kCVPixelBufferCGBitmapContextCompatibilityKey, kCVPixelBufferBytesPerRowAlignmentKey]
	let values: [CFTypeRef] = [kCFBooleanTrue, kCFBooleanTrue, cfnum!]
	let keysPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 1)
	let valuesPointer =  UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 1)
	keysPointer.initialize(to: keys)
	valuesPointer.initialize(to: values)
	
	let options = CFDictionaryCreate(kCFAllocatorDefault, keysPointer, valuesPointer, keys.count, nil, nil)
	
	let width = cgimage!.width
	let height = cgimage!.height
	
	var pxbuffer: CVPixelBuffer?
	// if pxbuffer = nil, you will get status = -6661
	var status = CVPixelBufferCreate(kCFAllocatorDefault, width, height,
									 kCVPixelFormatType_32BGRA, options, &pxbuffer)
	status = CVPixelBufferLockBaseAddress(pxbuffer!, CVPixelBufferLockFlags(rawValue: 0));
	
	let bufferAddress = CVPixelBufferGetBaseAddress(pxbuffer!);
	
	
	let rgbColorSpace = CGColorSpaceCreateDeviceRGB();
	let bytesperrow = CVPixelBufferGetBytesPerRow(pxbuffer!)
	let context = CGContext(data: bufferAddress,
							width: width,
							height: height,
							bitsPerComponent: 8,
							bytesPerRow: bytesperrow,
							space: rgbColorSpace,
							bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue);
	context?.concatenate(CGAffineTransform(rotationAngle: 0))
	context?.concatenate(__CGAffineTransformMake( 1, 0, 0, -1, 0, CGFloat(height) )) //Flip Vertical
	//        context?.concatenate(__CGAffineTransformMake( -1.0, 0.0, 0.0, 1.0, CGFloat(width), 0.0)) //Flip Horizontal
	
	
	context?.draw(cgimage!, in: CGRect(x:0, y:0, width:CGFloat(width), height:CGFloat(height)));
	status = CVPixelBufferUnlockBaseAddress(pxbuffer!, CVPixelBufferLockFlags(rawValue: 0));
	
	print(status)
	
	return pxbuffer!;
	
}
