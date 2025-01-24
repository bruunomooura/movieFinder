//
//  UIButton+Extensions.swift
//  MovieFinder
//
//  Created by Bruno Moura on 18/01/25.
//

import UIKit

extension UIButton {
    // MARK: Animate button tap
    /// Animates the button tap by scaling it down slightly and reducing its opacity,
    /// then restoring it to its original size and opacity after a short delay.
    ///
    /// This creates a tactile feedback effect, improving the user experience during button interactions.
    public func animateTap() {
        animateScaleDown()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            self.animateScaleUp()
        }
    }
    
    // MARK: Scale down the button
    /// Scales the button down to 95% of its original size and reduces its opacity to 50%.
    ///
    /// This animation is triggered as part of the tap effect to provide visual feedback
    /// that the button has been pressed.
    private func animateScaleDown() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.alpha = 0.5
        }
    }
    
    // MARK: Scale up the button
    /// Restores the button to its original size and opacity.
    ///
    /// This animation occurs after the scale-down effect, bringing the button back to
    /// its normal state after the user releases the tap.
    private func animateScaleUp() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform.identity
            self.alpha = 1.0
        }
    }
    
    /// Animates the `imageView` with a bounce effect.
    ///
    /// This method scales the `imageView` to 1.2x its original size and then returns it to its original scale,
    /// creating a bounce animation effect. The animation duration for both scaling up and scaling back is 0.2 seconds.
    ///
    /// - Note: If `imageView` is `nil`, this method does nothing.
    public func animateImageBounce() {
        guard let imageView = self.imageView else { return }
        
        imageView.transform = CGAffineTransform.identity
        
        UIView.animate(withDuration: 0.2,
                       animations: {
            imageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.2) {
                imageView.transform = CGAffineTransform.identity
            }
        })
    }
}

