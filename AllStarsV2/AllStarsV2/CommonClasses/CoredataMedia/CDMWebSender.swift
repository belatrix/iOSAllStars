//
//  CDMWebSender.swift
//  Survey
//
//  Created by Kenyi Rodriguez on 8/04/16.
//  Copyright © 2016 Core Data Media. All rights reserved.
//

import UIKit
import Alamofire

public class CDMWebSender: NSObject {
    

    
    //MARK:- Configuración
    
    class func createHeaderRequest() -> [AnyHashable : Any] {
        
        var diccionarioHeader = [AnyHashable : Any]()
        
        diccionarioHeader["Content-Type"] = "application/json; charset=UTF-8"
        diccionarioHeader["Accept"] = "application/json"
        
        return diccionarioHeader
    }
    
    
    
    
    class func createHeaderRequestToken(_ aToken : String) -> [AnyHashable : Any] {
        
        var diccionarioHeader = [AnyHashable : Any]()
        
        diccionarioHeader["Content-Type"] = "application/json; charset=UTF-8"
        diccionarioHeader["Accept"] = "application/json"
        diccionarioHeader["Authorization"] = "Token \(aToken)"
        
        return diccionarioHeader
    }
    
    
    
    
    class func createHeaderRequestCookie(_ aCookie : String) -> [AnyHashable : Any] {
        
        var diccionarioHeader = [AnyHashable : Any]()
        
        diccionarioHeader["Content-Type"] = "application/json; charset=UTF-8"
        diccionarioHeader["Accept"] = "application/json"
        diccionarioHeader["Cookie"] = "Bearer \(aCookie)"
        
        return diccionarioHeader
    }
    
    
    
    
    //MARK: - Tratado de respuesta
    
    
    class func getResponseJSON(withData data : Data) -> Any? {
        
        do{
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as Any
        }catch{
            return nil
        }
    }
    
    
    
    
    class func getResponseService(toData data : Data?, withResponse response : URLResponse?, withError error : Error?) -> CDMWebResponse{
        
        var responseData : Any? = nil
        
        if error == nil && data != nil {
            responseData = self.getResponseJSON(withData: data!)
        }
        
         print("respuesta servicio \(String(describing: responseData))")
        
        let urlResponse = response as? HTTPURLResponse
        
        let headerFields = urlResponse?.allHeaderFields as? [String : Any]
        let objRespuesta = CDMWebResponse()
        
        objRespuesta.JSON               = responseData
        objRespuesta.respuestaNSData    = data
        objRespuesta.error              = error
        objRespuesta.datosCabecera      = headerFields
        objRespuesta.token              = headerFields?["_token"] as? String
        objRespuesta.cookie             = headerFields?["_token"] as? String
        
        if let statusCode = urlResponse?.statusCode{
            objRespuesta.statusCode = statusCode
            objRespuesta.successful = (statusCode >= 200 && statusCode <= 299) ? true : false
        }
        
        return objRespuesta
    }
    
    

    
    //MARK: Consumo de servicios con cookie

    
    
    @discardableResult public class func doPOSTCookieToURL(_ url : String, withPath path : String, withParameter parameters : Any?, withCookie cookie : String, withCompletion completion : @escaping (_ objResponse : CDMWebResponse) -> Void) -> URLSessionDataTask {
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = self.createHeaderRequestCookie(cookie)
        
