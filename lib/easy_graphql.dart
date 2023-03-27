// ignore_for_file: depend_on_referenced_packages

library easy_graphql;

import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class EasyGraphql {
  final String url;
  final String token;
  final Map<String, String> defaultHeaders;
  GraphQLCache cache = GraphQLCache();

  EasyGraphql({required this.url, this.token = '', this.defaultHeaders = const {}});

  /// Creates a new instance of the `GraphqlClient` class.
  ///
  /// * `url`: The URL of the GraphQL API.
  /// * `token`: The authorization token to be sent with each request.
  GraphQLClient _client() {
    final HttpLink httpLink = HttpLink(
      url,
      defaultHeaders: defaultHeaders,
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer $token',
    );

    final Link link = authLink.concat(httpLink);

    return GraphQLClient(
      cache: cache,
      link: link,
    );
  }

  /// Sends a GraphQL query to the API.
  ///
  /// * `query`: The GraphQL query to send.
  /// * `variables`: The variables to include with the query.
  ///
  /// Returns a [QueryResult] that contains the results of the query.
  ///
  /// Throws a [ClientException] if there is an error sending the query.

  Future<QueryResult> query(String query, {Map<String, dynamic> variables = const {}}) async {
    final WatchQueryOptions options = WatchQueryOptions(
      document: gql(query),
      variables: variables,
    );

    final QueryResult result = await _client().query(options);

    if (result.hasException) {
      debugPrint(result.exception.toString());
    }

    return result;
  }

  /// Sends a GraphQL mutation to the API.
  ///
  /// * `mutation`: The GraphQL mutation to send.
  /// * `variables`: The variables to include with the mutation.
  ///
  /// Returns a [QueryResult] that contains the results of the mutation.
  ///
  /// Throws a [ClientException] if there is an error sending the mutation.

  Future<QueryResult> mutate(String mutation, {Map<String, dynamic> variables = const {}}) async {
    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: variables,
    );

    final QueryResult result = await _client().mutate(options);

    if (result.hasException) {
      debugPrint(result.exception.toString());
    }

    return result;
  }

  /// Subscribes to a GraphQL subscription on the API.
  ///
  /// * `subscription`: The GraphQL subscription to subscribe to.
  /// * `variables`: The variables to include with the subscription.
  ///
  /// Returns a [Stream] of [QueryResult]s that contains the results of the subscription.
  ///
  /// Throws a [ClientException] if there is an error subscribing to the subscription.

  Stream<QueryResult> subscribe(String subscription, {Map<String, dynamic> variables = const {}}) {
    final SubscriptionOptions options = SubscriptionOptions(
      document: gql(subscription),
      variables: variables,
    );

    final Stream<QueryResult> stream = _client().subscribe(options);

    stream.handleError((dynamic error) {
      debugPrint(error.toString());
    });

    return stream;
  }
}
