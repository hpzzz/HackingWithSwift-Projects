//
//  DetailViewController.swift
//  Project4
//
//  Created by Karol Harasim on 22/08/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    var selectedPage: String?
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
        
        let url = URL(string: "https://" + selectedPage!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites{
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
        let ac = UIAlertController(title: "Acces denied", message: "That URL isn't allowed", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .cancel))
        present(ac, animated: true)
        
    }
//    @objc func openTapped (){
//        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
//        for website in websites {
//            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
//        }
//        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//        present(ac, animated: true)
//    }
//    func openPage(action: UIAlertAction) {
//        guard let actionTitle = action.title else { return }
//        guard let url = URL(string: "https://" + actionTitle) else { return }
//        webView.load(URLRequest(url: url))
//
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
