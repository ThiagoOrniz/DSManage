//
//  ProductService.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 08/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class ProductService {
    
    func getProducts()->[Product]{
        
        return [Product(id:"1", product:"Brush", price:11.10, category:"beaulty", desc:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras rutrum hendrerit arcu, et efficitur ipsum cursus vel. Sed velit justo, varius eu odio eu, sollicitudin auctor dui", photoURL:"product_brush"),
                    
            Product(id:"2", product:"Diorette 10", price:22.00, category:"beaulty", desc:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras rutrum hendrerit arcu, et efficitur ipsum cursus vel. Sed velit justo, varius eu odio eu, sollicitudin auctor dui", photoURL:"product_diorette"),
            
            Product(id:"3", product:"Lipstick", price:13.54, category:"beaulty", desc:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras rutrum hendrerit arcu, et efficitur ipsum cursus vel. Sed velit justo, varius eu odio eu, sollicitudin auctor dui", photoURL:"product_lip_colour")
            
            ]
    }
    
}
