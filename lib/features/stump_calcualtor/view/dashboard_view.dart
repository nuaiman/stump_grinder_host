import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stump_grinder_host/models/contact_us.dart';

import '../../../constants/appwrite_constants.dart';
import '../controllers/contact_us_controller.dart';
import 'contact_detail_screen.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  int? _selectionCounter;

  void _changeCounter(int value) {
    setState(() {
      _selectionCounter = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(contactusListProvider).when(
          data: (data) {
            ref.watch(getLatestContactusProvider).when(
                  data: (realTime) {
                    if (realTime.events.contains(
                        'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.contactusCollection}.documents.*.create')) {
                      // ref.read(getChatsProvider(otherUser.id));

                      data.add(ContactUsModel.fromMap(realTime.payload));
                    }
                  },
                  error: (error, stackTrace) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );

            return Scaffold(
              body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFa4b0a2),
                      Color(0xFF5a635c),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            onTap: () => _changeCounter(index),
                            title: Text(data[index].name),
                            subtitle: Text(data[index].email),
                          ),
                        ),
                      ),
                    ),
                    _selectionCounter == null
                        ? Expanded(
                            flex: 8,
                            child: Card(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: FlutterLogo(),
                              ),
                            ),
                          )
                        : Expanded(
                            flex: 8,
                            child: Card(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: ContactDetailScreen(
                                    contactUs: data[_selectionCounter!]),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
