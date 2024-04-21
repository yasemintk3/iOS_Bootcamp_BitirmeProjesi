//
//  HomePageViewModel.swift
//  GraduationProject
//
//  Created by Yasemin TOK on 6.04.2024.
//

import Foundation
import RxSwift

class HomePageViewModel {
    
    // MARK: - Properties
    
    var menuList = BehaviorSubject<[Menu]>(value: [Menu]())
    var menuRepo = Repository()
    
    // MARK: - Initialization
    
    init() {
        menuList = menuRepo.menuList
        uploadMenu()
    }
    
    // MARK: - Funcs
    
    func uploadMenu() {
        menuRepo.uploadMenu()
    }
    
    func search(searchText: String) {
        menuRepo.search(searchText: searchText)
    }
}
