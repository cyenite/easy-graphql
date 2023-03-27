
# easy_graphql

`easy_graphql` is a Flutter library that provides an easy-to-use interface for sending GraphQL queries, mutations, and subscriptions to a GraphQL API.

## Usage

### Creating a `GraphqlClient` instance

To use `easy_graphql`, you first need to create a `GraphqlClient` instance:

```dart
import 'package:easy_graphql/easy_graphql.dart';

final GraphqlClient client = GraphqlClient(
  url: 'https://example.com/graphql',
  token: 'your-auth-token',
);
```

The `GraphqlClient` constructor takes two parameters:

-   `url` (required): The URL of the GraphQL API.
-   `token` (optional): The authorization token to be sent with each request.

### Sending a query

To send a GraphQL query, call the `query` method on the `GraphqlClient` instance:


```dart
final QueryResult result = await client.query('''
  query {
    users {
      id
      name
      email
    }
  }
''');
```

The `query` method takes two parameters:

-   `query` (required): The GraphQL query to send.
-   `variables` (optional): The variables to include with the query.

The `query` method returns a `QueryResult` that contains the results of the query.

### Sending a mutation

To send a GraphQL mutation, call the `mutate` method on the `GraphqlClient` instance:

```dart
final QueryResult result = await client.mutate('''
  mutation {
    createUser(name: "John", email: "john@example.com") {
      id
      name
      email
    }
  }
''');
```

The `mutate` method takes two parameters:

-   `mutation` (required): The GraphQL mutation to send.
-   `variables` (optional): The variables to include with the mutation.

The `mutate` method returns a `QueryResult` that contains the results of the mutation.

### Subscribing to a subscription

To subscribe to a GraphQL subscription, call the `subscribe` method on the `GraphqlClient` instance:


```dart
final Stream<QueryResult> stream = client.subscribe('''
  subscription {
    newUser {
      id
      name
      email
    }
  }
''');
```

The `subscribe` method takes two parameters:

-   `subscription` (required): The GraphQL subscription to subscribe to.
-   `variables` (optional): The variables to include with the subscription.

The `subscribe` method returns a `Stream` of `QueryResult`s that contains the results of the subscription.

### Caching query results

`easy_graphql` automatically caches the results of GraphQL queries. To retrieve the cached results, call the `readQuery` method on the `GraphQLCache` instance:


```dart
final QueryResult result = client.cache.readQuery('''
  query {
    users {
      id
      name
      email
    }
  }
''');
```

The `readQuery` method takes one parameter:

-   `query` (required): The GraphQL query to retrieve from the cache.

The `readQuery` method returns a `QueryResult` that contains the cached results of the query.

## Contributing

We welcome contributions to `easy_graphql`! If you'd like to contribute, please follow these steps:

1.  Fork the repository on GitHub.
2.  Create a new branch for your feature or bugfix.
3.  Write your code and tests.
4.  Ensure that all tests pass.
5.  Submit a pull request.

## License

`easy_graphql` is released under the MIT License. See the LICENSE file for details.