        let sesion = URLSession.init(configuration: sessionConfiguration)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parameters != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "POST"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            
            DispatchQueue.main.async(execute: {
                
                let objResponse = self.getResponseService(toData: data, withResponse: response, withError: error)
                completion(objResponse)
            })
        }
        
        
        postDataTask.resume()
        return postDataTask
    }
    
    
    
    
    
    
    
    @discardableResult public class func doGETCookieToURL(_ url : String, withPath path : String, withParameter parameters : Any?, withCookie cookie : String, withCompletion completion : @escaping (_ objResponse : CDMWebResponse) -> Void) -> URLSessionDataTask  {
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = self.createHeaderRequestCookie(cookie)
        
        let sesion = URLSession.init(configuration: sessionConfiguration)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parameters != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "GET"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            
            DispatchQueue.main.async(execute: {
                
                let objResponse = self.getResponseService(toData: data, withResponse: response, withError: error)
                completion(objResponse)
            })
        }
        
        
        postDataTask.resume()
        return postDataTask
    }
    
    
    
    
    
    
    
    
    
    @discardableResult public class func doPUTCookieToURL(_ url : String, withPath path : String, withParameter parameters : Any?, withCookie cookie : String, withCompletion completion : @escaping (_ objResponse : CDMWebResponse) -> Void) -> URLSessionDataTask  {
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = self.createHeaderRequestCookie(cookie)
        
        let sesion = URLSession.init(configuration: sessionConfiguration)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parameters != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "PUT"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            
            DispatchQueue.main.async(execute: {
                
                let objResponse = self.getResponseService(toData: data, withResponse: response, withError: error)
                completion(objResponse)
            })
        }
        
        
        postDataTask.resume()
        return postDataTask
    }

    
    
    
    
    
    
    
    
    

    //MARK: - Consumo de servicios con token
    
    
    @discardableResult public class func doPATCHTokenToURL(_ url : String, withPath path : String, withParameter parameters : Any?, withToken token : String, withCompletion completion : @escaping (_ objResponse : CDMWebResponse) -> Void) -> URLSessionDataTask {
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = self.createHeaderRequestToken(token)
        
        let sesion = URLSession.init(configuration: sessionConfiguration)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parameters != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "PATCH"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            
            DispatchQueue.main.async(execute: {
                
                let objResponse = self.getResponseService(toData: data, withResponse: response, withError: error)
                completion(objResponse)
            })
        }
        
        
        postDataTask.resume()
        return postDataTask
    }
    
    
    
    @discardableResult public class func doPOSTTokenToURL(_ url : String, withPath path : String, withParameter parameters : Any?, withToken token : String, withCompletion completion : @escaping (_ objResponse : CDMWebResponse) -> Void) -> URLSessionDataTask {
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = self.createHeaderRequestToken(token)
        
        let sesion = URLSession.init(configuration: sessionConfiguration)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parameters != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "POST"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            
            DispatchQueue.main.async(execute: {
                
                let objResponse = self.getResponseService(toData: data, withResponse: response, withError: error)
                completion(objResponse)
            })
        }
        
        
        postDataTask.resume()
        return postDataTask
    }
    
    
    
    
    
    
    
    @discardableResult public class func doGETTokenToURL(_ url : String, withPath path : String, withParameter parameters : Any?, withToken token : String, withCompletion completion : @escaping (_ objResponse : CDMWebResponse) -> Void) -> URLSessionDataTask {
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = self.createHeaderRequestToken(token)
        
        let sesion = URLSession.init(configuration: sessionConfiguration)
        
        let urlServicio = URL(string: "\(url)\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parameters != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "GET"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            
            DispatchQueue.main.async(execute: {
                
                let objResponse = self.getResponseService(toData: data, withResponse: response, withError: error)
                completion(objResponse)
            })
        }
        
        
        postDataTask.resume()
        return postDataTask
    }
    
    
    
    
    
    
    
    
    
    @discardableResult public class func doPUTTokenToURL(_ url : String, withPath path : String, withParameter parameters : Any?, withToken token : String, withCompletion completion : @escaping (_ objResponse : CDMWebResponse) -> Void) -> URLSessionDataTask {
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = self.createHeaderRequestToken(token)
        
        let sesion = URLSession.init(configuration: sessionConfiguration)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parameters != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "PUT"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            
            DispatchQueue.main.async(execute: {
                
                let objResponse = self.getResponseService(toData: data, withResponse: response, withError: error)
                completion(objResponse)
            })
        }
        
        
        postDataTask.resume()
        return postDataTask
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Consumo de servicios simple
    
    
    
    @discardableResult public class func doPOSTToURL(_ url : String, withPath path : String, withParameter parameters : Any?, withCompletion completion : @escaping (_ objResponse : CDMWebResponse) -> Void) -> URLSessionDataTask{
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = self.createHeaderRequest()
        
        let sesion = URLSession.init(configuration: sessionConfiguration)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parameters != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "POST"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            
            DispatchQueue.main.async(execute: {
                
                let objResponse = self.getResponseService(toData: data, withResponse: response, withError: error)
                completion(objResponse)
            })
        }
        
        
        postDataTask.resume()
        return postDataTask
    }
    
    
    
    
    
    
    
    @discardableResult public class func doGETToURL(_ url : String, withPath path : String, withParameter parameters : Any?, withCompletion completion : @escaping (_ objResponse : CDMWebResponse) -> Void) -> URLSessionDataTask{
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = self.createHeaderRequest()
        
        let sesion = URLSession.init(configuration: sessionConfiguration)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parameters != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "GET"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            
            DispatchQueue.main.async(execute: {
                
                let objResponse = self.getResponseService(toData: data, withResponse: response, withError: error)
                completion(objResponse)
            })
        }
        
        
        postDataTask.resume()
        return postDataTask
    }
    
    
    
    
    
    
    
    
    @discardableResult public class func doPUTToURL(_ url : String, withPath path : String, withParameter parameters : Any?, withCompletion completion : @escaping (_ objResponse : CDMWebResponse) -> Void) -> URLSessionDataTask {
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = self.createHeaderRequest()
        
        let sesion = URLSession.init(configuration: sessionConfiguration)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        let request = NSMutableURLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parameters != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "PUT"
        
        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
            
            DispatchQueue.main.async(execute: {
                
                let objResponse = self.getResponseService(toData: data, withResponse: response, withError: error)
                completion(objResponse)
            })
        }
        
        
        postDataTask.resume()
        return postDataTask
    }
    
    class func createHeaderWithToken(_ aToken : String) -> HTTPHeaders {
        
        var dicHeader : HTTPHeaders = HTTPHeaders()
        dicHeader["Authorization"] = "Token \(aToken)"
        
        return dicHeader
    }
    
    
    public class func uploadRequest(_ image: UIImage, withURL url : String, withPath path : String, withParameter parameters : [String: Any]?, withToken token: String, withCompletion completion : @escaping (_ objResponse : CDMWebResponse) -> Void)
    {
        let urlServicio = URL(string: "\(url)/\(path)")
        
        Alamofire.SessionManager.default.upload(multipartFormData: { (multipart) in
            
            multipart.append(UIImageJPEGRepresentation(image, 0.5)!, withName: "image", fileName: "testName.jpg", mimeType: "image/jpg")
            
        }, usingThreshold: UInt64.init(), to: urlServicio!, method: HTTPMethod.post, headers: self.createHeaderWithToken(token)) { (encodingResult) in
            
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("statusCode: \(response.response!.statusCode)")
                    print("response: \(String(describing: response.result.value))")
                    
                    let objResponse = self.getResponseService(toData: nil, withResponse: response.response, withError: nil)
                    completion(objResponse)
                    
                }
            case .failure(let encodingError):
                print("error: \(encodingError)")
                
                let objResponse = self.getResponseService(toData: nil, withResponse: nil, withError: nil)
                completion(objResponse)
            }
        }
    }
    
