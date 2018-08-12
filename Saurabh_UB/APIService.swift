//
//  APIService.swift
//  Saurabh_UB
//
//  Created by saurabh srivastava on 11/08/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class APIService: NSObject {
    func getImages(_ pageNo:Int, _ text:String,  completion:@escaping (_ response:Any? ,_ error:String?) -> Void){
        var newtext = text.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&text="+newtext+"&page="+String(pageNo))!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil,error?.localizedDescription)
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]{
                    if let artDict = json["photos"] as? [String:Any]{
                        if let imgDict = artDict["photo"] as? [[String:Any]]{
                            var imgs = [ImgObject]()
                            for dict in imgDict{
                                var img = ImgObject()
                                img.updateData(dict)
                                imgs.append(img)
                            }
                            DispatchQueue.main.async {
                                completion(imgs,nil)
                            }
                        }
                       
                    }
                }
            }
            catch{
                DispatchQueue.main.async {
                    completion(nil,"")
                }
            }
        }
        task.resume()
    }

    
    func downloadImage(_ url:String, completion:@escaping (_ response:Any? ,_ error:String?) -> Void) {
        getDataFromUrl(url: URL(string: url)!) { data, response, error in
            guard let data = data, error == nil else { return }
            completion(UIImage(data: data),nil)
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
}
