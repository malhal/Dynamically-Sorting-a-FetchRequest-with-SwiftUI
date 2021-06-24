# Dynamically-Sorting-a-FetchRequest-with-SwiftUI
Dynamically Sorting a FetchRequest with SwiftUI

This project demonstrates how to dynamically sort a @FetchRequest using SwiftUI.

Many struggle with understanding that SwiftUI is simply a hierarchy of structs of data. We init structs in the body method, and the body of those structs is only called if the params to the init method are different. Once we understand this crucial part of SwiftUI's design it is trivial to solve this problem.

 
In the sample we define a state of truth `sortAscending` in Content View. When any state of truth in ContentView is changed (although we only have one in the example), its body runs and the init method `FetchedItems(sortAscending: sortAscending)` is called. However body of the `FetchedItems` View is only called when the `sortAscending` param is different. This means we will not unncecesasy query the Core Data SQLite database, all thanks to SwiftUI's design! Knowing this we can easily build a View hierarchy that has a dynamic sort.
