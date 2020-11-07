# MoneytreeLite

Another iOS app using MVP and Clean architecture.

<img src="https://user-images.githubusercontent.com/3298414/98437855-2ac71d00-2129-11eb-8ac2-9a02246463b9.png" height="300" /><img src="https://user-images.githubusercontent.com/3298414/98437883-67931400-2129-11eb-9ba7-3673fdb40cea.png" height="300" />

### User Stories

1. User should be able to see a list of accounts and the total balance of those accounts in the user's currency. The list should be ordered by the account's nickname and grouped by its institution. Each row should display the nickname and the balance in that account's currency.
2. User should be able to tap on the account to see the list of transactions on that account. The transactions should be ordered by month, from the newest one to the oldest. Each row on the transactions list should display the transaction date, description and its amount in the account's currency.

#### Missing Accessibility details

Accessibility features haven't been implemented but we can set `accessibilityLabel` for VoiceOver and implement Dynamic Fonts for visually impaired users.

#### Presentation Logic
* `View` - delegates user interaction events to the `Presenter` and displays data passed by the `Presenter`
    * All `UIViewController`, `UIView`, `UITableViewCell` subclasses belong to the `View` layer
* `Presenter` - contains the presentation logic and tells the `View` what to present
    * one `Presenter` per scene (view controller)
    * It doesn't reference the concrete type of the `View`, but rather it references the `View` protocol that is implemented usually by a `UIViewController` subclass
    * plain `Swift` class and not reference any `iOS` framework classes
* `Configurator` - injects the dependency object graph into the scene (view controller)
* `Router` - contains navigation / flow logic from one scene (view controller) to another
    * In some communities / blog posts it might be referred to as a `FlowController`
    * Writing tests for it is quite difficult because it contains many references to `iOS` framework classes so usually we try to keep it really simple and we don't write Unit Tests for it
    * It is usually referenced only by the `Presenter` but due to the `func prepare(for segue: UIStoryboardSegue, sender: Any?)` method we some times need to reference it in the view controller as well

#### Application Logic

* `UseCase / Interactor` - contains the application / business logic for a specific use case in your application
    * It is referenced by the `Presenter`. The `Presenter` can reference multiple `UseCases` since it's common to have multiple use cases on the same screen
    * It manipulates `Entities` and communicates with `Gateways` to retrieve / persist the entities
    * The `Gateway` protocols should be defined in the `Application Logic` layers and implemented by the `Gateways & Framework Logic`
    * The separation described above ensures that the `Application Logic` depends on abstractions and not on actual frameworks / implementations
* `Entity` - plain `Swift` classes / structs
    * Models objects used by your application such as `Order`, `Product`, `Shopping Cart`, etc

##### Gateways & Framework Logic

* `Gateway` - contains actual implementation of the protocols defined in the `Application Logic` layer
    * We can implement for instance an `ApiGateway` protocol using `Alamofire` in the future
    * Implemented `UserDefaultsCurrenciesGateway` protocol using `UserDefaults`
* `Persistence / API Entities` - contains framework specific representations