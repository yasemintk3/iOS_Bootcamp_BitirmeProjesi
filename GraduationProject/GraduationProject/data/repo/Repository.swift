//
//  Repository.swift
//  GraduationProject
//
//  Created by Yasemin TOK on 6.04.2024.
//

import Foundation
import RxSwift
import Alamofire

class Repository {
    
    var menuList = BehaviorSubject<[Menu]>(value: [Menu]())
    
    func search(searchText:String) {
        
        //later
    }
    
    func uploadMenu() {
        
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
            
            if let data = response.data {
                do {
                    let answer = try JSONDecoder().decode(MenuResponse.self, from: data)
                    
                    if let list = answer.yemekler {
                        self.menuList.onNext(list)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
