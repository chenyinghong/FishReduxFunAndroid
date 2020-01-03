import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_android_fun/domain/entity/ProjectSingleListBean.dart';

import 'project_child_action.dart';
import 'project_child_state.dart';

Reducer<ProjectChildState> buildReducer() {
  return asReducer(
    <Object, Reducer<ProjectChildState>>{
      ProjectChildAction.action: _onAction,
      ProjectChildAction.updateProjectList: _onUpdateProjectList,
      ProjectChildAction.updateCollectStatus: _onUpdateCollStatus,
    },
  );
}

ProjectChildState _onAction(ProjectChildState state, Action action) {
  final ProjectChildState newState = state.clone();
  return newState;
}

ProjectChildState _onUpdateCollStatus(ProjectChildState state, Action action) {


  print('更新数据------------newState..dataSourceForList=${action.payload}');
  int id = action.payload['id'];
  bool status = action.payload['collect'];
  final ProjectChildState newState = state.clone();
  List<ProjectSingleCell> tempList = newState.dataSourceForList;
  tempList.singleWhere((e) => e.id == id).collect = status;
  return newState..dataSourceForList = tempList;
}

ProjectChildState _onUpdateProjectList(ProjectChildState state, Action action) {
  print('更新数据------------newState..dataSourceForList=${action.payload}');
  List<ProjectSingleCell> dataSourceForList = action.payload;
  final ProjectChildState newState = state.clone();
  if (state.pageNum == 1) {
    newState..dataSourceForList = dataSourceForList;
    state.refreshController.refreshCompleted();
  } else {
    newState..dataSourceForList.addAll(dataSourceForList);
    state.refreshController.loadComplete();
  }

  return newState;
}
