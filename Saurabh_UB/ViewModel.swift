//
//  ViewModel.swift
//  Saurabh_UB
//
//  Created by saurabh srivastava on 11/08/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class ViewModel: NSObject {
    
    @IBOutlet var apiService:APIService!
    var cacheImages = [String:UIImage]()
    var imgObjs:[ImgObject] = []{
        didSet{
            self.reload?()
        }
    }
    var pageNo = 0
    var fetchMore = true
    var apiCalling = true
    var text = ""{
        didSet{
            self.getPhotos()
        }
    }
    var showLoader:Bool = false{
        didSet{
            self.showLoaderView?()
        }
    }
    
    var showLoaderView:(() -> Void)!
    var reload:(() -> Void)!
    
    func getPhotos(){
        if fetchMore == true && apiCalling == true{
            self.showLoader = true
            pageNo = pageNo+1
            apiService.getImages(pageNo, text, completion: {[weak self] (result,error) -> Void in
                self?.showLoader = false
                self?.apiCalling = false
                if let data = result as? [ImgObject]{
                    if data.count == 0{
                        self?.fetchMore = false
                    }
                    DispatchQueue.main.async {
                        self?.imgObjs += data
                    }
                }
               
            })
        }
    }
    func getImgObject(_ id:Int) -> ImgObject{
        if id == imgObjs.count-1{
            self.getPhotos()
            apiCalling = true
        }
        return imgObjs[id]
    }
    func getUrl(_ data:ImgObject) -> String{
        let url = "https://farm"+String(data.farm)+".static.flickr.com/"+String(data.server)+"/"+data.id+"_"+data.secret+".jpg"
        return url
    }

    func getImages(_ id:Int,completion:@escaping (_ img:UIImage) -> Void){
        let imgObj = imgObjs[id]
        let currentId = id
        let url = getUrl(imgObj)
        if cacheImages[url] !=  nil{
            let img = cacheImages[url]
            DispatchQueue.main.async {
                completion(img!)
            }
        }
        else{
            apiService.downloadImage(url, completion: {[weak self] (result,error) -> Void in
                if error == nil && result != nil{
                    if let img = result as? UIImage{
                        self?.cacheImages[url] = img
                        if id == currentId{
                            DispatchQueue.main.async {
                                completion(img)
                            }
                        }
                    }
                }
            })
        }
    }
}
