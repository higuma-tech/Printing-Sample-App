//
//  PrintingView.swift
//  Printing Sample App
//
//  Created by Masamichi Ebata on 2024/07/09.
//

import AppKit

class PrintingView: NSView {
    
    override func beginPage(in rect: NSRect, atPlacement location: NSPoint) {
        print("PrintingView.beginPage")
        super.beginPage(in: rect, atPlacement: location)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        print("PrintingView.draw")
        let printOp = NSPrintOperation.current!
        let printInfo = printOp.printInfo

        print(printInfo.paperSize)
        print(printInfo.imageablePageBounds)
        
        let width = printInfo.paperSize.width - printInfo.leftMargin - printInfo.rightMargin
        let height = printInfo.paperSize.height - printInfo.topMargin - printInfo.bottomMargin
                
        let drawingRect = NSMakeRect(0.0, 0.0, width-1.0, height-1.0)
        let pathDrwaingRect = NSBezierPath.init(rect: drawingRect)
        pathDrwaingRect.stroke()
        
        let pathTLtoBR = NSBezierPath.init();
        pathTLtoBR.move(to: NSMakePoint(drawingRect.origin.x, drawingRect.origin.y + drawingRect.height))
        pathTLtoBR.line(to: NSMakePoint(drawingRect.origin.x + drawingRect.size.width,  drawingRect.origin.y))
        pathTLtoBR.stroke()
        
        let pathTRtoBL = NSBezierPath.init();
        pathTRtoBL.move(to: NSMakePoint(drawingRect.origin.x + drawingRect.size.width, drawingRect.origin.y + drawingRect.size.height))
        pathTRtoBL.line(to: NSMakePoint(drawingRect.origin.x,  drawingRect.origin.y))
        pathTRtoBL.stroke()
        
        let path01 = NSBezierPath.init();
        path01.move(to: NSMakePoint(drawingRect.origin.x + drawingRect.size.width/2.0, drawingRect.origin.y + drawingRect.size.height))
        path01.line(to: NSMakePoint(drawingRect.origin.x + drawingRect.size.width/2.0,  drawingRect.origin.y + drawingRect.size.height/2.0))
        path01.stroke()

        let path02 = NSBezierPath.init();
        path02.move(to: NSMakePoint(drawingRect.origin.x, drawingRect.origin.y + drawingRect.size.height/2.0))
        path02.line(to: NSMakePoint(drawingRect.origin.x + drawingRect.size.width/2.0,  drawingRect.origin.y + drawingRect.size.height/2.0))
        path02.stroke()
        
    }
    
    override func drawPageBorder(with borderSize: NSSize) {
        print("PrintingView.drawPageBorder")
    }
    
    override func drawSheetBorder(with borderSize: NSSize) {
        print("PrintingView.drawSheetBorder")
    }
    
    override func knowsPageRange(_ range: NSRangePointer) -> Bool {
        print("PrintingView.knowsPageRange")

        // If knowsPageRange returns true, rectForPage is invoked later.
        var rangeOut = NSRange(location: 0, length: 0)
        
        // Pages are 1-based. That is, the first page is 1.
        rangeOut.location = 1
        rangeOut.length = 1     // Number of pages
        
        // Return the newly constructed range, rangeOut, via the range pointer
        range.pointee = rangeOut
        
        // adjust margins
        let printOp = NSPrintOperation.current!
        let printInfo = printOp.printInfo
        let paperSize = printInfo.paperSize
        let imageablePageBounds = printInfo.imageablePageBounds;
        
        printInfo.leftMargin = imageablePageBounds.origin.x
        printInfo.rightMargin = paperSize.width - imageablePageBounds.origin.x - imageablePageBounds.size.width
        printInfo.topMargin = paperSize.height - imageablePageBounds.origin.y - imageablePageBounds.size.height
        printInfo.bottomMargin = imageablePageBounds.origin.y
        printOp.printInfo = printInfo

        // adjust frameRect
        let frameRectWidth = printInfo.paperSize.width - printInfo.leftMargin - printInfo.rightMargin
        let frameRectHeight = printInfo.paperSize.height - printInfo.topMargin - printInfo.bottomMargin
        let frameRect = NSMakeRect(0.0, 0.0, frameRectWidth, frameRectHeight)
        self.frame = frameRect
        
        return true
    }
    
    override func rectForPage(_ page: Int) -> NSRect {
        print("PrintingView.rectForPage")
        // If knowsPageRange returns true, rectForPage is invoked.
        // It tempolary returns paperSize.
        let printOp = NSPrintOperation.current!
        let printInfo = printOp.printInfo
        
        let width = printInfo.paperSize.width - printInfo.leftMargin - printInfo.rightMargin
        let height = printInfo.paperSize.height - printInfo.topMargin - printInfo.bottomMargin
        let rect = NSMakeRect(0.0, 0.0, width, height)          // always return the same size
        
        return rect
    }
    
    override func adjustPageHeightNew(_ newBottom: UnsafeMutablePointer<CGFloat>, top oldTop: CGFloat, bottom oldBottom:                             CGFloat, limit bottomLimit: CGFloat) {
        print("PrintingView.adjustPageHeightNew")
        super.adjustPageHeightNew(newBottom, top: oldTop, bottom: oldBottom, limit: bottomLimit)
    }

    override func adjustPageWidthNew(_ newRight: UnsafeMutablePointer<CGFloat>, left oldLeft: CGFloat, right oldRight: CGFloat, limit rightLimit: CGFloat) {
        print("PrintingView.adjustPageWidthNew")
        super.adjustPageWidthNew(newRight, left: oldLeft, right: oldRight, limit: rightLimit)
    }
}
