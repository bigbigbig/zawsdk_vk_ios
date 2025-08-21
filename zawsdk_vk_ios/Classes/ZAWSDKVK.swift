//
//  ZAWSDKVK.swift
//  ZAWSDKIOS
//
//  Created by zhangmingsheng on 2025/8/16.
//

import Foundation
import VKID

public typealias VKIDAuthCompletion = (Bool, String?, String?, String?, NSError?) -> Void

@objc open class ZAWSDKVK: NSObject {
    var vkid: VKID?
        
    @objc open func config(clientId: String, clientSecret: String){
        do {
            try VKID.shared.set(
                config: Configuration(
                    appCredentials: AppCredentials(
                        clientId: clientId,
                        clientSecret: clientSecret
                    ),
                    appearance: .init(
                        locale: .system
                    ),
                    loggingEnabled: false
                )
            )
            self.vkid = VKID.shared
        } catch {
            preconditionFailure("Failed to initialize VKID: \(error)")
        }
    }
    
    @objc open func open(url: URL) -> Bool{
        return self.vkid?.open(url: url) ?? false
    }
    
    @objc open func authorize(viewController: UIViewController, completion: @escaping VKIDAuthCompletion){
        self.vkid?.authorize(using: .uiViewController(viewController), completion: { result in
            switch result {
            case .success(let userSession):
                // 成功获取授权结果
                let idToken = userSession.idToken.value
                let uid = "\(userSession.userId.value)"
                var uname = (userSession.user?.firstName ?? "") + (userSession.user?.lastName ?? "")
                let phone = userSession.user?.phone ?? ""
                if !phone.isEmpty{
                    uname = "\(uname)|\(phone)"
                }
                // 返回成功结果
                completion(true, idToken, uid, uname, nil)
            case .failure(let error):
                // 处理授权失败
                switch error {
                case .cancelled:
                    print("User cancelled authorization")
                    // 返回失败结果
                    completion(false, nil, nil, nil, NSError(
                        domain: "VKIDAuthError",
                        code: 2001,
                        userInfo: [NSLocalizedDescriptionKey: "User cancelled authorization"]
                    ))
                default:
                    print("Other Error")
                    // 返回失败结果
                    completion(false, nil, nil, nil, NSError(
                        domain: "VKIDAuthError",
                        code: 2999,
                        userInfo: [NSLocalizedDescriptionKey: "authentication error"]
                    ))
                }
            }
        })
    }
}
