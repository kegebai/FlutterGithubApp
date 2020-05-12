///
/// File: graphql_service.dart
/// 
/// Created by kege <kegebai@gmail.com> on 2020-05-01
/// Copyright © 2020 BLH .inc
/// 
/// Code as poetry.
/// All we can do is our best, and sometimes the best we can do is to start over.
///
import 'package:graphql/client.dart';

import '../../cons.dart';
import './graphql_doc.dart';

class GraphQLService {
  ///
  static GraphQLClient _client(token) {
    final HttpLink _httpLink = HttpLink(uri: IpCons.graphqlHost);
    final AuthLink _authLink = AuthLink(getToken: () => '$token');
    final Link _link = _authLink.concat(_httpLink);

    return GraphQLClient(
      link: _link,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    );
  }

  ///
  static GraphQLClient _qlClient;

  ///
  static init({token}) {
    _qlClient ??= _client(token);
  }

  ///
  static release() {
    _qlClient = null;
  }

  ///
  static Future<QueryResult> repoDetail(String owner, String name) async {
    final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.noCache,
      // documentNode: repoDocNode,
      document: Doc.repoDoc,
      variables: <String, dynamic>{
        'owner': owner,
        'name': name,
      },
    );
    return await _qlClient.query(options);
  }

  ///
  static Future<QueryResult> trendUser(String location, {String cursor}) async {
    var variables = cursor == null
        ? <String, dynamic>{
            'location': 'location:$location sort:followers',
          }
        : <String, dynamic>{
            'location': 'location:$location sort:followers',
            'after': cursor
          };

    final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.noCache,
      // documentNode: cursor==null ? userDocNode : userByCursorDocNode,
      document: cursor == null ? Doc.userDoc : Doc.userByCursorDoc,
      variables: variables,
    );
    return await _qlClient.query(options);
  }
}
