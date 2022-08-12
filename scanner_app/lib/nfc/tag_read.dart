import 'dart:io';
import 'dart:typed_data';

import 'package:scanner_app/nfc/ndef_record.dart';

import '../nfc/extensions.dart';
import '../widget/form_row.dart';
import '../nfc/nfc_session.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:provider/provider.dart';

class TagReadModel with ChangeNotifier {
  NfcTag? tag;

  Map<String, dynamic>? additionalData;

  Future<String?> handleTag(NfcTag tag) async {
    this.tag = tag;
    additionalData = {};

    Object? tech;

    // todo: more additional data

    notifyListeners();
    return '[Tag - Read] is completed.';
  }
}

class TagReadPage extends StatelessWidget {
  static Widget withDependency() => ChangeNotifierProvider<TagReadModel>(
        create: (context) => TagReadModel(),
        child: TagReadPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tag - Read'),
      ),
      body: ListView(
        padding: EdgeInsets.all(2),
        children: [
          FormSection(
            children: [
              FormRow(
                title: Text(
                  'Start Session',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                onTap: () => startSession(
                  context: context,
                  handleTag: Provider.of<TagReadModel>(context, listen: false)
                      .handleTag,
                ),
              ),
            ],
          ),
          // consider: Selector<Tuple<{TAG}, {ADDITIONAL_DATA}>>
          Consumer<TagReadModel>(builder: (context, model, _) {
            final tag = model.tag;
            final additionalData = model.additionalData;
            if (tag != null && additionalData != null)
              return _TagInfo(tag, additionalData);
            return SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}

class _TagInfo extends StatelessWidget {
  _TagInfo(this.tag, this.additionalData);

  final NfcTag tag;

  final Map<String, dynamic> additionalData;

  @override
  Widget build(BuildContext context) {
    final tagWidgets = <Widget>[];
    final ndefWidgets = <Widget>[];

    Object? tech;

    tech = Ndef.from(tag);
    if (tech is Ndef) {
      final cachedMessage = tech.cachedMessage;
      final canMakeReadOnly = tech.additionalData['canMakeReadOnly'] as bool?;
      final type = tech.additionalData['type'] as String?;
      if (type != null)
        ndefWidgets.add(FormRow(
          title: Text('Type'),
          subtitle: Text(_getNdefType(type)),
        ));
      ndefWidgets.add(FormRow(
        title: Text('Size'),
        subtitle:
            Text('${cachedMessage?.byteLength ?? 0} / ${tech.maxSize} bytes'),
      ));
      ndefWidgets.add(FormRow(
        title: Text('Writable'),
        subtitle: Text('${tech.isWritable}'),
      ));
      if (canMakeReadOnly != null)
        ndefWidgets.add(FormRow(
          title: Text('Can Make Read Only'),
          subtitle: Text('$canMakeReadOnly'),
        ));
      if (cachedMessage != null)
        Iterable.generate(cachedMessage.records.length).forEach((i) {
          final record = cachedMessage.records[i];
          final info = NdefRecordInfo.fromNdef(record);
          ndefWidgets.add(FormRow(
            title: Text('#$i ${info.title}'),
            subtitle: Text('${info.subtitle}'),
            trailing: Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NdefRecordPage(i, record),
                )),
          ));
        });
    }

    return Column(
      children: [
        FormSection(
          header: Text('TAG'),
          children: tagWidgets,
        ),
        if (ndefWidgets.isNotEmpty)
          FormSection(
            header: Text('NDEF'),
            children: ndefWidgets,
          ),
      ],
    );
  }
}

String _getTechListString(NfcTag tag) {
  final techList = <String>[];
  if (tag.data.containsKey('nfca')) techList.add('NfcA');
  if (tag.data.containsKey('nfcb')) techList.add('NfcB');
  if (tag.data.containsKey('nfcf')) techList.add('NfcF');
  if (tag.data.containsKey('nfcv')) techList.add('NfcV');
  if (tag.data.containsKey('isodep')) techList.add('IsoDep');
  if (tag.data.containsKey('mifareclassic')) techList.add('MifareClassic');
  if (tag.data.containsKey('mifareultralight'))
    techList.add('MifareUltralight');
  if (tag.data.containsKey('ndef')) techList.add('Ndef');
  if (tag.data.containsKey('ndefformatable')) techList.add('NdefFormatable');
  return techList.join(' / ');
}

String _getMiFareClassicTypeString(int code) {
  switch (code) {
    case 0:
      return 'Classic';
    case 1:
      return 'Plus';
    case 2:
      return 'Pro';
    default:
      return 'Unknown';
  }
}

String _getMiFareUltralightTypeString(int code) {
  switch (code) {
    case 1:
      return 'Ultralight';
    case 2:
      return 'Ultralight C';
    default:
      return 'Unknown';
  }
}

String _getMiFareFamilyString(MiFareFamily family) {
  switch (family) {
    case MiFareFamily.unknown:
      return 'Unknown';
    case MiFareFamily.ultralight:
      return 'Ultralight';
    case MiFareFamily.plus:
      return 'Plus';
    case MiFareFamily.desfire:
      return 'Desfire';
    default:
      return 'Unknown';
  }
}

String _getNdefType(String code) {
  switch (code) {
    case 'org.nfcforum.ndef.type1':
      return 'NFC Forum Tag Type 1';
    case 'org.nfcforum.ndef.type2':
      return 'NFC Forum Tag Type 2';
    case 'org.nfcforum.ndef.type3':
      return 'NFC Forum Tag Type 3';
    case 'org.nfcforum.ndef.type4':
      return 'NFC Forum Tag Type 4';
    default:
      return 'Unknown';
  }
}
