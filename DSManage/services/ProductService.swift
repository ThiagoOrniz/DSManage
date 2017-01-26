//
//  ProductService.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 08/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class ProductService {
    
    func getProducts()->[ProductViewModel]{
        
        let p1 = Product(id:"1", product:"Brush", price:11.10, category:"beaulty", desc:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras rutrum hendrerit arcu, et efficitur ipsum cursus vel. Sed velit justo, varius eu odio eu, sollicitudin auctor dui", photoURL:"http://media3.onsugar.com/files/2013/09/05/148/n/4981324/ef96f097b7426d72_main.xxxlarge/i/Spring-Beauty-Product-Swaps.jpg")
        
        
        let p2 = Product(id:"2", product:"Diorette 10", price:22.00, category:"beaulty", desc:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras rutrum hendrerit arcu, et efficitur ipsum cursus vel. Sed velit justo, varius eu odio eu, sollicitudin auctor dui", photoURL:"http://qbbr.vteximg.com.br/arquivos/ids/155690-292-292/batom-mate-quem-disse-berenice_1_802060.jpg")
        
        
        let p3 = Product(id:"3", product:"Lipstick", price:13.54, category:"beaulty", desc:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras rutrum hendrerit arcu, et efficitur ipsum cursus vel. Sed velit justo, varius eu odio eu, sollicitudin auctor dui", photoURL:"https://boots.scene7.com/is/image/Boots/10106880?id=oLSaD3&fmt=jpg&fit=constrain,1&wid=504&hei=548")
        
        
        return [ProductViewModel(product: p1),
                ProductViewModel(product: p2),
                ProductViewModel(product: p3)]

    }
    
}
