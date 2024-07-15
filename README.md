# (Crazy) CatLady+ iOS app companion
Browse through your favourite cat breeds and learn everything about them

## Thoughts on building this application

Started with setting up the project with MVVM in mind.

Development started on UI, to setup a rough UX of the tab view with two tabs:
- Tab one would be a list view with all cat breed models fetched from api
- Tab two would meet the requirement of listing all cat breed models that user favourited
- Tapping on either list view cells would navigate to that specific cat breed screen

From start, views of breed lists and it's cells would be reusable, actually the whole screen was reused with a single favourite filter modifier
I've separated views into Screens (a bundle of complex views that would make a full view in the app), Views (complex views built from base UI views from SwiftUI)
As ViewModels goes, I've ended up with just one in the codebase (CatBreedListView.ViewModel) - as most other views would have just a CatBreedModel @Bindable

Once UX was roughly done, focused in networking and populating the screens with actual data.

Like I usually do, I build an agnostic networking/parsing in a single class (as they are simple enough for this use case), endpoints went to an enum with computed variables for corresponding URL path, queryString and headers. And then bind them both in a datasource that would simplify everything to a function to app's consumption.

Opted with an implementation of search with models in memory, meaning each screen would fetch their datasets and hold them. Search would operate on that dataset to filter.
 The would thing would eventually become quite simpler once I've put in place SwiftData

Started persistence with favourites (before persisting api models). Started with an UserDefaults implementation for the favourite ids, but once I had SwiftData up and running just associated a bool to the CatBreedModel and everything just became simpler, e.g. only had to pass a single model to cells and detail screens.

The most complex view that I have is CatBreedListView and sent all testable logic to the ViewModel. Only view logic or instructions with close proximity to SwiftData modelContext I've kept on the actual view.

In regards to tests, I usually start working on them once I have stable interfaces. Another thing I'd like to notice is I'm not stubbing networking calls as I usually do, for simplicity and to avoid just importing third parties all together.

Didn't go too wild on UITests, just focused in the golden path (List, check there's cells, navigate to detail, navigate back and find the last cat in the scroll view).
