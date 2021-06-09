//
//  MenuHeaderView.swift
//  SWHub
//
//  Created by liaoya on 2021/5/21.
//

import UIKit

class MenuHeaderView: BaseSupplementaryView {
    
    lazy var label: SWFLabel = {
        let label = SWFLabel.init(frame: .zero)
        label.font = .bold(18)
        label.sizeToFit()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.label)
        themeService.rx
            .bind({ $0.foregroundColor }, to: self.label.rx.textColor)
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.sizeToFit()
        self.label.left = 10
        self.label.bottom = self.height
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.label.text = nil
    }

}
