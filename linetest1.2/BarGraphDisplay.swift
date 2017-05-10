//
//  BarGraphDisplay.swift
//  LINES
//
//  Created by david crabtree on 5/8/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//
/*
import UIKit
import CoreLocation
import os.log

@IBDesignable class BarGraphDisplay: UIStackView {
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
       // setupButtons()
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
       // setupButtons()
    }
    
    //MARK: Properties
    private var ratingButtons = [UIView]()
    
    var BarSize1: CGSize = CGSize(width: 5.0, height: 1.0)
    var BarSize2: CGSize = CGSize(width: 5.0, height: 2.0)
    var BarSize3: CGSize = CGSize(width: 5.0, height: 3.0)
    var BarSize4: CGSize = CGSize(width: 5.0, height: 4.0)
    var BarSize5: CGSize = CGSize(width: 5.0, height: 5.0)
    var BarSize6: CGSize = CGSize(width: 5.0, height: 6.0)
    var BarSize7: CGSize = CGSize(width: 5.0, height: 7.0)
    var BarSize8: CGSize = CGSize(width: 5.0, height: 8.0)
    var BarSize9: CGSize = CGSize(width: 5.0, height: 9.0)
    var BarSize10: CGSize = CGSize(width: 5.0, height: 10.0)
   //var BarSize1: CGSize = CGSize(width: 10.0, height: 5.0)

    
    @IBInspectable var starSize: CGSize = CGSize(width: 10.0, height: 15.0){
        didSet {
          //  setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 12 {
        didSet {
          //  setupButtons()
        }
    }
    var rating = 0
    
    
    private func setupButtons() {
        
        // clear any existing buttons
       // for button in ratingButtons {
        //    removeArrangedSubview(button)
        //    button.removeFromSuperview()
        //}
        //ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar1 = UIImage(named: "green1", in: bundle, compatibleWith: self.traitCollection)
        let filledStar2 = UIImage(named: "green2", in: bundle, compatibleWith: self.traitCollection)
        let filledStar3 = UIImage(named: "orange1", in: bundle, compatibleWith: self.traitCollection)
        let filledStar4 = UIImage(named: "red1", in: bundle, compatibleWith: self.traitCollection)
        let filledStar5 = UIImage(named: "red2", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyCircle", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"selectedCircle", in: bundle, compatibleWith: self.traitCollection)
        
        
        for _ in 0..<starCount {
            
            // Create the button
            let button = UIView()
            
            button.backgroundColor = #colorLiteral(red: 0, green: 0.5694751143, blue: 1, alpha: 1)
            
            button.sizeThatFits(BarSize1)
            
            /*
            // Set the button images
        //    button.setImage(emptyStar, for: .normal)
           button.setImage(filledStar1, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
        button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            if ratingButtons.count == 0 {
                button.setImage(filledStar1, for: .selected)
            }
            if ratingButtons.count == 1 {
                button.setImage(filledStar2, for: .selected)
            }
            if ratingButtons.count == 2 {
                button.setImage(filledStar3, for: .selected)
            }
            if ratingButtons.count == 3 {
                button.setImage(filledStar4, for: .selected)
            }
            if ratingButtons.count == 4 {
                button.setImage(filledStar5, for: .selected)
            }
            if ratingButtons.count == 5 {
                button.setImage(filledStar5, for: .selected)
            }
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Setup the button action
            button.addTarget(self, action: #selector(TriangleRatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Add the button to the stack
            addArrangedSubview(button)
            
            // Add the new button to the rating button array
            ratingButtons.append(button)
            
        }
        updateButtonSelectionStates()
             
 */
        }
        
    }

    
    
    
    
    
}
 */
