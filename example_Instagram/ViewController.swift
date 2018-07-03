//
//  ViewController.swift
//  example_Instagram
//
//  Created by Kalaivani, Velusamy (623-Extern) on 02/07/18.
//  Copyright © 2018 Kalaivani, Velusamy (623-Extern). All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController {

    @IBOutlet weak var webKitView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
    let authURL=String(format:"%@client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True",arguments: [API.INSTAGRAM_AUTHURL,API.INSTAGRAM_CLIENT_ID,API.INSTAGRAM_REDIRECT_URI, API.INSTAGRAM_SCOPE])
        let urlRequest = URLRequest.init(url: URL.init(string: authURL)!)
        webKitView.load(urlRequest)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UIWebViewDelegate{
    func webView(_ webView: UIWebView, shouldStartLoadWith request:URLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        return checkRequestForCallbackURL(request: request)
    }
    
    func checkRequestForCallbackURL(request: URLRequest) -> Bool {
        let requestURLString = (request.url?.absoluteString)! as String
        if requestURLString.hasPrefix(API.INSTAGRAM_REDIRECT_URI) {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
            handleAuth(authToken: requestURLString.substring(from: range.upperBound))
            return false;
        }
        return true
    }
    func handleAuth(authToken: String) {
        print("Instagram authentication token ==", authToken)
    }

}


