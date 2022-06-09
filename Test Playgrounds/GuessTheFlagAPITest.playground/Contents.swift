import UIKit
import PlaygroundSupport

var country: String?

var urlParameter  = "Armenia"

func fetch() {
    let url = URL(string: "https://countryflagsapi.com/svg/\(urlParameter)")!
    let urlResuest = URLRequest(url: url)
    
    let task = URLSession.shared.dataTask(with: urlResuest) { data, response, error in
        
        if let data = data {
            print((String(data: data, encoding: .utf8) ?? "THIS API IS Returning NIL") as String)
            
        }
        else if let error = error {
            print(error)
        }
    }
    task.resume()
}





fetch()
