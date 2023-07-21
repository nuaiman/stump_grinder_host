import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stump_grinder_host/models/contact_us.dart';

import '../../../apis/contact_api.dart';

class ContactUsControllerNotifier extends StateNotifier<bool> {
  final ContactApi _contactApi;
  ContactUsControllerNotifier({
    required ContactApi contactApi,
  })  : _contactApi = contactApi,
        super(false);

  List<ContactUsModel> contactusList = [];

  Future<List<ContactUsModel>> getAllCpntactUs() async {
    List<Document> fetchedContactusList = await _contactApi.getAllContactUs();
    contactusList = fetchedContactusList
        .map((contactus) => ContactUsModel.fromMap(contactus.data))
        .toList();
    return contactusList;
  }
}
// -----------------------------------------------------------------------------

final contactUsControllerProvider =
    StateNotifierProvider<ContactUsControllerNotifier, bool>((ref) {
  final contactusApi = ref.watch(contactusApiProvider);
  return ContactUsControllerNotifier(contactApi: contactusApi);
});

final contactusListProvider = FutureProvider((ref) async {
  final contactusController = ref.watch(contactUsControllerProvider.notifier);
  return contactusController.getAllCpntactUs();
});

final getLatestContactusProvider = StreamProvider.autoDispose((ref) {
  final chatApi = ref.watch(contactusApiProvider);
  return chatApi.getLatestContactUs();
});
