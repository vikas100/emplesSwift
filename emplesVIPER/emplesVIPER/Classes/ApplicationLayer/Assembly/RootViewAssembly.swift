//
//  MenuAssembly.swift
//  emplesVIPER
//
//  Created by Vasily Popov on 11/12/17.
//  Copyright © 2017 Vasily Popov. All rights reserved.
//

import Swinject

class RootViewAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(EmplesMenuView.self) { _ in EmplesMenuView() }
            .initCompleted { (r, view) in
                view.presenter = r.resolve(EmplesMenuPresenter.self)
        }.inObjectScope(.container)
        container.register(EmplesMenuPresenter.self) { r in
            EmplesMenuPresenter(r.resolve(EmplesMenuModel.self)!) }
            .initCompleted { (r, presenter) in
                presenter.view = r.resolve(EmplesMenuView.self)
                presenter.router = r.resolve(EmplesMenuRouter.self)
        }
        container.register(EmplesMenuRouter.self) { _ in EmplesMenuRouter() }
            .initCompleted { (r, router) in
                router.window = r.resolve(UIWindow.self)
                router.viewController = r.resolve(MainNavigationController.self)
                router.assembler = r.resolve(CollectionAssembler.self)
        }
        container.register(EmplesMenuModel.self) { _ in EmplesMenuModel() }

        container.register(CollectionAssembler.self) { r in
            CollectionAssembler(parent: r.resolve(RootAssembler.self)!.assembler)
        }.inObjectScope(.container)
    }
}
