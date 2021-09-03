//
//  AnimeClient.swift
//  Refresh
//
//  Created by Jose Torres-Vargas on 7/17/21.
//

import Foundation

class AnimeClient {
    //sigleton
    static let shared = AnimeClient()
    var todaysDate: Date
    let queryHelper = QueryHelper()
    let baseURL = "https://graphql.anilist.co"
    var animeData: [MediaItem]? = []
    var animeDataIndex: [Int: Int]? = [:]
    var airingToday: [MediaItem]? = []

    
    private init() {
        print("Do nothing")
        self.todaysDate = Date()
    }
    
    func createJSON(currentPage: Int) -> Data? {
        let query = queryHelper.getQueryObj(currentPage: currentPage)
        let animeReq = AnimeRequest(query: query.request, variables: query.variables)
        let encoder = JSONEncoder()
        let dataJSON = try? encoder.encode(animeReq)
        return dataJSON
    }
    
    func getAnimeFor(season: String, vc: HomeController, currentPage: Int) {
        guard let data = createJSON(currentPage: currentPage) else {return}
        
        var request = URLRequest(url: URL(string: self.baseURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.uploadTask(with: request, from: data) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {return}
            
            do {
                let result = try JSONDecoder().decode(ResponseFormat.self, from: data)
                let mediaArray = result.data.Page.media
                let notDone: Bool = result.data.Page.pageInfo.hasNextPage
                
                for (index, item) in mediaArray.enumerated() {
                    self.animeData?.append(item)
                    self.animeDataIndex?[item.id] = index
                }
                
                if notDone {





                    self.getAnimeFor(season: "SUMMER", vc: vc, currentPage: currentPage + 1)
                } else {
                    DispatchQueue.main.async {
                        vc.collectionView.reloadData()
                    }
                }
                
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func getAnimeData(forID: Int) -> MediaItem? {
        guard let animeDataIndex = self.animeDataIndex else {return nil}
        guard let animeData = self.animeData else {return nil}
        if let index = animeDataIndex[forID] {
            return animeData[index]
        }
        return nil
    }
    
    func buildAiringToday(currentDate: Date) {
        guard let animeData = self.animeData else {return}
        let calander = Calendar.current
        let today = calander.component(.day, from: currentDate)
        for item in animeData {
            if let airingAt = item.nextAiringEpisode?.airingAt {
                let airingDate = Alarm.airingDay(seconds: airingAt)
                let airingDay = calander.component(.day, from: airingDate)
                if airingDay == today {
                    self.airingToday?.append(item)
                }
            }
        }
    }
}
