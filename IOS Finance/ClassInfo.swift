//
//  ClassInfo.swift
//  IOS Finance
//
//  Created by 123 on 16/11/1.
//  Copyright © 2016年 123. All rights reserved.
//

import Foundation

class ClassInfo: NSObject, NSCoding{
    var listclass: String
    
    //构造方法
    init(listclass: String = ""){
        self.listclass = listclass
        super.init()
    }
    
    //从nsobject解析回来
    required init(coder aDecoder:NSCoder){
        self.listclass=aDecoder.decodeObject(forKey: "Listclass") as! String
    }
    
    //编码成object
    func encode(with aCoder:NSCoder){
        aCoder.encode(listclass,forKey:"Listclass")
    }
}
