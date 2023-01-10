//
//  AppDelegate.swift
//  gpt-chatbot
//
//  Created by 佐々木良 on 1/6/23.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    let persistenceController = PersistenceController.shared

    @MainActor func applicationDidFinishLaunching(_: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let statusButton = statusItem.button {
            statusButton.image = NSImage(
                systemSymbolName: "chart.line.uptrend.xyaxis.circle",
                accessibilityDescription: "Chart Line"
            )
            statusButton.action = #selector(togglePopover)
            statusButton.sendAction(on: [.leftMouseUp, .rightMouseUp])

            popover = NSPopover()
            popover.contentSize = NSSize(width: 300, height: 300)
            popover.behavior = .transient
            popover.animates = true
            popover.contentViewController = NSHostingController(rootView: MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            )
        }
        // Use this for inspecting the Core Data
        if let directoryLocation = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print("Documents Directory: \(directoryLocation)Application Support")
        }
    }

    @objc func togglePopover(sender _: NSStatusBarButton) {
        let event = NSApp.currentEvent!

        if event.type == NSEvent.EventType.leftMouseUp {
            if let button = statusItem.button {
                if popover.isShown {
                    popover.performClose(nil)
                } else {
                    popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                }
            }
        } else if event.type == NSEvent.EventType.rightMouseUp {
            let menu = NSMenu()
            menu.addItem(withTitle: "Quit", action: #selector(quitApp), keyEquivalent: "q")
            statusItem.menu = menu
            statusItem.button?.performClick(nil)
            statusItem.menu = nil
        }
    }

    @objc func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}