//    @discardableResult public class func uploadRequest(_ image: UIImage, withURL url : String, withPath path : String, withParameter parameters : [String: Any]?, withToken token: String, withCompletion completion : @escaping (_ objResponse : CDMWebResponse) -> Void) -> URLSessionDataTask
//    {
//        let urlServicio = URL(string: "\(url)/\(path)")
//        let request = NSMutableURLRequest(url: urlServicio!)
//        request.httpMethod = "POST";
//
//        let boundary = self.generateBoundaryString()
//
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//
//        let imageData = UIImageJPEGRepresentation(image, 1)
//        request.httpBody = self.createBodyWithParameters(parameters, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
//
//        let sessionConfiguration = URLSessionConfiguration.default
//        sessionConfiguration.httpAdditionalHeaders = self.createHeaderRequestToken(token)
//        let sesion = URLSession.init(configuration: sessionConfiguration)
//
//        let postDataTask = sesion.dataTask(with: request as URLRequest) { (data, response, error) in
//
//            DispatchQueue.main.async(execute: {
//
//                let objResponse = self.getResponseService(toData: data, withResponse: response, withError: error)
//                completion(objResponse)
//            })
//        }
//
//
//        postDataTask.resume()
//        return postDataTask
//
//    }
//
//
//    public class func createBodyWithParameters(_ parameters: [String: Any]?, filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
//        var body = Data();
//
//        if parameters != nil {
//            for (key, value) in parameters! {
//                body.append(string: "--\(boundary)\r\n")
//                body.append(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//                body.append(string: "\(value)\r\n")
//            }
//        }
//
//        let filename = "user-profile.jpg"
//        let mimetype = "image/jpg"
//
//        body.append(string:"--\(boundary)\r\n")
//        body.append(string:"Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
//        body.append(string:"Content-Type: \(mimetype)\r\n\r\n")
//        body.append(imageDataKey)
//        body.append(string:"\r\n")
//
//        body.append(string:"--\(boundary)--\r\n")
//
//        return body
//    }
//
//
//
//    public class func generateBoundaryString() -> String {
//        return "Boundary-\(NSUUID().uuidString)"
//    }
//
//
    
    
    public class func getMessageError(toData data : [String : Any]?) -> String {
        
        var mensajeError = "Problemas de conexión"
        
        if data != nil && data?["mensaje"] != nil {
            
            mensajeError = data?["mensaje"] as! String
        }
        
        return mensajeError
    }
}


extension Data {
    mutating func append(string: String) {
        let data = string.data(
            using: String.Encoding.utf8,
            allowLossyConversion: true)
        append(data!)
    }
}
