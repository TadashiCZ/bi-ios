//
//  ViewController.swift
//  HW1
//
//  Created by Tadeáš on 15/11/2019.
//  Copyright © 2019 Tadeáš. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var redColor : Float = 100.0
    var greenColor : Float = 100.0
    var blueColor : Float = 100.0
    var movableStatus : Bool = false
    var circleRadius : Double = 50
    var panGesture = UIPanGestureRecognizer()
    
    @IBOutlet weak var stepperLabel: UITextView!
    
    @IBOutlet weak var stepperControl: UIStepper!
    
    @IBOutlet weak var switcherControl: UISwitch!
    
    @IBOutlet weak var greenSliderControl: UISlider!
    
    @IBOutlet weak var blueSliderControl: UISlider!
    
    @IBOutlet weak var redSliderControl: UISlider!
    
    @IBOutlet weak var areaView: UIView!
    
    var circleView : UIView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleRadius = stepperControl.value
        stepperLabel.text = String(Int(circleRadius.rounded()))
        
        circleView = UIView(frame: CGRect(
            x: 120,
            y: 216,
            width: CGFloat(circleRadius*2),
            height: CGFloat(circleRadius*2)
        ))
        
        circleView!.layer.cornerRadius = CGFloat(circleRadius)
        areaView.addSubview(circleView!)
        updateCircleColor()
        updateBackgroundColor()
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.draggedView(_:)))
        circleView!.isUserInteractionEnabled = true
        circleView!.addGestureRecognizer(panGesture)
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        correctPosition()
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        self.view.bringSubviewToFront(circleView!)
        let translation = sender.translation(in: self.view)
        
        correctPosition(translationX: translation.x, translationY: translation.y)
        circleView!.center = CGPoint(x: circleView!.center.x + translation.x, y: circleView!.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func correctPosition(translationX : CGFloat = CGFloat(0), translationY : CGFloat = CGFloat(0)){
        if (circleView!.layer.position.x + circleView!.bounds.size.width/2 + translationX > areaView.bounds.size.width) {
            circleView!.center.x = areaView.bounds.size.width - circleView!.bounds.size.width/2
        }
        
        if (circleView!.center.x - circleView!.bounds.size.width/2 + translationX < 0) {
            circleView!.center.x = circleView!.bounds.size.width/2
        }
        
        if (circleView!.center.y - circleView!.bounds.size.height/2 + translationY < 0) {
            circleView!.center.y = circleView!.bounds.size.height/2
        }
        
        if (circleView!.layer.position.y + circleView!.bounds.size.height/2 + translationY > areaView.bounds.size.height) {
            circleView!.center.y = areaView.bounds.size.height - circleView!.bounds.size.height/2
        }
    }
    
    func updateCircleColor(){
        circleView!.backgroundColor = UIColor(
            red: CGFloat(redColor/255),
            green: CGFloat(greenColor/255),
            blue: CGFloat(blueColor/255),
            alpha: 1.0)
    }
    
    func updateBackgroundColor(){
        areaView.backgroundColor = UIColor(
            red: CGFloat((255-redColor)/255),
            green: CGFloat((255-greenColor)/255),
            blue: CGFloat((255-blueColor)/255),
            alpha: 1.0)
    }
    
    func updateCircleSize(){
        let newView = UIView(frame: CGRect(
            x: circleView!.frame.minX,
            y: circleView!.frame.minY,
            width: CGFloat(circleRadius*2),
            height: CGFloat(circleRadius*2)
        ))
        newView.layer.cornerRadius = CGFloat(circleRadius)
        areaView.addSubview(newView)
        circleView!.removeFromSuperview()
        circleView = newView
        updateCircleColor()
        circleView!.addGestureRecognizer(panGesture)
        correctPosition()
    }
    
    @IBAction func switcherValueChanged(_ sender: Any) {
        if (switcherControl.isOn){
            movableStatus = true
            circleView!.addGestureRecognizer(panGesture)
        } else {
            movableStatus = false
            circleView!.removeGestureRecognizer(panGesture)
        }
    }
    @IBAction func stepperValueChanged(_ sender: Any) {
        circleRadius = stepperControl.value
        stepperLabel.text = String(Int(circleRadius.rounded()))
        updateCircleSize()
    }
    
    @IBAction func sliderRedValueChanged(_ sender: Any) {
        redColor = redSliderControl.value
        updateCircleColor()
        updateBackgroundColor()
    }
    @IBAction func sliderGreenValueChanged(_ sender: Any) {
        greenColor = greenSliderControl.value
        updateCircleColor()
        updateBackgroundColor()
    }
    @IBAction func sliderBlueValueChanged(_ sender: Any) {
        blueColor = blueSliderControl.value
        updateCircleColor()
        updateBackgroundColor()
    }
    
    
}

