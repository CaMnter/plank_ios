//
//  Fitness.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/9.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit

class Fitness {
    var title:String
    var desc:String
    var image:UIImage
    
    init?(title:String, desc:String, image:UIImage?){
        self.title = title;
        self.desc = desc;
        self.image = image!;
        
        if title.isEmpty || desc.isEmpty {
            return nil
        }
    }
}
