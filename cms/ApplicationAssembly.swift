//
//  ApplicationAssembly.swift
//  cms
//
//  Created by Фатихсултан Жакшылыков on 2/3/21.
//

import Swinject
import SwinjectStoryboard

class ApplicationAssembly {
    
    class var appAssembler: Assembler {
        Assembler([
            ServicesAssembly(),
            
            AuthenticationOneAssembly(),
            RegistrationScreenAssembly(),
            SecondRegistrationScreenAssembly(),
            ThirdRegistrationScreenAssembly(),
            ForgotPasswordScreenAssembly(),
            RestorePasswordScreenAssembly(),
            
            TabBarAssembly(),
            MainPageAssembly(),
            MainCardDetailAssembly(),
            AddPageAssembly(),
            AddPagePersonAssembly(),
            ClientsPageAssembly(),
            WorkersPageAssembly(),
            WorkerDetailAssembly(),
            StudentsPageAssembly(),

            TimerPageAssembly(),
            FilterPageAssembly(),
            PaymentPageAssembly(),
        ])
    }
}

extension SwinjectStoryboard {
    
    @objc class func setup() {
        defaultContainer = ApplicationAssembly.appAssembler.resolver as! Container
    }
}

