//
//  SwinjectStoryboard+Extension.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 2/3/21.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    class func create(id: String, bundle: Bundle = Bundle.main, container: Resolver = SwinjectStoryboard.defaultContainer) -> SwinjectStoryboard {
        return self.create(name: id, bundle: bundle, container: container)
    }
    
    class func createViewController<T>(_ controllerType: T.Type) -> T where T: StoryboardLoadable, T: UIViewController {
        let storyboard = create(id: T.storyboardName())
        let viewController = storyboard.instantiateViewController(withIdentifier: T.storyboardIdentifier()) as! T
        return viewController
    }
    
    class func createInitialViewController<T>(_ controllerType: T.Type) -> T where T: StoryboardLoadable, T: UIViewController {
        let storyboard = create(id: T.storyboardName())
        let viewController = storyboard.instantiateInitialViewController() as! T
        return viewController
    }
}
