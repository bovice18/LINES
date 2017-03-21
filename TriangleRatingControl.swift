//
//  TriangleRatingControl.swift
//  LINES
//
//  Created by david crabtree on 3/12/17.
//  Copyright © 2017 david crabtree. All rights reserved.
//

import UIKit
import CoreLocation
import os.log

@IBDesignable class TriangleRatingControl: UIStackView {
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Properties
    private var ratingButtons = [UIButton]()

    @IBInspectable var starSize: CGSize = CGSize(width: 88.0, height: 88.0){
    didSet {
    setupButtons()
    }
    }

    @IBInspectable var starCount: Int = 4 {
    didSet {
    setupButtons()
    }
    }
    @IBInspectable var starSizeSelected: CGSize = CGSize(width: 88.0, height: 88.0){    didSet {
    setupButtons()
    }
}
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
  
    //MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
            guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
    
    //MARK: Private Methods
    private func setupButtons() {
        
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
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
        let button = UIButton()
            
            // Set the button images
            button.setImage(emptyStar, for: .normal)
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
}
    
    private func updateButtonSelectionStates() {

        for (index, button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index == rating - 1
            
            // Set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            // Calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
      
            // Assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
}
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}