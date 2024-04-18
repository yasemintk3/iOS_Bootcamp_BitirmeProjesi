//
//  DetailPageViewModel.swift
//  GraduationProject
//
//  Created by Yasemin TOK on 7.04.2024.
//

import Foundation

class DetailPageViewModel {
    
    // MARK: - Properties
    
    var cartRepo = Repository()
    
    // MARK: - Funcs
    
    func addToCart(yemek_adi:String, yemek_resim_adi:String, yemek_fiyat:Int, yemek_siparis_adet:Int, kullanici_adi:String) {
        cartRepo.addToCart(yemek_adi: yemek_adi,
                           yemek_resim_adi: yemek_resim_adi,
                           yemek_fiyat: yemek_fiyat,
                           yemek_siparis_adet: yemek_siparis_adet,
                           kullanici_adi: kullanici_adi)
    }
}
