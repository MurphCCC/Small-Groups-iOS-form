//
//  ViewController.swift
//  test form
//
//  Created by Mike Murphy on 8/12/16.
//  Copyright © 2016 Murph. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireXmlToObjects
import EVReflection




class ViewController: UIViewController {
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet var nameField: UITextField!
	@IBOutlet var emailField: UITextField!
	@IBOutlet weak var phoneField: UITextField!
	@IBOutlet weak var submitButton: UIButton!
	@IBOutlet weak var statusMessage: UITextView!
	


	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	func textFieldDidBeginEditing(textField: UITextField) {
		
		if textField == nameField {
			scrollView.setContentOffset(CGPointMake(0, 0), animated: true)

		} else {
		scrollView.setContentOffset(CGPointMake(0, 150), animated: true)
	}
	}

	
	func textFieldDidEndEditing(textField: UITextField) {
		
		scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
	}
	
	func centerText() {
		statusMessage.textAlignment = .Center
		statusMessage.font = UIFont.systemFontOfSize(26)
	}
	
	@IBAction func reloadForm() {
		nameField.placeholder = "Please Enter Your Name"
		statusMessage.text = "Please fill out the form above"
		emailField.placeholder = "Please Enter your email"
		phoneField.placeholder = "Phone number (optional)"
		
		nameField.text = ""
		emailField.text = ""
		phoneField.text = ""
		centerText()
	}

	
	@IBAction func submit(sender: AnyObject) {


		if nameField.text != "" && emailField.text != "" {
		let nameValue = nameField.text!
		let nameValueSplit = nameField.text!.characters.split(" ")
			
		let emailValue = emailField.text!
		let phoneValue = phoneField.text!
		
			
		let firstName = String(nameValueSplit.first!)
			
			let parameters = [
				"name": "\(nameValue)",
				"email": "\(emailValue)",
				"phone": "\(phoneValue)",
				]
			
			Alamofire.request(.POST, "http://192.168.11.88/small_groups/mail.php", parameters: parameters)
				.responseJSON { response in
					print(response.request)  // original URL request
					print(response.response) // URL response
					print(response.data)     // server data
					print(response.result)   // result of response serialization
					
					if let JSON = response.result.value {
						print("JSON: \(JSON)")
					}
			}
			
			
			view.endEditing(true)
			scrollView.setContentOffset(CGPointMake(0, 0), animated: true)

			
			statusMessage.text = "Thanks \(firstName)!  Please check your email\n for further information!"
			centerText()
			
			
			let triggerTime = (Int64(NSEC_PER_SEC) * 10)
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
				self.reloadForm()
			})
			
			
		
		} else {
			
		statusMessage.text = "Please Fill out the information above"
		centerText()
		}
		
	}

}

class WeatherResponse: EVObject {
	var location: String?
	var three_day_forecast: [Forecast] = [Forecast]()
}

class Forecast: EVObject {
	var day: String?
	var temperature: NSNumber?
	var conditions: String?
}

class AlamofireXmlToObjectsTests {
	func testResponseObject() {
		let URL = "https://raw.githubusercontent.com/evermeer/AlamofireXmlToObjects/master/AlamofireXmlToObjectsTests/sample_xml"
		Alamofire.request(.GET, URL, parameters: nil)
			.responseObject { (response: Result< WeatherResponse, NSError>) in
				if let result = response.value {
					// That was all... You now have a WeatherResponse object with data
				}
		}
	}
}



