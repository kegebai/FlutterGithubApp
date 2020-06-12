import 'package:equatable/equatable.dart';

import '../../app/local_storage.dart';

class GlobalState extends Equatable {
  final LocalStorage storage;

  const GlobalState(this.storage);

  @override
  List<Object> get props => [storage];

  @override
  String toString() => 'GlobalState { storage: $storage }';

  GlobalState copyWith(LocalStorage storage) =>
      GlobalState(storage ?? this.storage);
}
