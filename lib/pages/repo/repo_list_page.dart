import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/global/global_bloc.dart';
import '../../blocs/global/global_state.dart';
import '../../blocs/repo_list/repo_list_event.dart';
import '../../blocs/repo_list/repo_list_bloc.dart';
import '../../pages/repo/repo_list_form.dart';
import '../../repositories/imp/repo_repository_imp.dart';
import '../../generated/i18n.dart';

class RepoListPage extends StatefulWidget {
  @override
  _RepoListPageState createState() => new _RepoListPageState();
}

class _RepoListPageState extends State<RepoListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).repo_list_title),
      ),
      body: BlocBuilder<GlobalBloc, GlobalState>(
        builder: (context, state) {
          return BlocProvider<RepoListBloc>(
            create: (_) => RepoListBloc(new RepoRepositoryImp())..add(Fetch()),
            child: RepoListForm(),
          );
        },
      ),
    );
  }
}
