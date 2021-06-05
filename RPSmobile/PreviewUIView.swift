//
//  PreviewUIView.swift
//  RPSmobile
//
//  Created by Петрос Тепоян on 6/5/21.
//
import SwiftUI
import UIKit
import AVFoundation

protocol PreviewViewDelegate  {
	func didPredictLabel(_ label: String)
}

class PreviewView: UIView {
	private var captureSession: AVCaptureSession?
	let model = RPSClassifier()
	let dispatch_queue = DispatchQueue(__label: "streamoutput", attr: nil)
	
	var delegate: PreviewViewDelegate?
	
	
	
	init() {
		super.init(frame: .zero)
		
		var allowedAccess = false
		let blocker = DispatchGroup()
		blocker.enter()
		AVCaptureDevice.requestAccess(for: .video) { flag in
			allowedAccess = flag
			blocker.leave()
		}
		blocker.wait()
		
		if !allowedAccess {
			print("!!! NO ACCESS TO CAMERA")
			return
		}
		
		// setup session
		let session = AVCaptureSession()
		session.beginConfiguration()
		
		let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
												  for: .video, position: .unspecified) //alternate AVCaptureDevice.default(for: .video)
		guard videoDevice != nil, let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), session.canAddInput(videoDeviceInput) else {
			print("!!! NO CAMERA DETECTED")
			return
		}
		session.addInput(videoDeviceInput)
		session.commitConfiguration()
		self.captureSession = session
		
		let output : AVCaptureVideoDataOutput = AVCaptureVideoDataOutput()
		
		
		output.setSampleBufferDelegate(self, queue: dispatch_queue)
		
		session.addOutput(output)
	}
	
	override class var layerClass: AnyClass {
		AVCaptureVideoPreviewLayer.self
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	var videoPreviewLayer: AVCaptureVideoPreviewLayer {
		return layer as! AVCaptureVideoPreviewLayer
	}
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		
		if nil != self.superview {
			self.videoPreviewLayer.session = self.captureSession
			self.videoPreviewLayer.videoGravity = .resizeAspect
			self.captureSession?.startRunning()
		} else {
			self.captureSession?.stopRunning()
		}
	}
}

extension PreviewView : AVCaptureVideoDataOutputSampleBufferDelegate {
	func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
		if let cvImageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
			let ciimage = CIImage(cvImageBuffer: cvImageBuffer)
			let context = CIContext()
			
			if let cgImage = context.createCGImage(ciimage, from: ciimage.extent) {
				let uiImage = UIImage(cgImage: cgImage)
				onReceivedImage(uiImage)
			}
		}
	}
	
	func onReceivedImage(_ image: UIImage) {
		guard let label = model.predict(image: image) else {
			return
		}
		delegate?.didPredictLabel(label)
	}
}
