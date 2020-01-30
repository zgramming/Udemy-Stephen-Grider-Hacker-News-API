import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    bloc.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) => StreamBuilder(
        stream: bloc.topIds,
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator(
              backgroundColor: Colors.green,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Text("${snapshot.data[index]}");
            },
          );
        },
      );
}
