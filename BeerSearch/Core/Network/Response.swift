import Foundation

class Response<Type>{
    var response:Array<Type>?
    var error: Error?
    init(response:Array<Type>?, error: Error?)
    {
        self.response = response
        self.error = error
    }
    
}
