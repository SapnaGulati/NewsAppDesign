//
//  loginScreenVC.swift
//  NewsApp
//
//  Created by ios4 on 25/05/21.
//

import UIKit

class loginScreenVC: UIViewController {

    @IBOutlet weak var username_input: UITextField!
    @IBOutlet weak var password_input: UITextField!
    @IBOutlet weak var login_button: UIButton!
    let login_url = "https://www.kaleidosblog.com/tutorial/login/api/Login"
    let checksession_url = "https://www.kaleidosblog.com/tutorial/login/api/CheckSession"
    var login_session: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let preferences = UserDefaults.standard
        if preferences.object(forKey: "session") != nil
        {
            login_session = preferences.object(forKey: "session") as! String
            check_session()
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        login_now(username:username_input.text!, password: password_input.text!)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectCountryViewController") as! SelectCountryViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func login_now(username:String, password:String)
    {
        let post_data: NSDictionary = NSMutableDictionary()
        post_data.setValue(username, forKey: "username")
        post_data.setValue(password, forKey: "password")
        
        let url:URL = URL(string: login_url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        var paramString = ""
        for (key, value) in post_data
        {
            paramString = paramString + (key as! String) + "=" + (value as! String) + "&"
        }
        request.httpBody = paramString.data(using: String.Encoding.utf8)
            
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
        (data, response, error) in
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                return
            }
            
            let json: Any?
            do
            {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
            }
            catch
            {
                return
            }
                
            guard let server_response = json as? NSDictionary else
            {
                return
            }
               
            if let data_block = server_response["data"] as? NSDictionary
            {
                if let session_data = data_block["session"] as? String
                    {
                        self.login_session = session_data
                        let preferences = UserDefaults.standard
                        preferences.set(session_data, forKey: "session")
                    }
                }
            })
            task.resume()
        }

    func check_session()
    {
        let post_data: NSDictionary = NSMutableDictionary()
        post_data.setValue(login_session, forKey: "session")
        
        let url:URL = URL(string: checksession_url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        var paramString = ""
        for (key, value) in post_data
        {
            paramString = paramString + (key as! String) + "=" + (value as! String) + "&"
        }
        
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            guard let _:Data = data, let _:URLResponse = response, error == nil else {
                return
            }
            
            let json: Any?
            do
            {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
            }
            catch
            {
                return
            }
            guard (json as? NSDictionary) != nil else
            {
                return
            }
        })
        task.resume()
    }
}
