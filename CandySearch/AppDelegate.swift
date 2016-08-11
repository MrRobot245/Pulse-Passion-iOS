/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate { 
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
//        let splitViewController = window!.rootViewController as! UISplitViewController
//        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
//        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
//        splitViewController.delegate = self
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()

       // navigationController.navigationBar.translucent = true
//        UISearchBar.appearance().translucent =  true
//        UISearchBar.appearance().tintColor = UIColor.whiteColor()
//        UISearchBar.appearance().barTintColor = UIColor.logoGreen()
//        UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).tintColor = UIColor.blackColor()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
    
  
        return true
    }
    
    
}
//http://htmlpreview.github.io/?https://github.com/tparry/Miscellaneous/blob/master/UINavigationBar_UIColor_calculator.html

extension UIColor {
    static func logoGreen() -> UIColor {
        return UIColor(red: 120.0/255.0, green: 170.0/255.0, blue: 76.0/255.0, alpha: 0)
    }
}