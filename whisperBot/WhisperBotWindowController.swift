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

        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.5
            context.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            window.animator().setFrame(NSRect(x: screenRect.width - windowWidth, y: screenRect.height / 2 - windowHeight / 2, width: windowWidth, height: windowHeight), display: true)
        }, completionHandler: nil)
    }
}
