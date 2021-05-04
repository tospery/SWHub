//
//  FeedbackViewController.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/2.
//

import UIKit

class FeedbackViewController: ScrollViewController, ReactorKit.View {

    lazy var mainView: FeedbackMainView = {
        let view = FeedbackMainView.init()
        view.sizeToFit()
        return view
    }()
    
    lazy var button: SWButton = {
        let button = SWButton.init(type: .custom)
        button.cornerRadius = 5
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitle(R.string.localizable.submit(), for: .normal)
        button.sizeToFit()
        button.size = .init(width: UIScreen.width - 20 * 2, height: 44)
        return button
    }()
    
    lazy var issuesButton: SWButton = {
        let button = SWButton.init(type: .custom)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitle(R.string.localizable.view(), for: .normal)
        button.sizeToFit()
        return button
    }()
    
    init(_ navigator: NavigatorType, _ reactor: FeedbackViewReactor) {
        defer {
            self.reactor = reactor
        }
        super.init(navigator, reactor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.addSubview(self.mainView)
        self.scrollView.addSubview(self.button)
        self.scrollView.addSubview(self.issuesButton)
        
        self.mainView.textView.rx.text.distinctUntilChanged()
            .map { $0?.isNotEmpty ?? false }
            .bind(to: self.button.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        self.issuesButton.rx.tap
            .subscribeNext(weak: self, type(of: self).tapIssues)
            .disposed(by: self.disposeBag)
        
        themeService.rx
            .bind({ $0.brightColor }, to: self.scrollView.rx.backgroundColor)
            .bind({ $0.primaryColor }, to: self.issuesButton.rx.titleColor(for: .normal))
            .bind({ $0.backgroundColor }, to: self.button.rx.titleColor(for: .normal))
            .bind({ UIImage.init(color: $0.primaryColor, size: self.button.size) },
                  to: self.button.rx.backgroundImage(for: .normal))
            .bind({ UIImage.init(color: $0.primaryColor.withAlphaComponent(0.8), size: self.button.size) },
                  to: self.button.rx.backgroundImage(for: .disabled))
            .disposed(by: self.rx.disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.mainView.left = 0
        self.mainView.top = 20
        self.button.left = 20
        self.button.top = self.mainView.bottom + 30
        self.issuesButton.right = self.button.right
        self.issuesButton.top = self.button.bottom + 20
    }
    
    func tapIssues(event: ControlEvent<Void>.Element) {
        self.navigator.push(Router.Issue.list.urlString)
    }
    
    func handle(isFinished: Bool) {
        self.navigator.open(Router.toast.urlString.url!.appendingQueryParameters([
            Parameter.message: R.string.localizable.feedbackSuccessful()
        ]))
        self.navigationController?.popViewController()
    }
    
}

extension Reactive where Base: FeedbackViewController {

    var subject: Binder<String?> {
        self.base.mainView.label.rx.text
    }
    
    var feedback: ControlProperty<String?> {
        self.base.mainView.textView.rx.text
    }
    
    var submit: ControlEvent<Void> {
        ControlEvent(events: self.base.button.rx.tap.map { _ in })
    }
    
}
