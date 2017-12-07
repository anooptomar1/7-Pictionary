//
//  GyroManager.swift
//  Flip_Motion_Example
//
//  Created by Justin Wilson on 11/31/17.
//  Copyright © 2017 Justin Wilson. All rights reserved.
//

import Foundation
import CoreMotion

class GyroManager {
	typealias Callback = ()->Void
	private var flipUpCallback: Callback?
	private var flipDownCallback: Callback?
	
	var manager: CMMotionManager
	var isWaitingForMotion = false
	
	init() {
		let cmQueue = OperationQueue()
		manager = CMMotionManager()
		
		//Setup CoreMotion flip detection and start polling
		guard manager.isDeviceMotionAvailable else {
			print("Warning: device motion unavailable.")
			return
		}
		
		manager.deviceMotionUpdateInterval = 0.02
		
		manager.startDeviceMotionUpdates(to: cmQueue) { (data, error) in
			guard self.isWaitingForMotion else {
				return
			}
			guard
				let x = data?.rotationRate.x, // Lateral axis rotation rate
				let z = data?.userAcceleration.z // Normal axis acceleration
			else {
				print("Warning: could not parse CoreMotion data.")
				return
			}
			
			if z < -0.2 && x < -3.0 {
				// Flip up
				self.flipDispatch(callbackFunc: self.flipUpCallback)
				
				// Debug print statments
				print("Flip Up\nx: " + String(x))
				print("z: " + String(z) + "\n")
				
			} else if z > 0.4 && x > 6.0 {
				// Flip down
				self.flipDispatch(callbackFunc: self.flipDownCallback)
				
				// Debug print statments
				print("Flip Down\nx: " + String(x))
				print("z: " + String(z) + "\n")
				
			}
		}
		
		isWaitingForMotion = true
	}
	
	private func flipDispatch(callbackFunc callback: Callback?) {
		DispatchQueue.main.async {
			if let callback = callback { callback() }
			
			self.isWaitingForMotion = false // not waiting for motion - debounce
			
			//Start Timer to resume waiting for motion - debounce (run on main queue)
			Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false, block: { timer in
				self.isWaitingForMotion = true
			})
			/** NOTE: Once an timer is invalidated it cannot be reused per the API,
			thus a new Timer is created every time. "Once invalidated, timer objects
			cannot be reused."  An interval timer does not work here. **/
		}
	}
	
	func listen() {
		manager.startGyroUpdates()
		manager.startAccelerometerUpdates()
	}
	
	func stop() {
		manager.stopGyroUpdates()
		manager.stopAccelerometerUpdates()
	}
	
	func onFlipUp(_ callback: @escaping Callback) {
		flipUpCallback = callback
	}
	
	func onFlipDown(_ callback: @escaping Callback) {
		flipDownCallback = callback
	}
}
