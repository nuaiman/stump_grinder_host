import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/appwrite_constants.dart';
import '../core/providers.dart';

abstract class IContactApi {
  Future<List<Document>> getAllContactUs();
  Stream<RealtimeMessage> getLatestContactUs();
}
//------------------------------------------------------------------------------

class ContactApi implements IContactApi {
  final Databases _db;
  final Realtime _realtime;
  ContactApi({required Databases db, required Realtime realtime})
      : _db = db,
        _realtime = realtime;

  @override
  Future<List<Document>> getAllContactUs() async {
    final documents = await _db.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.contactusCollection,
    );
    return documents.documents;
  }

  @override
  Stream<RealtimeMessage> getLatestContactUs() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.contactusCollection}.documents'
    ]).stream;
  }
}
//------------------------------------------------------------------------------

final contactusApiProvider = Provider((ref) {
  final db = ref.watch(appwriteDatabaseProvider);
  final realtime = ref.watch(appwriteRealtimeProvider);
  return ContactApi(db: db, realtime: realtime);
});
