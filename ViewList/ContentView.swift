//
//  ContentView.swift
//  ViewList
//
//  Created by Hiroki Kayanuma on 2020/09/21.
//

import SwiftUI
struct InstagramApi: Codable  {
    var username: String
    var account_type: String
    var media_count: Int
    var media: Media
    var id: String
    
    // struct second level etc...
    struct Media: Codable {
        var data: Array<Id>
        var paging: Paging
        
    }
    struct Id: Codable {
        var id: String
    }
    struct Cursors: Codable {
        var before: String
        var after: String
    }
    struct Paging: Codable{
        var cursors: Cursors
        var next: String
    }
    
}
let oauth = OAuth()
var uri = "https://graph.instagram.com/17841400865320045?fields=\(oauth.fields)&access_token=\(oauth.long_access_token)"


struct ContentView: View {
    var body: some View {
        VStack(content: {
            Text("Hello, world!")
                .padding()
            Button("Go", action: {get_response(urlStr: uri)})
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func get_response(urlStr: String) {
    let url = URL(string: urlStr)!
    let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
                // コンソールに出力
                print("data: \(String(describing: data))")
                print("response: \(String(describing: response))")
                print("error: \(String(describing: error))")
        guard let jsonData = data else {
                        return
                    }
                    
                    do {
                        let articles = try JSONDecoder().decode(InstagramApi.self, from: jsonData)
                        print(articles)
                    } catch {
                        print(error.localizedDescription)
                    }
            })
            task.resume()
}
