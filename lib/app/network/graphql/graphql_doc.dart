///
/// File: graphql_doc.dart
/// 
/// Created by kege <kegebai@gmail.com> on 2020-05-01
/// Copyright © 2020 BLH .inc
/// 
/// Code as poetry.
/// All we can do is our best, and sometimes the best we can do is to start over.
///
class Doc {
  static String repoDoc = r'''
  query getRepositoryDetail($owner: String!, $name: String!) {
    repository(name: $name, owner: $owner) {
      ...comparisonFields
      parent {
        ...comparisonFields
      }
    }
  }

  fragment comparisonFields on Repository {
    issuesClosed: issues(status: CLOSED) {
      totalCount
    }
    issuesOpen: issues(status: OPEN) {
      totalCount
    }
    issues {
      totalCount
    }
    nameWithOwner,
    id,
    name,
    owner {
      login,
      url,
      avatarUrl,
    },
    licenseInfo {
      name
    }
    forkCount,
    stargazers {
      totalCount
    }
    hasIssuesEnabled,
    viewerHasStarred,
    viewerSubscription,
    hasIssuesEnabled,
    defaultBranchRef {
      name
    },
    watchers {
      totalCount,
    }
    isFork
    languages(first: 100) {
      totalSize,
      nodes {
        name
      }
    },
    createdAt,
    pushedAt,
    pushedAt,
    sshUrl,
    url,
    shortDescriptionHTML,
    repositoryTopics(first: 100) {
      totalCount,
      nodes {
        topic {
          name,
        }
      }
    }
  }
  ''';

  static String userDoc = r'''
  query getTrendUser($location: String!) {
    search(type: USER, query: $location, first: 100) {
      pageInfo {
        endCursor
      }
      user: edges {
        user: node {
          ... on User {
            name,
            avatarUrl,
            followers {
              totalCount
            },
            bio,
            login,
            lang: repositories(orderBy: {field: STARGAZERS, direction: DESC}, first: 1) {
              nodes {
                name
                languages(first: 1) {
                  nodes {
                    name
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  ''';

  static String userByCursorDoc = r'''
  query getTrendUser($location: String!, $after: String!) {
    search(type: USER, query: $location, first: 100, after: $after) {
      pageInfo {
        endCursor
      }
      user: edges {
        user: node {
          ... on User {
            name,
            avatarUrl,
            followers {
              totalCount
            },
            bio,
            login,
            lang: repositories(orderBy: {field: STARGAZERS, direction: DESC}, first: 1) {
              nodes {
                name
                languages(first: 1) {
                  nodes {
                    name
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  ''';
}

class DocNode {}
