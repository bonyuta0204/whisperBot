//
//  WidgetWindow.swift
//  whisperBot
//
//  Created by Yuta Nakamura on 2023/04/11.
//

import Cocoa
import Foundation

class WidgetWindow: NSWindow {
    override init(contentRect _: NSRect, styleMask _: NSWindow.StyleMask, backing _: NSWindow.BackingStoreType, defer _: Bool) {
        let screenSize = NSScreen.main!.visibleFrame.size
        let initialRect = NSRect(x: screenSize.width, y: screenSize.height, width: 350, height: screenSize.height)
        super.init(contentRect: initialRect, styleMask: [.fullSizeContentView], backing: .buffered, defer: true)
        level = .floating
        collectionBehavior.insert(.fullScreenAuxiliary)
        backgroundColor = .clear
    }

    override var canBecomeKey: Bool {
        return true
    }
}
