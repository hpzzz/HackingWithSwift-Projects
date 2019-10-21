//
//  DetailViewController.swift
//  Project16
//
//  Created by Karol Harasim on 17/09/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    var webView:WKWebView!
    var selectedCity: String?
    var progressView: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let goForward = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
        let goBack = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        toolbarItems = [progressButton, spacer, goBack, spacer, goForward, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://en.wikipedia.org/wiki/" + selectedCity!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
