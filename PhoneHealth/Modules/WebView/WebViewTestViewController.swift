//
//  WebViewTestViewController.swift
//  PhoneHealth
//
//  Created by Lizan on 31/03/2022.
//

import UIKit
import WebKit

class WebViewTestViewController: UIViewController {

//    @IBOutlet weak var webView: WKWebView! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        view.addSubview(webView)
//        self.webView = webView
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
       
        if let filePath = Bundle.main.url(forResource: "lab-report", withExtension: "html") {
          let request = NSURLRequest(url: filePath)
          webView.load(request as URLRequest)
        }
        // Do any additional setup after loading the view.
    }
   
}
