# MVVM

1. **Model:** Includes both the model and methods for fetching data
2. **ViewModel:** Observable properties for what the view needs
3. **View:**: View

# VIPER

VIPER flow

1. **View:** Triggers the button click
2. **Presenter:** Receives the click (delegation)
3. **Interactor:** Performs business logic (e.g., fetch data)
4. **Entity:** The data model (in the smallest, most "property bag" sense)
5. **Router:** Manage presenting screens

# Combine

Apple's framework that provides a declarative Swift API for processing values over time.

- **Publisher:** A type that can deliver a sequence of values over time.
- **Subscriber:** Acts on elements as they are received.

## Example

``` swift
import Combine
let usersPublisher = URLSession.shared.dataTaskPublisher(for: URL(string: "")!)
let namesPublisher = usersPublisher
    .map { $0.data }
    .decode(type: [User].self, decoder: JSONDecoder())
    .map { $0.map { $0.name } }
namesPublisher
    .sink(receiveCompletion: { _ in },
          receiveValue: { [weak self] names in
            self?.tableView.reloadData(with: names)
          })
    .store(in: &cancellables)
```

For `sink`:

- **Publisher:** The faucet (source of water)
- **Pipe:** The operators (transformations applied to the data)
- **Sink:** The drain (where the water ends up)

In the above example, the subscriber is the closure to handle the names, and the publisher's are the `usersPublisher` (which gets the raw data), and the `namesPublisher` (which extracts the names from the user's publisher).
