//
//  SpyNavigationController.swift
//  PhotoAppTests
//
//  Created by Ramón Dias de Oliveira Almeida on 03/04/23.
//

import UIKit

class SpyNavigationController: UINavigationController {
    
    var pushedViewController: UIViewController!
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushedViewController = viewController
    }
}
