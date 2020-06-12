import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/home/home_event.dart';
import '../../blocs/home/home_state.dart';
import '../../blocs/home/home_bloc.dart';
import '../../models/repo.dart';
import '../../widgets/items/repo_list_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = ScrollController();
  final _threshold = 200.0;
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('首页')),
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is LoadFailed) {
            return Center(child: Text('Failed to fetch repos'));
          }

          if (state is Loaded) {
            if (state.repos == null || state.repos.length == 0) {
              return Center(child: Text('No repos'));
            }
            return _buildBody(state);
          }
        }),
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

  Widget _buildBody(Loaded state) {
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

  Widget _renderBody(Loaded state) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return index >= state.repos.length
            ? BottomLoader()
            : RepoItemWidget(repo: state.repos[index]);
      },
      itemCount: state.hasReachedMax 
          ? state.repos.length : state.repos.length + 1,
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
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class RepoItemWidget extends StatelessWidget {
  final Repo repo;
  const RepoItemWidget({Key key, @required this.repo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${repo.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(repo.owner.login),
      isThreeLine: true,
      subtitle: Text(repo.language),
      dense: true,
    );
  }
}
