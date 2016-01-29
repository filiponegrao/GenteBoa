//
//  ViewController.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 20/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import UIKit

class PrivacyViewController: UIViewController {
    
    var webView : UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.webView = UIWebView(frame: CGRectMake(10,70,screenWidth - 20, screenHeight - 70))
        
        let path = NSBundle.mainBundle().pathForResource("privacy", ofType: "pdf")
        let url = NSURL(fileURLWithPath: path!)
        print(url)
        
        let urlrequest = NSURLRequest(URL: url)
        self.webView.loadRequest(urlrequest)
        self.webView.backgroundColor = UIColor.whiteColor()
        
        let contentSize:CGSize = self.webView.scrollView.contentSize
        let viewSize:CGSize = self.view.bounds.size
        
        let rw:CGFloat = viewSize.width / contentSize.width
        
        self.webView.scrollView.minimumZoomScale = rw
        self.webView.scrollView.maximumZoomScale = rw
        self.webView.scrollView.zoomScale = rw
        self.webView.contentMode = .ScaleAspectFit
        self.webView.scalesPageToFit = true
        
        self.view.addSubview(self.webView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
