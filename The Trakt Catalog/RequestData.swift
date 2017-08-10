//
//  RequestData.swift
//  The Trakt Catalog
//
//  Created by Fabricio Dos Santos Rodrigues on 07/08/17.
//  Copyright © 2017 fabricio. All rights reserved.
//

import UIKit
import Alamofire

class RequestData: NSObject {
    
    func requestListHome(completionHandler: @escaping ([ListObject], Error?) -> ()) {
        
        let headers = ["Content-Type": "application/json",
                       "trakt-api-version": "2",
                       "trakt-api-key": "5c7741e3d50e1cbce2cbaee64b7ed4fcfbc938291f04b06ae31f727b6e7f990c"]
        
        
        Alamofire.request("https://api.trakt.tv/movies/popular", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData { response in
            
            switch response.result {
            case .success(_):

                do {
                    
                    let objJson = try JSONSerialization.jsonObject(with: response.result.value!, options: []) as! NSArray
                    
                    let dados = ListObject.from(objJson)

                    completionHandler(dados!, nil)
                    
                    
                    
                } catch {
                    print("error")
                }
                
                break
                
            case .failure(_):
                print(response.error as Any)
                //completionHandler("error", response.error)
                
                break
                
            }
            
        }
        
        
    }
    
      
    func requestMoveDetails(idMovie: Int, completionHandler: @escaping (ListDetailsObject, Error?) ->()) {
        Alamofire.request("https://api.themoviedb.org/3/movie/\(idMovie)?api_key=c8676c30c72e30216028908b86a31b13", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { response in
            
            switch response.result {
            case .success(_):
                
                do {
                    
                     let objJson = try JSONSerialization.jsonObject(with: response.result.value!, options: []) as! NSDictionary
                
                    let details = ListDetailsObject.from(objJson)
                    completionHandler(details!, nil)
                    
                    
                    
                } catch {
                    print("error")
                }
                
                break
                
            case .failure(_):
                print(response.error as Any)
                //completionHandler("error", response.error)
                
                break
                
            }
            
        }

    }
    
    func requestListImages(idMovie: Int, completionHandler: @escaping ([CollectionDetailsObject], Error?) -> ()) {
        
            Alamofire.request("https://api.themoviedb.org/3/movie/\(idMovie)/images?api_key=c8676c30c72e30216028908b86a31b13", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { response in
            
            switch response.result {
                
            case .success(_):
                
                do {
                    
                    let objJson = try JSONSerialization.jsonObject(with: response.result.value!, options: []) as! NSDictionary
                    
                    let details = CollectionDetailsObject.from(objJson)
                    
                    completionHandler([details!], nil)
                    
                    
                } catch {
                    print("error")
                }
                
                break
                
            case .failure(_):
                print(response.error as Any)
                //completionHandler("error", response.error)
                
                break
                
            }

                
        }
        
        
    }


}

