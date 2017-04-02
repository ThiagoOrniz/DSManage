//
//  ProductService.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 08/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import CoreData

class ProductService {
    
    func getProducts()->[Product]{
        
        let p1:Product = Product(context: CoreDataStack.getContext())
        p1.name = "Brush"
        p1.price = 10.10
        p1.desc = "oi"
        p1.image = NSData(contentsOfFile: "/Users/Thiago/Documents/Swift/DSManage/DSManage/Assets.xcassets/product_brush.imageset/makeup-brush-png-2.png")
        
        let p2:Product = Product(context: CoreDataStack.getContext())
        p2.name = "Lipstick"
        p2.price = 12.10
        p2.desc = "description"
        p2.image = NSData(contentsOfFile: "/Users/Thiago/Documents/Swift/DSManage/DSManage/Assets.xcassets/product_lip_colour.imageset/3CE Lip Colour, Dangerous Matte, Matte New to Singapore beauty brands Sephora Korean makeup.png")
        
        let p3:Product = Product(context: CoreDataStack.getContext())
        p3.name = "Lipstick 2"
        p3.price = 12.10
        p3.desc = "description"
        p3.image = NSData(contentsOfFile: "/Users/Thiago/Documents/Swift/DSManage/DSManage/Assets.xcassets/product_lip_colour.imageset/3CE Lip Colour, Dangerous Matte, Matte New to Singapore beauty brands Sephora Korean makeup.png")

        
        let p4:Product = Product(context: CoreDataStack.getContext())
        p4.name = "Lipstick 3"
        p4.price = 12.10
        p4.desc = "description"
        p4.image = NSData(contentsOfFile: "/Users/Thiago/Documents/Swift/DSManage/DSManage/Assets.xcassets/product_lip_colour.imageset/3CE Lip Colour, Dangerous Matte, Matte New to Singapore beauty brands Sephora Korean makeup.png")

        
        let p5:Product = Product(context: CoreDataStack.getContext())
        p5.name = "Lipstick 4"
        p5.price = 12.10
        p5.desc = "description"
        p5.image = NSData(contentsOfFile: "/Users/Thiago/Documents/Swift/DSManage/DSManage/Assets.xcassets/product_lip_colour.imageset/3CE Lip Colour, Dangerous Matte, Matte New to Singapore beauty brands Sephora Korean makeup.png")


        
        let p6:Product = Product(context: CoreDataStack.getContext())
        p6.name = "Lipstick 5"
        p6.price = 12.10
        p6.desc = "description"
        p6.image = NSData(contentsOfFile: "/Users/Thiago/Documents/Swift/DSManage/DSManage/Assets.xcassets/product_lip_colour.imageset/3CE Lip Colour, Dangerous Matte, Matte New to Singapore beauty brands Sephora Korean makeup.png")

        
        CoreDataStack.saveContext()
      
        return [p1,p2,p3,p4,p5,p6]
    }
}
