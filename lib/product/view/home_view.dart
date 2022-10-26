import 'package:bkapp/core/extensions/size_extension.dart';
import 'package:bkapp/product/consts/page_consts.dart';
import 'package:bkapp/product/view/user_detail_view.dart';
import 'package:bkapp/product/viewmodel/user_data/user_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
  }

// function of getting scroll position
  void _onScroll() {
    if (_didArrivedBottom) {
      context.read<UserDataBloc>().add(const UserDataFetchEvent());
    }
  }

// position argument of page
  bool get _didArrivedBottom {
    if (!_scrollController.hasClients) {
      return false;
    }
    final atEndScroll = _scrollController.position.maxScrollExtent;
    final currentScrollOffset = _scrollController.offset;
    return currentScrollOffset >= atEndScroll * .8;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
      ),
      body: BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          switch (state.status) {
            case FetchStatus.failure:
              return Center(
                child: Text(HomeViewConsts.userStatusFailureMessage),
              );
            case FetchStatus.success:
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  return Card(
                      child:
                          _userInfosRowContainerWidget(context, state, index));
                },
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }

// main widget of user infos
  Row _userInfosRowContainerWidget(
      BuildContext context, UserDataState state, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
              height: context.dynamicWidth(.2),
              width: context.dynamicWidth(.1),
              child: _userInfoAvatarWidget(state, index)),
        ),
        Expanded(
          flex: 4,
          child: _userInfoColumn(state, index),
        ),
        Expanded(
          flex: 1,
          child: _detialViewButton(state, index),
        )
      ],
    );
  }

// circle avatar of user_avatar
  CircleAvatar _userInfoAvatarWidget(UserDataState state, int index) =>
      CircleAvatar(
          backgroundImage: NetworkImage('${state.users[index].avatar}'));

// column widget of user main infos
  Column _userInfoColumn(UserDataState state, int index) {
    return Column(
      children: [
        Text(
          '${state.users[index].name} ${state.users[index].surname}',
          style: Theme.of(context).textTheme.copyWith().headline6,
        ),
        Text(state.users[index].email ?? ''),
        Text(state.users[index].phone ?? ''),
      ],
    );
  }

// button for getting detail_view
  IconButton _detialViewButton(UserDataState state, int index) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserDetailView(user: state.users[index])));
        },
        icon: const Icon(Icons.next_plan));
  }
}
