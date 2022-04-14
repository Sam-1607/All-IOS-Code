import UIKit

let headers  = [
    "X-RapidAPI-Host": "api-basketball.p.rapidapi.com",
        "X-RapidAPI-Key": "3e4fa7a698msha88ceb1d7d66dc8p154ec3jsn31c14c39616b"
]

    
var urlRequest = NSMutableURLRequest(url: NSURL(string: "https://api-basketball.p.rapidapi.com/leagues")! as URL)
urlRequest.allHTTPHeaderFields = [
    "X-RapidAPI-Host": "api-basketball.p.rapidapi.com",
        "X-RapidAPI-Key": "3e4fa7a698msha88ceb1d7d66dc8p154ec3jsn31c14c39616b"
]
let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { data, response, error in
  if let data = data,
    let string = String(data: data, encoding: .utf8) {
      print(string)
    }
}
task.resume()
