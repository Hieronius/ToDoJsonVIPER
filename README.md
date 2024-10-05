# ✏️About
Simple app to manage your tasks. You can create, save, edit and check tasks if they are done.

## 🛠Tools/Technologies
- iOS 15
- UIKit
- GCD
- CollectionView
- DiffableDataSource
- CoreData
- URLSession
- UserDefaults
- Dependency Injection
- VIPER Architecture
- XCTest

## 📺Demo
1. Loading tasks from internet, adding them to the screen and saving into CoreData.
2. Creation of a new task


https://github.com/user-attachments/assets/5b61a29e-2169-471e-97e9-7769d7442e4d

3. Editing an existing task


https://github.com/user-attachments/assets/71da15d7-ceff-4e0b-8d27-fe04fb7365b0

4. Filtering tasks by categories


https://github.com/user-attachments/assets/026aec4e-e83e-44e7-9b50-fda8ce035845


## 📌ToDo
1. Complete refactoring all parts of the app accordingly to VIPER.
2. Refactor and complete documentation.
3. Edit current tests and add tests for ToDoManager, CoreDataManager, UserManager, TaskIDManager.
4. Fix the case when tasks title being crossed without being completed.
5. Add Activity Indicator View for the time user might wait for tasks update in first app running.
6. Refactor Input/Output protocols of the Views accordingly to VIPER.
7. Put all protocols of the single module to the *ModuleNameContract file to improve readability and decrease code load of the entities ✅
8. Implement the mechanic to load tasks from CoreData only once when user runs the app first time.
9. Decouple MainScreenPresenter method viewDidLoad and call presenter from viewDidLoad of the MainScreenViewController
10. Add a special private queue and context to work with CoreData
11. Check and refactor if needed the way of CoreData saving of the tasks when app was terminated/suspended
12. Inject CoreDataManager through dependency injection instead of using singleton
13. Add check of existing tasks id's and userId's when you create a new ones
14. Refactor UserManager to use through dependency injection
15. Refactor TasksIDManager to use through dependency injection
16. Restrict ability to select past date as a deadline
17. Add custom app icon
18. Polish UI accordingly to design
19. Restrict ability to save an empty task
20. Implement "back" button to the TaskScreen in case if user changed mind to create the new one
21. Refactor the way of cells being reused when you scroll the list of tasks.
22. Find the way to implement swipe actions on cells with custom spacing between them via CollectionView + DiffableDataSource
23. Cut View's into logical pieces by extensions: setupLayout, setupApperance and so on.
24. Provide custom enum with CoreData/URLSession errors with localization and description for better user experience and error handling


