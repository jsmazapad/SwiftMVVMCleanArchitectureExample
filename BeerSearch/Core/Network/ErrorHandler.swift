import Foundation
import Alamofire

class ErrorHandler{

    func handleError(error:AFError?)->Error{
        var errorProcesed = NetworkError(message:NSLocalizedString("error.network.unknown", comment: ""), code:0)
        if let error = error, let code = error.responseCode{
            switch code {
            case 400:
                errorProcesed = NetworkError(message:NSLocalizedString("error.badrequest", comment: ""), code:code)
                break;
            case 500:
                errorProcesed = NetworkError(message:NSLocalizedString("error.internalserver", comment: ""), code:code)
                break;
            default:
                 errorProcesed = NetworkError(message:NSLocalizedString("error.network", comment: ""), code:code)
                break;
            }
        }
        
        return errorProcesed
        
    }
}
