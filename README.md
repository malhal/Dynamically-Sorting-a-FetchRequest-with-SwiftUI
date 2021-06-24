# Dynamically Sorting a FetchRequest with SwiftUI

This project demonstrates how to dynamically sort a `@FetchRequest` using SwiftUI.

Many struggle with understanding that SwiftUI is simply a hierarchy of structs of data, not rendered views in the traditional MVC sense. In SwiftUI, we init structs in the body method. The structs, being value types are trivial to recreate over and over again, however the body of those structs is only called if the params to the init method are different. Once we understand this crucial part of SwiftUI's design it is trivial to solve the problem of dynamic fetch requests.

In the sample we define a state of truth `sortAscending` in `ContentView`. When any state of truth in `ContentView` is changed, e.g. `@State` or `@AppStorage`, or any binding to a state of truth further up the hierarchy, e.g. `@Binding`, (although we only have one in the example), its body runs and the init method `FetchedItems(sortAscending: sortAscending)` is called. However body of `FetchedItems : View` is only called when the `sortAscending` param is different. This means we will not unnecessarily query the Core Data SQLite database, all thanks to SwiftUI's design! Knowing this we can easily build a `View` hierarchy that has a dynamic sort.
