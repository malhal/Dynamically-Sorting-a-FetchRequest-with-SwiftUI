# Dynamically Sorting a FetchRequest with SwiftUI

This project demonstrates how to dynamically sort an `@FetchRequest` using SwiftUI.

Many struggle with understanding that SwiftUI is simply a hierarchy of structs of data, not rendered views in the traditional MVC sense. In SwiftUI, we init child `View` structs in the `body` method. The structs, being value types are trivial to recreate over and over again, however the body of those structs is only called if the params to the init method are different. Furthermore, the work to re-render actual things on screen is only done if the results of the body method is different from the last time there was an update. Once we understand these crucial parts of SwiftUI's design it is trivial to solve the problem of dynamic fetch requests.

In the sample we define a state of truth `sortAscending` in `ContentView`. When any state of truth in `ContentView` is changed, e.g. `@State` or `@AppStorage`, or any binding to a state of truth further up the hierarchy, e.g. `@Binding`, (although we only have one in the example), its body runs and the init method `FetchedItems(sortAscending: sortAscending)` is called. However, the body method of `FetchedItems : View` is only called when the `sortAscending` param is different. This means we will not unnecessarily query the Core Data SQLite database, all thanks to SwiftUI's design! Knowing this we can easily build a `View` hierarchy that has a dynamic sort. When we break our data up like this into small View structs, we call this having tight invalidation.

My last tip is in SwiftUI don't name your `View` structs based on screens or chunks of screen like we would do in UIKit. Instead, name them based on the data contained in the struct, or if that is too difficult simply name them `ContentView2`, `ContentView3` etc.

Note, although this is a universal app, I worked on the iOS target only.
