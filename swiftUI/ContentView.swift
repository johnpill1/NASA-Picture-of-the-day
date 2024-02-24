//
//  ContentView.swift
//  swiftUI
//
//  Created by John Pill on 12/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var result: APODImage
    @State var showingAlert = false


    var body: some View {

            ScrollView {
                Text(result.title)
                    .font(.title2)
                    .bold()
            
                AsyncImage(url: URL(string: result.url),  content: { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(maxWidth: .infinity)
                         
                }, placeholder: {
                    ProgressView()
                })
                
                HStack{
                    Text("Date: \(result.date).")
                   // Text("By: \(result.copyright)")
                }
                .font(.caption)
                .bold()
                
                
                Text(result.explanation)
                    .font(.subheadline)
                    .padding(8)
                
            }
            .task { loadData() }
            .alert("Something wen't wrong :(", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) { }
        }
    }
    
    
    
    
    
    
    // FUNCTION TO FETCH DATA FROM THE INTERNET.
    
    // Demo API key = https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY
    // Only allowed 30 attempts an hour / 50 a day - to to the website and sign up for a free KEY.
    
    func loadData() {
        
        // 1 Check the url string is a vaild URL, if its not print invalid URL and exit function. X
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=7xgZtHI6uKSeheJQrnlbBGes3osjlY87I0PJuwJ2") else {
            print("Invalid URL")
            return
        }
        
        // 2 Use URLSession to make the call to the internet. It will return data and any responses and errors.
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // 3 Check if the data = nil.
            guard data != nil else {
                print("Invalid Data")
                return
            }
            print("Data: \(String(describing: data))")
            
            // 4 Check if there are any errors.
            if let error = error {
                print("Error: \(error)")
            }
            
            // 5 Create a decoder to decode the JSON.
            let decoder = JSONDecoder()
            
            // 6 Try and decode the data from JSON and Map to the APODImage struct.
            let decodedData = try? decoder.decode(APODImage.self, from: data!)
            print("Decoded Data: \(String(describing: decodedData))")
            // 7 Check if the data has decoded properly. I am triggering an alert if it fails.
            guard decodedData != nil else {
                showingAlert = true
                return
            }
            
            // 8 Store the decoded data into the result variable. async means to do this work on a background thread and not to block the main program.
            DispatchQueue.main.async {
                result = decodedData!
            }
        }.resume()
    }
}



struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(result: APODImage(date: "Today's date", explanation: "Explanation", hdurl: "HD URL", media_type: "Media Type", service_version: "Version", title: "Title", url: "URL"))
    }
}



