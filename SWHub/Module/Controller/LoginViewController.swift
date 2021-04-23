//
//  LoginViewController.swift
//  SWHub
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit

class LoginViewController: ScrollViewController, ReactorKit.View {
    
    lazy var tokenLabel: SWLabel = {
        let label = SWLabel.init()
        label.font = .systemFont(ofSize: 18)
        label.text = R.string.localizable.token()
        label.sizeToFit()
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
        textField.font = .systemFont(ofSize: 16)
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
        self.scrollView.addSubview(self.tokenLabel)
        self.scrollView.addSubview(self.loginButton)
        self.scrollView.addSubview(self.logoImageView)
        self.scrollView.addSubview(self.tokenTextField)
        
        let buttonSize = CGSize.init(
            width: UIScreen.width - 20 * 2,
            height: 44.f
        )
        themeService.rx
            .bind({ $0.titleColor }, to: [
                self.tokenLabel.rx.textColor,
                self.tokenTextField.rx.textColor
            ])
            .bind({ $0.backgroundColor }, to: self.loginButton.rx.titleColor(for: .normal))
            .bind({ UIImage.init(color: $0.primaryColor, size: buttonSize) },
                  to: self.loginButton.rx.backgroundImage(for: .normal))
            .bind({ UIImage.init(color: $0.primaryColor.withAlphaComponent(0.8), size: buttonSize) },
                  to: self.loginButton.rx.backgroundImage(for: .disabled))
            .disposed(by: self.rx.disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.logoImageView.left = self.logoImageView.leftWhenCenter
        self.logoImageView.top = (self.logoImageView.topWhenCenter * 0.8).flat
        self.tokenLabel.left = 20
        self.tokenLabel.top = self.logoImageView.bottom + 50
        self.loginButton.width = self.scrollView.width - 20 * 2
        self.loginButton.height = 44
        self.loginButton.left = self.tokenLabel.left
        self.loginButton.top = self.tokenLabel.bottom + 50
        self.tokenTextField.height = 40
        self.tokenTextField.left = self.tokenLabel.right + 10
        self.tokenTextField.extendToRight = self.scrollView.width - 20
        self.tokenTextField.centerY = self.tokenLabel.centerY
    }

}
