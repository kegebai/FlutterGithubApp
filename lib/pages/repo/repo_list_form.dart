import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/repo_list/repo_list_bloc.dart';
import '../../blocs/repo_list/repo_list_event.dart';
import '../../blocs/repo_list/repo_list_state.dart';
import '../../generated/i18n.dart';
import '../../models/repo.dart';
import '../../widgets/items/repo_list_item.dart';

class RepoListForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RepoListFormState();
}

class _RepoListFormState extends State<RepoListForm> {
  final _controller = ScrollController();
  final _threshold = 200.0;
  RepoListBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
    _homeBloc = BlocProvider.of<RepoListBloc>(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(I18n.of(context).repo_list_title),
      // ),
      body: SafeArea(
        child: BlocBuilder<RepoListBloc, RepoListState>(
          builder: (context, state) {
            if (state is Loading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is LoadFailed) {
              return Center(child: Text(I18n.of(context).load_failure));
            }

            if (state is Loaded) {
              if (state.repos == null || state.repos.length == 0) {
                return Center(child: Text(I18n.of(context).desc_empty));
              }
              return _buildBody(state);
              //return _renderBody(state);
            }
          },
        ),
      ),
    );
  }

  _onScroll() {
    final maxScroll = _controller.position.maxScrollExtent;
    final curScroll = _controller.position.pixels;
    if (maxScroll - curScroll <= _threshold) {
      _homeBloc.add(Fetch());
    }
  }

  _buildBody(Loaded state) {
    return InfiniteListView<Repo>(
      onRetrieveData: (int page, List<Repo> items, bool refresh) async {
        var data = state.repos;
        //把请求到的新数据添加到items中
        items.addAll(data);
        return data.length > 0 && data.length % 20 == 0;
      },
      itemBuilder: (List list, int index, BuildContext ctx) {
        // 项目信息列表项
        return RepoListItem(list[index]);
      },
    );
  }

  _renderBody(Loaded state) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return index >= state.repos.length
            ? BottomLoader()
            : RepoListItem(state.repos[index]);
      },
      itemCount: state.hasReachedMax ? state.repos.length : state.repos.length + 1,
      controller: _controller,
    );
  }
}

class BottomLoader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(strokeWidth: 1.5),
        ),
      ),
    );
  }
}