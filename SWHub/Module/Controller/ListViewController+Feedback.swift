//
//  ListViewController+Feedback.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/29.
//

import UIKit

extension ListViewController {
    
    @objc func handleIssueWhenFeedback(_ data: Any) {
        self.navigator.open(
            Router.urlString(host: .toast).url!.appendingQueryParameters(
                [
                    Parameter.message: R.string.localizable.tipsSuccess(R.string.localizable.feedback())
                ]
            )
        )
        self.navigationController?.popViewController()
    }
    
}
