//
//  StoreGoodNetWork.swift
//  ddjdConsumer
//
//  Created by hao peng on 2017/11/20.
//  Copyright © 2017年 zltx. All rights reserved.
//

import Foundation
import Moya
//店铺商品相关api
public enum StoreGoodApi{
    //商品上传
    case storeUploadGoodsInfo(goodsCode:String,storeId:Int,goodsName:String,goodsUnit:String,goodsLift:Int,goodUcode:String,fCategoryId:Int,sCategoryId:Int,tCategoryId:Int,goodsPic:String,goodsPrice:String,goodsFlag:Int,stock:Int,remark:String?,weight:Int?,brand:String?,goodsMixed:String?,offlineStock:Int)
    //图片上传
    case start(filePath:String,pathName:String)
    //验证条码是否存在；如果存在，就返回公共商品库的商品信息，且同时返回这个店铺是否已经拥有了这个商品（根据exist判断），如果值为true表明已经拥有，且同时返回店铺的商品信息（querySag），如果值为false，表明没有拥有;如果不存在，直接返回 notExist
    case queryGoodsCodeIsExist(goodsCode:String,storeId:Int)
    //店铺查询自己的商品
    case queryStoreAndGoodsList(storeId:Int,goodsFlag:Int,pageNumber:Int,pageSize:Int,tCategoryId:Int?)
    //店铺商品上下架
    case updateGoodsFlagByStoreAndGoodsId(storeAndGoodsId:Int,goodsFlag:Int)
    //修改店铺信息
    case updateGoodsByStoreAndGoodsId(storeAndGoodsId:Int,goodsFlag:Int?,storeGoodsPrice:String?,stock:String?,offlineStock:String?)
    //查询店铺商品详情
    case queryStoreAndGoodsDetail(storeAndGoodsId:Int,storeId:Int)
    ///分配到店铺商品库 单个商品
    case addGoodsInfoGoToStoreAndGoods_detail(storeId:Int,goodsId:Int,storeGoodsPrice:String,goodsFlag:Int,stock:Int,offlineStock:Int)
    
    
    
}
extension StoreGoodApi:TargetType{
    public var baseURL: URL {
        return URL.init(string:url)!
    }
    
    public var path: String {
        switch self {
        case .storeUploadGoodsInfo(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_):
            return "/front/storeUploadGoods/storeUploadGoodsInfo"
        case .start(_,_):
            return "/upload/start"
        case .queryGoodsCodeIsExist(_,_):
            return "/front/storeUploadGoods/queryGoodsCodeIsExist"
        case .queryStoreAndGoodsList(_,_,_,_,_):
            return "/front/storeAndGoods/queryStoreAndGoodsList"
        case .updateGoodsFlagByStoreAndGoodsId(_,_):
            return "/front/storeAndGoods/updateGoodsFlagByStoreAndGoodsId"
        case .updateGoodsByStoreAndGoodsId(_,_,_,_,_):
            return "/front/storeAndGoods/updateGoodsByStoreAndGoodsId"
        case .queryStoreAndGoodsDetail(_,_):
            return "/front/storeAndGoods/queryStoreAndGoodsDetail"
        case .addGoodsInfoGoToStoreAndGoods_detail(_,_,_,_,_,_):
            return "//front/storeAndGoods/addGoodsInfoGoToStoreAndGoods_detail"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .storeUploadGoodsInfo(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_),.start(_,_),.updateGoodsFlagByStoreAndGoodsId(_,_),.updateGoodsByStoreAndGoodsId(_,_,_,_,_),.addGoodsInfoGoToStoreAndGoods_detail(_,_,_,_,_,_):
            return .post
        case .queryGoodsCodeIsExist(_,_),.queryStoreAndGoodsList(_,_,_,_,_),.queryStoreAndGoodsDetail(_,_):
            return .get
        }
    }
    
    public var sampleData: Data {
        return "".data(using:.utf8)!
    }
    public var task: Task {
        switch self {
        case let .storeUploadGoodsInfo(goodsCode, storeId, goodsName, goodsUnit, goodsLift, goodUcode, fCategoryId, sCategoryId, tCategoryId, goodsPic, goodsPrice, goodsFlag, stock, remark, weight,brand, goodsMixed,offlineStock):
            return .requestParameters(parameters:["goodsCode":goodsCode,"storeId":storeId,"goodsName":goodsName,"goodsUnit":goodsUnit,"goodsLift":goodsLift,"goodUcode":goodUcode,"fCategoryId":fCategoryId,"sCategoryId":sCategoryId,"tCategoryId":tCategoryId,"goodsPic":goodsPic,"goodsPrice":goodsPrice,"goodsFlag":goodsFlag,"stock":stock,"remark":remark ?? "","weight":weight ?? "","brand":brand ?? "","goodsMixed":goodsMixed ?? "","offlineStock":offlineStock], encoding:URLEncoding.default)
        case let .start(filePath,pathName):
            let imgData = MultipartFormData(provider: MultipartFormData.FormDataProvider.file(Foundation.URL(fileURLWithPath:filePath)),name:"file")
            let urlParameters = ["path":pathName]
            return .uploadCompositeMultipart([imgData],urlParameters: urlParameters)
        case let .queryGoodsCodeIsExist(goodsCode, storeId):
            return .requestParameters(parameters:["goodsCode":goodsCode,"storeId":storeId], encoding:URLEncoding.default)
        case let .queryStoreAndGoodsList(storeId, goodsFlag, pageNumber, pageSize,tCategoryId):
            if tCategoryId == nil{
                return .requestParameters(parameters:["storeId":storeId,"goodsFlag":goodsFlag,"pageNumber":pageNumber,"pageSize":pageSize],encoding:URLEncoding.default)
            }else{
                return .requestParameters(parameters:["storeId":storeId,"goodsFlag":goodsFlag,"pageNumber":pageNumber,"pageSize":pageSize,"tCategoryId":tCategoryId!],encoding:URLEncoding.default)
            }
        case let .updateGoodsFlagByStoreAndGoodsId(storeAndGoodsId, goodsFlag):
            return .requestParameters(parameters:["storeAndGoodsId":storeAndGoodsId,"goodsFlag":goodsFlag], encoding: URLEncoding.default)
        case let .updateGoodsByStoreAndGoodsId(storeAndGoodsId, goodsFlag, storeGoodsPrice, stock, offlineStock):
            return .requestParameters(parameters:["storeAndGoodsId":storeAndGoodsId,"goodsFlag":goodsFlag ?? "","storeGoodsPrice":storeGoodsPrice ?? "","stock":stock ?? "","offlineStock":offlineStock ?? ""], encoding: URLEncoding.default)
        case let .queryStoreAndGoodsDetail(storeAndGoodsId, storeId):
            return .requestParameters(parameters:["storeAndGoodsId":storeAndGoodsId,"storeId":storeId], encoding: URLEncoding.default)
        case let .addGoodsInfoGoToStoreAndGoods_detail(storeId, goodsId, storeGoodsPrice, goodsFlag, stock, offlineStock):
            
            return .requestParameters(parameters: ["storeId":storeId,"goodsId":goodsId,"storeGoodsPrice":storeGoodsPrice,"goodsFlag":goodsFlag,"stock":stock,"offlineStock":offlineStock], encoding:URLEncoding.default)
        }
        
    }
    
    public var headers: [String : String]? {
        switch self {
        case .start(_):
            return ["Content-type":"multipart/form-data"]
        default:return nil
        }
    }
    
    
}
