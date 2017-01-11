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
        
        return [Product(id:"1", product:"Hair Pomade XY", price:31.10, category:"beaulty", desc:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras rutrum hendrerit arcu, et efficitur ipsum cursus vel. Sed velit justo, varius eu odio eu, sollicitudin auctor dui", photoURL:""),
                    
                Product(id:"2", product:"Shampoo XY", price:12.00, category:"beaulty", desc:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras rutrum hendrerit arcu, et efficitur ipsum cursus vel. Sed velit justo, varius eu odio eu, sollicitudin auctor dui", photoURL:"")
        ]

    }
    
}
