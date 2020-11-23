import Foundation
import UIKit

protocol ParentTableViewCellProtocol:UITableViewCell{
   
    static var  identifierForReuse:String { get set }
    func fillCell(element:Any)
}
