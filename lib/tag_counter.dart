import 'package:flutter/material.dart';
import 'package:flutter_tags/selectable_tags.dart';

typedef TagCounterActionCallback = void Function(String pressedTag);

abstract class InheritedTagData {
  final List<String> tags;

  InheritedTagData(this.tags);
}

class TagCounter extends StatelessWidget {
  final List<InheritedTagData> objects;
  final TagCounterActionCallback onPress;
  final String activeTag;

  const TagCounter({Key key, this.objects, this.onPress, this.activeTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, int> tagCountMap = {};
    int total = 0;

    for(InheritedTagData d in objects) {
      total += d.tags.length;
      for(String t in d.tags) {
        if(tagCountMap.containsKey(t)) {
          tagCountMap[t] = tagCountMap[t] + 1;
        }
        else {
          tagCountMap[t] = 1;
        }
      }
    }

    if(tagCountMap.length == 0) {
      return Container();
    }

    List<Tag> tags = [];
    tagCountMap.forEach((k, v) => tags.add(
        Tag(active: activeTag != null && activeTag == k, title: '$k ($v)', id: k))
    );

    if(tagCountMap.length > 1) {
      tags.insert(0, Tag(active: activeTag == 'all', id: 'all', title: 'all ($total)'));
    }

    return SelectableTags(
      tags: tags,
      columns: 3,
      key: super.key,
      onPressed: (t) {
        onPress(t.id);
      },
      singleItem: true,
    );
  }
}