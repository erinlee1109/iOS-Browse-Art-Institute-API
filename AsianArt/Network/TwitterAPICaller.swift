//
//  TwitterAPICaller.swift
//  AsianArt
//
//  Created by Yujeong Lee on 5/12/21.
//

// pod install issues were resolved by looking at this issue https://github.com/CocoaPods/CocoaPods/issues/10518
import UIKit
// Although I am using a different library (BDBOAuth1Manager), this article was very helpful in navigating this https://johncodeos.com/how-to-add-twitter-login-button-to-your-ios-app-using-swift/
import BDBOAuth1Manager


class TwitterAPICaller: BDBOAuth1SessionManager {
    // I generated the consumerKey and the consumerSecret key on Twitter Developers
    static let client = TwitterAPICaller(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "PmxwrknQn1DhQAub8oaP2hGS4", consumerSecret: "Zcc9uOl4Yk4WLtQOKW2cclH7iWe1lMSrGEoSkw5Elpy1v5bzSE")
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        TwitterAPICaller.client?.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) in
            self.loginSuccess?()
        }, failure: { (error: Error!) in
            self.loginFailure?(error)
        })
    }
    
    func login(url: String, success: @escaping () -> (), failure: @escaping (Error) -> ()){
        loginSuccess = success
        loginFailure = failure
        TwitterAPICaller.client?.deauthorize()
        // browseapp:// is my own callback URL. This is also specified on Target>AsianArt>Info>URL Types>URL Schemes as "browseapp". 
        TwitterAPICaller.client?.fetchRequestToken(withPath: url, method: "GET", callbackURL: URL(string: "browseapp://"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token!)")!
            UIApplication.shared.open(url)
        }, failure: { (error: Error!) -> Void in
            print("Error: \(error.localizedDescription)")
            self.loginFailure?(error)
        })
    }
    func logout (){
        deauthorize()
    }
    
    func getDictionaryRequest(url: String, parameters: [String:Any], success: @escaping (NSDictionary) -> (), failure: @escaping (Error) -> ()){
        TwitterAPICaller.client?.get(url, parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success(response as! NSDictionary)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    func getDictionariesRequest(url: String, parameters: [String:Any], success: @escaping ([NSDictionary]) -> (), failure: @escaping (Error) -> ()){
        print(parameters)
        TwitterAPICaller.client?.get(url, parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success(response as! [NSDictionary])
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }

    func postRequest(url: String, parameters: [Any], success: @escaping () -> (), failure: @escaping (Error) -> ()){
        TwitterAPICaller.client?.post(url, parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success()
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
}
