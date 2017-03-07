//
//  AppDelegate.swift
//  SampleOSX
//
//  Created by Alexander Ivlev on 04.10.16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

import Cocoa
import DITranquillity

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		let builder = DIContainerBuilder()
		register(builder: builder)
		let container = try! builder.build()
		
		let storyboard: NSStoryboard = try! *container
		
		let viewController = storyboard.instantiateInitialController() as! NSViewController
		
		let window = NSApplication.shared().windows.first
		window?.contentViewController = viewController
	}	
	
	private func register(builder: DIContainerBuilder) {
    builder.register(type: NSStoryboard.self)
			.initial { DIStoryboard(name: "ViewControllers", bundle: nil, container: $0) }
		
		builder.register(vc: ViewController.self)
			.injection { (_, self) in self.buttonName = "Next" }
		
		builder.register(vc: NextViewController.self)
			.injection { (_, self) in self.inject = 10 }
		
	}


}

