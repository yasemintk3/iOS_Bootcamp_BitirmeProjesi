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
    
    // MARK: - Properties
    
    var menuList = BehaviorSubject<[Menu]>(value: [Menu]())
    var cartList = BehaviorSubject<[Cart]>(value: [Cart]())
    
    // MARK: - Funcs
    
    func search(searchText: String) {
        //no webservice
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
    
    func addToCart(yemek_adi: String,
                   yemek_resim_adi: String,
                   yemek_fiyat: Int,
                   yemek_siparis_adet: Int,
                   kullanici_adi: String) {
        
        let params:Parameters = ["yemek_adi": yemek_adi,
                                 "yemek_resim_adi": yemek_resim_adi,
                                 "yemek_fiyat": yemek_fiyat,
                                 "yemek_siparis_adet": yemek_siparis_adet,
                                 "kullanici_adi": kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response { response in
            
            if let data = response.data {
                do {
                    let answer = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    print(answer.success!)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func listCart(kullanici_adi: String) {
        
        let params:Parameters = ["kullanici_adi": kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response { response in
            
            if let data = response.data {
                do {
                    let answer = try JSONDecoder().decode(CartResponse.self, from: data)
                    if let list = answer.sepet_yemekler {
                        self.cartList.onNext(list)
                    }
                } catch {
                    self.cartList.onNext([])
                }
            }
        }
    }
    
    func deleteOrder(sepet_yemek_id: Int, kullanici_adi: String) {
        
        let params:Parameters = ["sepet_yemek_id": sepet_yemek_id,
                                 "kullanici_adi": kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
            
            if let data = response.data {
                do {
                    let answer = try JSONDecoder().decode(CartResponse.self, from: data)
                    print(answer.success!)
                    self.listCart(kullanici_adi: kullanici_adi)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
