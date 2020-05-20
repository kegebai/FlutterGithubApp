import 'package:flutter/material.dart';
import 'package:flutter_github_app/generated/i18n.dart';
import 'package:rxdart/rxdart.dart';

import '../../app/func.dart';
import '../../models/repo.dart';

class RepoListItem extends StatefulWidget {
  final Repo repo;
  RepoListItem(this.repo) : super(key: ValueKey(repo.id));

  @override
  _RepoListItemState createState() => _RepoListItemState();
}

class _RepoListItemState extends State<RepoListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Material(
        color: Colors.white,
        shape: BorderDirectional(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: .5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildRepoHeader(), 
              _buildRepoContent(), 
              _buildRepoBottom()
            ],
          ),
        ),
      ),
    );
  }

  _buildRepoHeader() {
    var subtitle;
    return ListTile(
      dense: true,
      leading: rdAvatar(
        widget.repo.owner.avatar_url,
        width: 24.0,
        borderRadius: BorderRadius.circular(12),
      ),
      title: Text(widget.repo.owner.login, textScaleFactor: .9),
      subtitle: subtitle,
      trailing: Text(widget.repo.language ?? ""),
    );
  }

  _buildRepoContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.repo.fork ? widget.repo.full_name : widget.repo.name,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontStyle: widget.repo.fork ? FontStyle.italic : FontStyle.normal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 12),
            child: widget.repo.description == null
                ? Text(
                    I18n.of(context).no_desc,
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey[700]),
                  )
                : Text(
                    widget.repo.description,
                    maxLines: 3,
                    style: TextStyle(
                      height: 1.15,
                      color: Colors.blueGrey[700],
                      fontSize: 13,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  _buildRepoBottom() {
    const paddingWidth = 10;
    return IconTheme(
      data: IconThemeData(color: Colors.grey, size: 15,),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.grey, fontSize: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Builder(builder: (context) {
            var children = <Widget>[
              Icon(Icons.star),
              Text(" " +
                  widget.repo.stargazers_count
                      .toString()
                      .padRight(paddingWidth)),
              Icon(Icons.info_outline),
              Text(" " +
                  widget.repo.open_issues_count
                      .toString()
                      .padRight(paddingWidth)),
              Icon(Icons.play_for_work),
              Text(widget.repo.forks_count.toString().padRight(paddingWidth)),
            ];

            if (widget.repo.fork) {
              children.add(Text("Forked".padRight(paddingWidth)));
            }

            if (widget.repo.private == true) {
              children.addAll(<Widget>[
                Icon(Icons.lock),
                Text(" Private".padRight(paddingWidth))
              ]);
            }
            return Row(children: children);
          }),
        ),
      ),
    );
  }
}
