### Type Casting

- 형 변환: 클래스의 상속에서 형변환이 있음 =>  `as` 키워드 사용

```swift
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

// 미디어 아이템을 담은 배열
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
```

<br/>

### Type Checking

- Object is Type: Object의 타입이 Type이면 true

```swift
var movieCount = 0
var songCount = 0

for item in library {
	if item is Movie {
		movieCount += 1
	} else if item is Song {
		songCount += 1
	}
}

print("Media library contains \(movieCount) movies and \(songCount) songs")
```

<br/>

결과:

```tex
Media library contains 2 movies and 3 songs
```

<br/>

### Downcasting

- Upcasting의 경우 캐스팅 불필요

- MeidaItem 타입의 객체를 Moive, Song객체로 캐스팅 
  - as?, as! 
- 캐스팅이 안될 경우
  - as?:  nil
  - as!:  에러

```swift
for item in library {
	if let movie = item as? Movie {
		print("Movie: \(movie.name), dir. \(movie.director)")
	}
	if let song = item as? Song {
		print("Song: \(song.name), by \(song.artist)")
	}
}

let one = library[0] as! Movie // 나는 library[0]가 Movie임이 확실
let two = library[0] as? Movie // 나는 library[0]가 Movie임을 추정 (nil)
let four = library[1] as? Movie // four에는 nil이 할당됨, library[1]은 Song 타입
let five = library[1] as! Movie // 런타임 에러 발생, library[1]은 Song 타입
```

<br/>

결과:

```tex
Movie: Casablanca, dir. Michael Curtiz
nil
nil
Fatal error: Unexpectedly found nil while unwrapping an Optional value
```

<br/>