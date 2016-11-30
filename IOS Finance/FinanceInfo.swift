//
//  FinanceInfo.swift
//  IOS Finance
//
//  Created by 123 on 16/11/1.
//  Copyright © 2016年 123. All rights reserved.
//

import Foundation

class FinanceInfo: NSObject, NSCoding{
    var content: String
    var date: String
    var money: String
    var listclass: String
    var situation: String
    
    //构造方法
    init(content: String = "", date: String = "", money: String = "", listclass: String = "", situation: String = ""){
        self.content = content
        self.date = date
        self.money = money
        self.listclass = listclass
        self.situation = situation
        super.init()
    }
    
    //从nsobject解析回来
    required init(coder aDecoder:NSCoder){
        self.content=aDecoder.decodeObject(forKey: "Content") as! String
        self.date=aDecoder.decodeObject(forKey: "Date") as! String
        self.money=aDecoder.decodeObject(forKey: "Money") as! String
        self.listclass=aDecoder.decodeObject(forKey: "Listclass") as! String
        self.situation=aDecoder.decodeObject(forKey: "Situation") as! String
    }
    
    //编码成object
    func encode(with aCoder:NSCoder){
        aCoder.encode(content,forKey:"Content")
        aCoder.encode(date,forKey:"Date")
        aCoder.encode(money,forKey:"Money")
        aCoder.encode(listclass,forKey:"Listclass")
        aCoder.encode(situation,forKey:"Situation")
    }
}
