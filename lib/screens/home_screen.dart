import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_fifteen/models/football_match.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<FootballMatch> footballMatchList = [];
  //
  // bool _getFootballMatchesInProgress = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _getFootballMatches();
  // }
  //
  // Future<void> _getFootballMatches() async {
  //   _getFootballMatchesInProgress = true;
  //   setState(() {});
  //
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
  //       .instance
  //       .collection('football')
  //       .get();
  //
  //   for (DocumentSnapshot doc in querySnapshot.docs) {
  //     footballMatchList.add(
  //       FootballMatch.fromJson(doc.id, doc.data() as Map<String, dynamic>),
  //     );
  //   }
  //
  //   _getFootballMatchesInProgress = false;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(onPressed: _onTapLogoutButton, icon: Icon(Icons.logout)),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('football').snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == .waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshots.hasError) {
            return Center(child: Text(snapshots.error.toString()));
          }

          List<FootballMatch> footballMatchList = [];

          for (DocumentSnapshot doc in snapshots.data!.docs) {
            footballMatchList.add(
              FootballMatch.fromJson(
                doc.id,
                doc.data() as Map<String, dynamic>,
              ),
            );
          }

          return ListView.separated(
            itemCount: footballMatchList.length,
            itemBuilder: (context, index) {
              final FootballMatch match = footballMatchList[index];

              return ListTile(
                leading: CircleAvatar(
                  radius: 8,
                  backgroundColor: match.isRunning ? Colors.green : Colors.grey,
                ),
                title: Text('${match.team1Name} vs ${match.team2Name}'),
                subtitle: Text('Winner Team: ${match.winnerTeam}'),
                trailing: Text(
                  '${match.team1Score}-${match.team2Score}',
                  style: TextStyle(fontSize: 18),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 8),
          );
        },
      ),
    );
  }

  void _onTapLogoutButton() {
    FirebaseAuth.instance.signOut();
  }
}
