//
//  sizeZeroWhenHiddenView.swift
//  Particuliers
//
//  Created by simo ghrissi on 10/27/17.
//  Copyright © 2017 Engie Mobility. All rights reserved.
//

import UIKit
/// Vue qui prend une hauteur et / ou largeur zero quand masquée

class SizeZeroWhenHiddenView: UIView {
 
    /// mettre à false pour désactiver la contrainte sur la hauteur
    var heightZero = true
    
    /// mettre à false pour désactiver la contrainte sur la largeur
    var widthZero = true
    private var originalHeightConstraintConstant: CGFloat? = 10
    private var originalWidthConstraintConstant: CGFloat?
    private lazy var heightConstraintZero: NSLayoutConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:[view(0)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self] as [String:UIView]).first!
    
    private lazy var widthConstraintZero: NSLayoutConstraint = NSLayoutConstraint.constraints(withVisualFormat: "[view(0)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self] as [String:UIView]).first!
    private func findSizeConstraint(dimension: NSLayoutAttribute) -> NSLayoutConstraint? {
        for constraint in constraints as [NSLayoutConstraint] {
            // on cherche contrainte sur la dimension
            if constraint.secondItem == nil && constraint.firstAttribute == dimension {
                return constraint
            }
        }
        return nil
    }
    private func changeConstraint(sizeConstraintZero: NSLayoutConstraint, dimension: NSLayoutAttribute, storedConstant: inout CGFloat?) {
        let existingConstraint = findSizeConstraint(dimension: dimension)
        if isHidden {
            // s'il y a une contrainte on sauvegarde sa valeur et on la met à 0
            if let constraint = existingConstraint {
                storedConstant = constraint.constant
                constraint.constant = 0
            }
                // sinon on rajoute une contrainte de hauteur zero
            else {
                addConstraint(sizeConstraintZero)
            }
        }
        else {
            if let constraint = existingConstraint {
                if let constant = storedConstant {
                    constraint.constant = constant
                }
                else {
                    removeConstraint(constraint)
                }
            }
                // normalement ne doit pas arriver car existingConstraint = sizeConstraintZero
            else {
                removeConstraint(sizeConstraintZero)
            }
        }
    }
    
    override var isHidden: Bool {
        didSet {
            if isHidden != oldValue {
                if heightZero {
                    changeConstraint(sizeConstraintZero: heightConstraintZero, dimension: .height, storedConstant: &originalHeightConstraintConstant)
                }
                if widthZero {
                    changeConstraint(sizeConstraintZero: widthConstraintZero, dimension: .width, storedConstant: &originalWidthConstraintConstant)
                }
            }
        }
    }
    
}
