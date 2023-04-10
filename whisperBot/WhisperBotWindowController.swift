//
//  WhisperBotWindowController.swift
//  whisperBot
//
//  Created by Yuta Nakamura on 2023/04/11.
//

import Cocoa

class WhisperBotWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
    }

    func showWindowWithAnimation() {
        guard let window = window else { return }
        let screenRect = NSScreen.main?.frame ?? NSRect.zero
        let windowWidth: CGFloat = 400
        let windowHeight: CGFloat = 600
        let windowRect = NSRect(x: screenRect.width, y: screenRect.height / 2 - windowHeight / 2, width: windowWidth, height: windowHeight)
        window.setFrame(windowRect, display: true)
        print("window \(window)") // Add this line
        print("window frame: \(window.frame)") // Add this line
        print("window isVisible: \(window.isVisible)") // Add this line
        window.makeKeyAndOrderFront(nil) // Add this line to make the window key and visible
        print("window isVisible: \(window.isVisible)") // Add this line
        NSAnimationContext.runAnimationGroup({ context in
            print("animation block called") // Add this line
            context.duration = 2
            context.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            window.animator().setFrame(NSRect(x: screenRect.width - windowWidth, y: screenRect.height / 2 - windowHeight / 2, width: windowWidth, height: windowHeight), display: true)
        }, completionHandler: nil)
    }
}
