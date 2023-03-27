import 'package:flutter/material.dart';
import 'package:easy_graphql/easy_graphql.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  EasyGraphql _graphql = EasyGraphql(
    url: 'https://api.example.com/graphql',
    token: 'my_token',
  );

  String _query = '''
    query GetUser(\$id: ID!) {
      user(id: \$id) {
        id
        name
        email
      }
    }
  ''';

  String _mutation = '''
    mutation UpdateUser(\$id: ID!, \$name: String!, \$email: String!) {
      updateUser(id: \$id, name: \$name, email: \$email) {
        id
        name
        email
      }
    }
  ''';

  String _subscription = '''
    subscription OnUserUpdate(\$id: ID!) {
      userUpdate(id: \$id) {
        id
        name
        email
      }
    }
  ''';

  Future<void> _executeQuery() async {
    final QueryResult result = await _graphql.query(
      _query,
      variables: {'id': '1'},
    );

    if (result.hasException) {
      print(result.exception.toString());
    } else {
      print(result.data);
    }
  }

  Future<void> _executeMutation() async {
    final QueryResult result = await _graphql.mutate(
      _mutation,
      variables: {
        'id': '1',
        'name': 'John Doe',
        'email': 'johndoe@example.com',
      },
    );

    if (result.hasException) {
      print(result.exception.toString());
    } else {
      print(result.data);
    }
  }

  Stream<QueryResult> _executeSubscription() {
    return _graphql.subscribe(
      _subscription,
      variables: {'id': '1'},
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('GraphQL Example'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ElevatedButton(
            onPressed: _executeQuery,
            child: Text('Execute Query'),
          ),
          ElevatedButton(
            onPressed: _executeMutation,
            child: Text('Execute Mutation'),
          ),
          StreamBuilder<QueryResult>(
            stream: _executeSubscription(),
            builder: (BuildContext context, AsyncSnapshot<QueryResult> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (!snapshot.hasData) {
                return Text('Loading...');
              }

              final QueryResult result = snapshot.data!;

              if (result.hasException) {
                return Text('Exception: ${result.exception.toString()}');
              } else {
                return Text('Subscription: ${result.data}');
              }
            },
          ),
        ]),
      ),
    ));
  }
}
