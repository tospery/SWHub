//
//  WebViewController.swift
//  SWHub
//
//  Created by 杨建祥 on 2021/5/4.
//

import UIKit
import WebKit

class WebViewController: SWFrame.WebViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func handle(_ handler: String, _ data: Any) {
        log("未处理的JS: \(handler)")
    }
    
    override func webView(_ webView: WKWebView,
                          decidePolicyFor navigationAction: WKNavigationAction,
                          decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        super.webView(webView, decidePolicyFor: navigationAction, decisionHandler: decisionHandler)
    }
    
}
