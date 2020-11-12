import 'package:aulare/config/defaultTheme.dart';
import 'package:aulare/config/transitions.dart';
import 'package:aulare/views/contacts/components/floating_add_button.dart';
import 'package:aulare/views/contacts/contacts_page.dart';
import 'package:aulare/views/home/bloc/home_bloc.dart';
import 'package:aulare/views/home/components/conversation_row.dart';
import 'package:aulare/views/messaging/models/conversation_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc;
  List<ConversationInfo> conversationInfos = [];

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(FetchConversations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: darkTheme.scaffoldBackgroundColor,
            body: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                backgroundColor: darkTheme.scaffoldBackgroundColor,
                expandedHeight: 180.0,
                pinned: true,
                elevation: 0,
                centerTitle: true,
                flexibleSpace: const FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    "Conversations",
                  ),
                ),
              ),
              BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                if (state is FetchingConversationInfos) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  );
                } else if (state is ConversationInfosFetched) {
                  conversationInfos = state.conversations;
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          ConversationRow(conversationInfos[index]),
                      childCount: conversationInfos.length),
                );
              })
            ]),
            floatingActionButton: FloatingAddButton(
              child: const Icon(Icons.contacts),
              onPressed: () => Navigator.push(
                  context, SlideLeftRoute(page: const ContactListPage())),
            )));
  }
}
