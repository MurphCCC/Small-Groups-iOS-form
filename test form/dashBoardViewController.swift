//
//  dashBoardViewController.swift
//  test form
//
//  Created by Mike Murphy on 8/14/16.
//  Copyright © 2016 Murph. All rights reserved.
//

import UIKit

class dashBoardViewController: UIViewController {
	@IBOutlet var webView: UIWebView!

	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		let url = NSURL (string: "http://192.168.11.88/small_groups/dashboard.php")
		let requestObj = NSURLRequest(URL: url!);
		webView.loadRequest(requestObj);

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
