//
//  CollectionViewController.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit

class CollectionViewController: SWFrame.CollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeService.rx
            .bind({ $0.backgroundColor }, to: self.collectionView.rx.backgroundColor)
            .disposed(by: self.rx.disposeBag)
    }

}
