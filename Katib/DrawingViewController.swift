//
//  DrawingViewController.swift
//  Katib
//
//  Created by Omar Rayyan on 24/05/2022.
//

import UIKit
import MaLiang

class DrawingViewController: UIViewController {

    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var drawingCanvas: Canvas!
    override func viewDidLoad() {
        super.viewDidLoad()
        drawingCanvas.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        drawingCanvas.layer.borderWidth = 1.5
        drawingCanvas.layer.cornerRadius = drawingCanvas.frame.height/50
        drawingCanvas.currentBrush.pointSize = 10
        undoButton.layer.borderColor = CGColor(red: 148/255, green: 17/255, blue: 0, alpha: 1)
        undoButton.layer.borderWidth = 1.5
        undoButton.layer.cornerRadius = undoButton.frame.height/50
        doneButton.layer.cornerRadius = doneButton.frame.height/2
        undoButton.layer.cornerRadius = undoButton.frame.height/2
        clearButton.layer.cornerRadius = clearButton.frame.height/2
        doneButton.isUserInteractionEnabled = false
        doneButton.alpha = 0.75

    }
    
    @IBAction func clickedUndo(_ sender: Any) {
        drawingCanvas.undo()
    }
    
    @IBAction func clickedClear(_ sender: Any) {
        drawingCanvas.clear()
        doneButton.isUserInteractionEnabled = false
        doneButton.alpha = 0.75
    }
    

}
