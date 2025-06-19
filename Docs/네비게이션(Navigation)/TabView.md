>[!question]
>GQ1. TabView란 정확히 무엇일까?
>GQ2. TabView를 어떻게 작성할까?
>GQ3. TabView를 쓰는 곳은 어디일까?

## TabView란?
대화형 사용자 인터페이스 요소를 사용해 여러 자식 뷰 간 전환할 수 있도록 하는 뷰

### 예시
```swift
TabView {
	Tab("Recieived", systemImage: "tray.and.arrow.down.fill") {
		ReceivedView()
	}
	.badge(2)
	
	Tab("Sent", systemImage: "tray.and.arrow.up.fill") { 
		SentView() 
	}
	
	Tab("Account", systemImage: "person.crop.circle.fill") { 
		AccountView() 
	} 
	.badge("!")
}
```

#### 결과물
![[Pasted image 20250617024054.png]]
## 주요 기능
 - 탭에 따라 외부 상태를 바꿔야 할 땐 init(selection: , content: ) 이니셜라이저를 사용한다.
 ```swift
 TabView(selection: $selection) { 
	 Tab("Received", systemImage: "tray.and.arrow.down.fill", value: 0) { 
		 ReceivedView() 
	 }
	 
	 Tab("Sent", systemImage: "tray.and.arrow.up.fill", value: 1) { 
		 SentView() 
	 }
	 
	 Tab("Account", systemImage: "person.crop.circle.fill", value: 2) { 
		 AccountView() 
	 } 
 }
 ```
 - `.tabViewStyle(.page)`로 페이지 스타일로도 구현하여 다수의 페이지를 스크롤할 수 있게 해준다.
 ```swift
 TabView {
	 FoeEach(cities) { city in 
		 TemperatureView(city)
	 }
 }
 .tabViewStyle(.page)
```
- `.tabViewStyle(.sidebarAdaptable)`로 비슷한 역할을 하는 탭끼리 그룹화할 수 있다.
	- TabSection을 사용하여 탭을 묶을 수 있다.
	- 하지만 이는 아이폰으로는 확인하기 힘들며, 아이패드에서 볼 수 있다.
```swift
TabView { 
	Tab("Requests", systemImage: "paperplane") { 
		RequestsView() 
	} 
	
	Tab("Account", systemImage: "person.crop.circle.fill") { 
		AccountView() 
	} 
	
	TabSection("Messages") { 
		Tab("Received", systemImage: "tray.and.arrow.down.fill") {
			ReceivedView() 
		} 
		
		Tab("Sent", systemImage: "tray.and.arrow.up.fill") { 
			SentView() 
		} 
		
		Tab("Drafts", systemImage: "pencil") { 
			DraftsView() 
		} 
	} 
} 
.tabViewStyle(.sidebarAdaptable)
```
- iPad + iPhone 양쪽 대응도 할 수 있다.
```swift
struct BrowseTabExample: View { 
	@Environment(\.horizontalSizeClass) var sizeClass 
	@State var selection: MusicTab = .listenNow 
	@State var browseTabPath: [MusicTab] = [] 
	@State var playlists = [Playlist("All Playlists"), Playlist("Running")] 
	
	var body: some View { 
		TabView(selection: $selection) { 
			Tab("Listen Now", systemImage: "play.circle", value: .listenNow) { 
				ListenNowView() 
			} 
			
			Tab("Radio", systemImage: "dot.radiowaves.left.and.right", value: .radio) { 
				RadioView() 
			} 
			
			Tab("Search", systemImage: "magnifyingglass", value: .search) { 
				SearchDetailView() 
			} 
			
			Tab("Browse", systemImage: "list.bullet", value: .browse) { 
				LibraryView(path: $browseTabPath) 
			} 
			.hidden(sizeClass != .compact) 
			
			TabSection("Library") { 
				Tab("Recently Added", systemImage: "clock", value: MusicTab.library(.recentlyAdded)) { 
					RecentlyAddedView() 
				} 
				
				Tab("Artists", systemImage: "music.mic", value: MusicTab.library(.artists)) { 
					ArtistsView() 
				} 
			} 
			.hidden(sizeClass == .compact) 
			
			TabSection("Playlists") { 
				ForEach(playlists) { playlist in 
					Tab(playlist.name, image: playlist.imafe, value: MusicTab.playlists(playlist)) { 
						playlist.detailView() 
					} 
				} 
			} 
			.hidden(sizeClass == .compact) 
		} 
		.tabViewStyle(.sidebarAdaptable) 
		.onChange(of: sizeClass, initial: true) { _, sizeClass in 
			if sizeClass == .compact && selection.showInBrowseTab { 
				browseTabPath = [selection] 
				selection = .browse 
			} else if sizeClass == .regular && selection == .browse { 
				selection = browseTabPath.last ?? .library(.recentlyAdded) 
			} 
		} 
	} 
} 

struct LibraryView: View { 
	@Binding var path: [MusicTab] 
	var body: some View { 
		NavigationStack(path: $path) { 
			List { 
				ForEach(MusicLibraryTab.allCases, id: \.self) { tab in 
					NavigationLink(tab.rawValue, value: MusicTab.library(tab)) 
				} 
				// Code to add playlists here } 
			.navigationDestination(for: MusicTab.self) { tab in 
				tab.detail() 
			} 
		} 
	} 
}
```
- 탭 사용자 맞춤화
	- `TabViewCustomization`로 사용자 맞춤형이 가능하다.
```swift
    @AppStorage("tab-customization") private var customization: TabViewCustomization = .init()

    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                MyHomeView()
            }
            .customizationID("com.myApp.home")

            Tab("Reports", systemImage: "chart.bar") {
                MyReportsView()
            }
            .customizationID("com.myApp.reports")

            TabSection("Categories") {
                Tab("Climate", systemImage: "fan") {
                    ClimateView()
                }
                .customizationID("com.myApp.climate")

                Tab("Lights", systemImage: "lightbulb") {
                    LightsView()
                }
                .customizationID("com.myApp.lights")
            }
            .customizationID("com.myApp.browse")
        }
        .tabViewStyle(.sidebarAdaptable)
        .tabViewCustomization($customization)
    }

```
## Keywords
+ TabView
+ TabSection

## References
- [애플 공식 문서](https://developer.apple.com/documentation/swiftui/tabview)
- 챗지피티(해석용)