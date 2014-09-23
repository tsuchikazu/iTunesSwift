iTunesSwift
=====

iTunesSwift is simple library to access iTunes API written in Swift.


## Installation

1. This project has [Alamofire](https://github.com/Alamofire/Alamofire) dependency. 
Add iTunesSwift as a submodule, and update submodule recursively.

    ```sh
    cd YOUR_PROJECT_HOME
    git submodule add git@github.com:tsuchikazu/iTunesSwift.git Externals/iTunesSwift
    git submodule update --init --recursive
    ```

2. Open the `iTunesSwift` and `Alamofire` folder,  and drag `iTunesSwift.xcodeproj` and `Alamofire.xcodeproj` into the file navigator of your Xcode project.

    ```sh
    open Externals/iTunesSwift
    open Externals/iTunesSwift/Externals/Alamofire/
    # drag `iTunesSwift.xcodeproj` and `Alamofire.xcodeproj`
    ```

3. In Xcode, navigate to the target configuration window by clicking on the blue project icon.
Open the "Build Phases" panel, expand the "Link Binary with Libraries" group, add `iTunesSwift.framework` and `Alamofire.framework`.


## Usage
### Search 
```swift
import ITunesSwift

// Search All
iTunesApi.findAll().by("search keyword").request { (result ,  error) in
    println(result)
}
// Search albums (Specifiable all media and entity. Media.Music, Entity.MusicArtist, Entity.Software etc...)
iTunesApi.find(Entity.Album).by("search keyword").request { (result ,  error) in
    println(result)
}

// With Attributes
iTunesApi.find(Entity.Album).by(Attribute.ArtistTerm, term: "artist name").request() { (result , error) in
    println(result)
}
// With limit
iTunesApi.find(Entity.Album).by("search keyword").limit(10).request { (result ,  error) in
    println(result)
}
```

### Lookup
```swift
import ITunesSwift

// Lookup by simple id
iTunesApi.lookup(909253).request() { (result, error) in
    println(result)
}

// Lookup by AMG artist ID
iTunesApi.lookup("amgArtistId", 123).request() { (result, error) in
    println(result)
}
```


## License

iTunesSwift is released under an MIT license. See LICENSE for more information.
