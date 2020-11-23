import Foundation
import Bond

class LoadingVM{

    var isLoading:Observable<Bool> = Observable(true)
    var error:Observable<Error?> = Observable(nil)

}
