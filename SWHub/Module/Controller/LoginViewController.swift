//
//  LoginViewController.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit
import SafariServices

class LoginViewController: ScrollViewController, ReactorKit.View {
        
    lazy var sloganLabel: SWLabel = {
        let label = SWLabel.init()
        label.font = .systemFont(ofSize: 18)
        label.text = R.string.localizable.loginSlogan(UIApplication.shared.name)
        label.sizeToFit()
        return label
    }()
    
    lazy var privacyLabel: SWLabel = {
        let label = SWLabel.init()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        label.text = R.string.localizable.loginPrivacy(UIApplication.shared.name)
        label.qmui_lineHeight = (label.qmui_lineHeight + 2).flat
        label.size = label.sizeThatFits(
            .init(
                width: UIScreen.width - 20 * 2,
                height: .greatestFiniteMagnitude
            )
        )
        return label
    }()
    
    lazy var authLabel: SWLabel = {
        let label = SWLabel.init()
        label.font = .systemFont(ofSize: 12)
        label.text = R.string.localizable.loginAuth()
        label.sizeToFit()
        return label
    }()
    
    lazy var errorLabel: SWLabel = {
        let label = SWLabel.init()
        label.font = .systemFont(ofSize: 11)
        label.sizeToFit()
        label.height = 25
        return label
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = R.image.appLogo()
        imageView.sizeToFit()
        return imageView
    }()
    
    lazy var tokenTextField: UITextField = {
        let textField = UITextField.init()
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 15)
        textField.placeholder = R.string.localizable.loginPlaceholderToken()
        textField.sizeToFit()
        return textField
    }()
    
    lazy var loginButton: SWButton = {
        let button = SWButton.init(type: .custom)
        button.cornerRadius = 4
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitle(R.string.localizable.login(), for: .normal)
        button.sizeToFit()
        return button
    }()
    
    lazy var authButton: SWButton = {
        let button = SWButton.init(type: .custom)
        button.setImage(R.image.github(), for: .normal)
        button.sizeToFit()
        return button
    }()
    
    init(_ navigator: NavigatorType, _ reactor: LoginViewReactor) {
        defer {
            self.reactor = reactor
        }
        super.init(navigator, reactor)
        self.hidesNavigationBar = reactor.parameters[Parameter.hideNavBar] as? Bool ?? true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.addSubview(self.sloganLabel)
        self.scrollView.addSubview(self.privacyLabel)
        self.scrollView.addSubview(self.authLabel)
        self.scrollView.addSubview(self.errorLabel)
        self.scrollView.addSubview(self.loginButton)
        self.scrollView.addSubview(self.authButton)
        self.scrollView.addSubview(self.logoImageView)
        self.scrollView.addSubview(self.tokenTextField)
        
        self.authButton.rx.tap
            .subscribeNext(weak: self, type(of: self).oauth)
            .disposed(by: self.disposeBag)
        
        let buttonSize = CGSize.init(
            width: UIScreen.width - 20 * 2,
            height: 44.f
        )
        themeService.rx
            .bind({ $0.headerColor }, to: [
                self.privacyLabel.rx.textColor,
                self.authLabel.rx.textColor
            ])
            .bind({ $0.titleColor }, to: [
                self.sloganLabel.rx.textColor,
                self.tokenTextField.rx.textColor
            ])
            .bind({ $0.special1Color }, to: self.errorLabel.rx.textColor)
            .bind({ $0.backgroundColor }, to: self.loginButton.rx.titleColor(for: .normal))
            .bind({ UIImage.init(color: $0.primaryColor, size: buttonSize) },
                  to: self.loginButton.rx.backgroundImage(for: .normal))
            .bind({ UIImage.init(color: $0.primaryColor.withAlphaComponent(0.8), size: buttonSize) },
                  to: self.loginButton.rx.backgroundImage(for: .disabled))
            .disposed(by: self.rx.disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.sloganLabel.left = self.sloganLabel.leftWhenCenter
        self.sloganLabel.top = (self.sloganLabel.topWhenCenter * 0.8).flat
        self.logoImageView.left = self.logoImageView.leftWhenCenter
        self.logoImageView.bottom = self.sloganLabel.top - 5
        self.tokenTextField.height = 44
        self.tokenTextField.width = self.scrollView.width - 20 * 2
        self.tokenTextField.left = self.tokenTextField.leftWhenCenter
        self.tokenTextField.top = self.sloganLabel.bottom + 30
        self.errorLabel.width = self.tokenTextField.width
        self.errorLabel.left = self.tokenTextField.left
        self.errorLabel.top = self.tokenTextField.bottom
        self.loginButton.height = 44
        self.loginButton.width = self.tokenTextField.width
        self.loginButton.left = self.loginButton.leftWhenCenter
        self.loginButton.top = self.errorLabel.bottom
        self.privacyLabel.left = self.loginButton.left
        self.privacyLabel.top = self.loginButton.bottom + 5
        self.authLabel.left = self.authLabel.leftWhenCenter
        self.authLabel.bottom = (self.scrollView.height - 30 - UIScreen.safeBottom).flat
        self.authButton.left = self.authButton.leftWhenCenter
        self.authButton.bottom = self.authLabel.top - 15
    }

    func handle(user: User) {
        User.update(user)
    }
    
    func oauth(event: ControlEvent<Void>.Element) {
        
    }
    
}

extension Reactive where Base: LoginViewController {

    var token: ControlProperty<String?> {
        self.base.tokenTextField.rx.text
    }
    
    var login: ControlEvent<Void> {
        self.base.loginButton.rx.tap
    }
    
    var error: Binder<Error?> {
        return Binder(self.base) { viewController, error in
            viewController.error = error
            guard viewController.isViewLoaded else {
                return
            }
            viewController.errorLabel.text = error?.localizedDescription
        }
    }
    
}
