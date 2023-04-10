//
//  WidgetWindow.swift
//  whisperBot
//
//  Created by Yuta Nakamura on 2023/04/11.
//

import Foundation
import Cocoa

class WidgetWindow: NSWindow {

    override init(contentRect:NSRect, styleMask:NSWindow.StyleMask, backing: NSWindow.BackingStoreType,defer: Bool) {
    let screenSize = NSScreen.main!.visibleFrame.size
    let initialRect = NSRect(x: screenSize.width, y: screenSize.height, width: 350, height: screenSize.height)
    super.init(contentRect: initialRect, styleMask: [.fullSizeContentView], backing: .buffered, defer: true)
    self.level = .floating
    self.collectionBehavior.insert(.fullScreenAuxiliary)
    self.backgroundColor = .clear
  }

  override var canBecomeKey: Bool {
    return true
  }

}
