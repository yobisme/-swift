//
//  ADModel.swift
//  轮播器swift
//
//  Created by Macx on 2017/6/3.
//  Copyright © 2017年 Macx. All rights reserved.
//

import UIKit

class ADModel: NSObject {

    var imgsrc: String?
    var title: String?
    
    init(dic: [String:Any])
    {
        super.init()
        
        setValuesForKeys(dic)
    }
    
    
}
