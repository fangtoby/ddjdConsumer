//
//  NSNotificationName.swift
//  ddjdConsumer
//
//  Created by hao peng on 2017/12/7.
//  Copyright © 2017年 zltx. All rights reserved.
//

import Foundation
///刷新消费者订单信息
let notificationOrderListrefresh=NSNotification.Name(rawValue:"orderListrefresh")
///刷新店铺订单信息
let notificationStoreOrderListrefresh=NSNotification.Name(rawValue:"StoreOrderListrefresh")
///分类选择
let notificationNameCategorySelection=NSNotification.Name.init("CategorySelection")
///更新购物车角标
let updateCarBadgeValue=NSNotification.Name(rawValue: "postBadgeValue")
///更新店铺商品列表
let  notificationNameUpdateStoreGoodList=NSNotification.Name(rawValue:"UpdateStoreGoodList")

