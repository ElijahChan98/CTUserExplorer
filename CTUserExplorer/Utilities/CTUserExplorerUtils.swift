//
//  CTUserExplorerUtils.swift
//  CTUserExplorer
//
//  Created by Elijah Tristan Huey Chan on 1/10/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//

import UIKit

struct CTUserExplorerUtils {
    static func showGenericOkAlert(title: String?, message: String, handler: ((UIAlertAction) -> Void)? = nil, completion: (() -> Void)? = nil) {
        let okAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: handler)
        okAlert.addAction(okAction)
        
        getTopViewController()?.present(okAlert, animated: true, completion: completion)
    }
    
    static func getTopViewController() -> UIViewController?{
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}
