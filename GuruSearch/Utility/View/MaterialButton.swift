//
//  MaterialButton.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/23.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit

final class MaterialButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchStartAnimation()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchEndAnimation()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touchEndAnimation()
    }
}

extension MaterialButton {

    /// ボタンに影をつける
    func commonInit() {
        self.layer.shadowOffset = CGSize(width: 1, height: 1 )
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1.0
    }

    func touchStartAnimation() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self?.alpha = 0.9
        })
    }

    func touchEndAnimation() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self?.alpha = 1
        })
    }
}
