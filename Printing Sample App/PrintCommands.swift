//
//  PrintCommands.swift
//  Printing Sample App
//
//  Created by Masamichi Ebata on 2024/07/08.
//

import SwiftUI
import AppKit

struct PrintCommands: Commands {
    var body: some Commands {
        CommandGroup(replacing: .printItem) {
            Section {
                Button("Print…") {
                    startPrinting()
                }
            }
        }
    }
    
    private func startPrinting() {
        
        let printInfo = NSPrintInfo.shared
        let paperSize = printInfo.paperSize
        let frameRect = NSMakeRect(0.0, 0.0, paperSize.width - printInfo.leftMargin - printInfo.rightMargin, paperSize.height - printInfo.topMargin - printInfo.bottomMargin)
        let printingView = PrintingView(frame: frameRect)

        let aView = NSHostingView(rootView: ContentView())
        aView.frame = frameRect
        printingView.addSubview(aView)
        
        let printOperation = NSPrintOperation(view: printingView, printInfo: printInfo)
        printOperation.printPanel = NSPrintPanel()
        printOperation.printPanel.options.insert(.showsPaperSize)
        printOperation.printPanel.options.insert(.showsOrientation)
        printOperation.printPanel.options.insert(.showsScaling)
        printOperation.printPanel.options.insert(.showsPreview)

        printOperation.run()
    }
}
