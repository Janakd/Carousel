//
//  LoginViewController.swift
//  Carousel
//
//  Created by Dadhaniya, Janak on 11/2/15.
//  Copyright © 2015 Dadhaniya, Janak. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var buttonParentView: UIView!
    
    @IBOutlet weak var fieldParentView: UIView!
    
    @IBOutlet weak var loginNavBar: UIImageView!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        scrollView.contentSize = CGSize(width: 320, height: 600)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        let transform = CGAffineTransformMakeScale(0.2, 0.2)
        loginNavBar.transform = transform
        fieldParentView.transform = transform
        loginNavBar.alpha = 0
        fieldParentView.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool)
    {
    UIView.animateWithDuration(0.3) { () -> Void in
    self.fieldParentView.transform = CGAffineTransformIdentity
    self.loginNavBar.transform = CGAffineTransformIdentity
    self.fieldParentView.alpha = 1
    self.loginNavBar.alpha = 1
    }
        
    }
    
    func keyboardWillShow(notification:NSNotification!) {
        
        buttonParentView.transform = CGAffineTransformMakeTranslation(0, -120)
        let maxContentOffsetY = scrollView.contentSize.height - scrollView.frame.size.height
        scrollView.contentOffset.y = maxContentOffsetY
        scrollView.scrollEnabled = true
    }
    
    func keyboardWillHide(notification:NSNotification!) {
        
        buttonParentView.transform = CGAffineTransformIdentity
        scrollView.contentOffset.y = 0
        scrollView.scrollEnabled = false
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        if scrollView.contentOffset.y <= -50 {
            self.view.endEditing(true)
        }
        
    }
    @IBAction func didTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func didPressLogin(sender: AnyObject) {
        activityIndicator.startAnimating()
        loginButton.selected = true
        
        if emailField.text == "email" && passwordField.text == "password" {
            
            delay(2, closure: { () -> () in
                self.activityIndicator.stopAnimating()
                self.performSegueWithIdentifier("signInSuccess", sender: nil)
                
                self.loginButton.selected = false
            })
            
            
        }
            
        else if emailField.text == "" || passwordField.text == "" {
            
            let emptyAlert = UIAlertController(title: "Write Something", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
            
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                self.activityIndicator.stopAnimating()
                self.loginButton.selected = false
            })
            
            emptyAlert.addAction(OKAction)
            self.presentViewController((emptyAlert), animated: true, completion: nil)
            }

            
        else {
            activityIndicator.startAnimating()
        
            delay(2, closure: { () -> () in
                
                self.loginButton.selected = true
                
                let alert = UIAlertController(title: "Wrong", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                    self.activityIndicator.stopAnimating()
                    self.loginButton.selected = false
                })
                alert.addAction(okAction)
                self.presentViewController(alert, animated: true, completion: nil)
            })
        }
        
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


