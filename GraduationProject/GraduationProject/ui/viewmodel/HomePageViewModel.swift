//
//  HomePageViewModel.swift
//  GraduationProject
//
//  Created by Yasemin TOK on 6.04.2024.
//

import Foundation
import RxSwift

class HomePageViewModel {
    
    var menuList = BehaviorSubject<[Menu]>(value: [Menu]())
    var menuRepo = Repository()
    
    init() {
        menuList = menuRepo.menuList
        uploadMenu()
    }
    
    func uploadMenu() {
        menuRepo.uploadMenu()
    }
}
