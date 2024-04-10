//
//  CartPageViewModel.swift
//  GraduationProject
//
//  Created by Yasemin TOK on 9.04.2024.
//

import Foundation
import RxSwift

class CartPageViewModel {
    
    var cartList = BehaviorSubject<[Cart]>(value: [Cart]())
    var cartRepo = Repository()
    
    init() {
        cartList = cartRepo.cartList
        listCart(kullanici_adi: "ytok")
    }
    
    func addToCart(yemek_adi:String, yemek_resim_adi:String, yemek_fiyat:Int, yemek_siparis_adet:Int, kullanici_adi:String) {
        cartRepo.addToCart(yemek_adi: yemek_adi,
                           yemek_resim_adi: yemek_resim_adi,
                           yemek_fiyat: yemek_fiyat,
                           yemek_siparis_adet: yemek_siparis_adet,
                           kullanici_adi: kullanici_adi)
    }
    
    func listCart(kullanici_adi:String) {
        cartRepo.listCart(kullanici_adi: kullanici_adi)
    }
}
