import Alamofire
import ObjectMapper
import Bond


class AlamofireWService: NSObject{
    
    
    typealias PreResponseProcessHandler<Type> = (_ jsonResponse : [[String : Any?]]?, _ error:Error?, _ type: Type, _ decoder: DecoderProtocol, _ completion: @escaping (_ result: Response<Type>) -> Void)  -> Void
    
    let baseUrl:String = ConfigConstants.getBaseUrl()
    
    var errorHandler = ErrorHandler()
    
    
    func sendRequest <Type>(url:String, type:Type, decoder:DecoderProtocol, parameters:Dictionary<String, Any> = Dictionary<String, Any>(), method:HTTPMethod = HTTPMethod.post, completion: @escaping (_ result: Response<Type>) -> Void, handler: @escaping PreResponseProcessHandler<Type> ){
        
        
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]
        
        let requestUrl = baseUrl+url
        
        AF.request(requestUrl, method: method, parameters:parameters, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let code = response.response?.statusCode {
                        if(code == 200){
                            let json = response.value as? Array<[String: Any]>
                            
                            handler(json, response.error, type, decoder,  completion)
                            
                        }else{
                            let errorToReturn:Error = self.errorHandler.handleError(error: response.error)
                            handler(nil, errorToReturn, type, decoder, completion)
                        }
                    }
                    
                case .failure(let error):
                    let errorToReturn = self.errorHandler.handleError(error: error)
                    handler(nil, errorToReturn, type, decoder, completion)
                }
        }
    }
    
    
    
    func handleArrayResponse <Type> (response:[[String : Any?]]?, error:Error?,  type: Type, decoder: DecoderProtocol, completion: @escaping (_ result: Response<Type>) -> Void) -> Void
    {
        var objectsResponse:Array<Type>?
        if(error == nil && response != nil){
            if let response = response
            {
                objectsResponse = decoder.decode(object: response) as? Array<Type>
            }
            
        }
        
        completion(Response<Type>(response: objectsResponse, error: error))
        
    }
    
}

