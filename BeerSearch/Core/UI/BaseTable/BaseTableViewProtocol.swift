import Foundation
import UIKit

protocol BaseTableViewCellProtocol:UITableViewCell{
   
    static var  identifierForReuse:String { get set }
    func fillCell(element:Any)
}
