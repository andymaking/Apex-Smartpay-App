import 'package:flutter/material.dart';

// stuff for debouncing
import 'package:flutter/foundation.dart';
import 'dart:async';

class TextFieldSearch extends StatefulWidget {
  final List? initialList;
  final String? label;
  final TextEditingController? controller;
  final Function? future;
  final Function? getSelectedValue;
  final InputDecoration? decoration;
  final TextStyle? textStyle;
  final int minStringLength;

  const TextFieldSearch(
      {Key? key,
      this.initialList,
      required this.label,
      required this.controller,
      this.textStyle,
      this.future,
      this.getSelectedValue,
      this.decoration,
      this.minStringLength = 2 })
      : super(key: key);

  @override
  _TextFieldSearchState createState() => _TextFieldSearchState();
}

class _TextFieldSearchState extends State<TextFieldSearch> {
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  List? filteredList;
  bool hasFuture = false;
  bool loading = false;
  final _debouncer = Debouncer(milliseconds: 300);
  bool? itemsFound;

  void resetList() {
    List? tempList;
    setState(() {
      // after loop is done, set the filteredList state from the tempList
      filteredList = tempList;
      loading = false;
    });
    // mark that the overlay widget needs to be rebuilt
    _overlayEntry!.markNeedsBuild();
  }

  void setLoading() {
    if (!loading) {
      setState(() {
        loading = true;
      });
    }
  }

  void resetState(List tempList) {
    setState(() {
      // after loop is done, set the filteredList state from the tempList
      filteredList = tempList;
      loading = false;
      // if no items are found, add message none found
      itemsFound = tempList.isEmpty && widget.controller!.text.isNotEmpty
          ? false
          : true;
    });
    // mark that the overlay widget needs to be rebuilt so results can show
    _overlayEntry!.markNeedsBuild();
  }

  void updateGetItems() {
    // mark that the overlay widget needs to be rebuilt
    // so loader can show
    _overlayEntry!.markNeedsBuild();
    if (widget.controller!.text.length > widget.minStringLength) {
      setLoading();
      widget.future!().then((value) {
        filteredList = value;
        // create an empty temp list
        List tempList = [];
        // loop through each item in filtered items
        for (int i = 0; i < filteredList!.length; i++) {
          // lowercase the item and see if the item contains the string of text from the lowercase search
          if (widget.getSelectedValue != null) {
            if (filteredList![i]
                .label
                .toLowerCase()
                .contains(widget.controller!.text.toLowerCase())) {
              // if there is a match, add to the temp list
              tempList.add(filteredList![i]);
            }
          } else {
            if (filteredList![i]
                .toLowerCase()
                .contains(widget.controller!.text.toLowerCase())) {
              // if there is a match, add to the temp list
              tempList.add(filteredList![i]);
            }
          }
        }
        // helper function to set tempList and other state props
        resetState(tempList);
      });
    } else {
      // reset the list if we ever have less than 2 characters
      resetList();
    }
  }

  void updateList() {
    setLoading();
    // set the filtered list using the initial list
    filteredList = widget.initialList;
    // create an empty temp list
    List? tempList;
    // loop through each item in filtered items
    for (int i = 0; i < filteredList!.length; i++) {
      // lowercase the item and see if the item contains the string of text from the lowercase search
      if (filteredList![i]
          .toLowerCase()
          .contains(widget.controller!.text.toLowerCase())) {
        // if there is a match, add to the temp list
        tempList!.add(filteredList![i]);
      }
    }
    // helper function to set tempList and other state props
    resetState(tempList!);
  }

  @override
  void initState() {
    super.initState();
    // adding error handling for required params
    if (widget.controller == null) {
      throw ('Error: Missing required parameter: controller');
    }
    if (widget.label == null) {
      throw ('Error: Missing required parameter: label');
    }
    // throw error if we don't have an inital list or a future
    if (widget.initialList == null && widget.future == null) {
      throw ('Error: Missing required initial list or future that returns list');
    }
    if (widget.future != null) {
      setState(() {
        hasFuture = true;
      });
    }
    // add hangout listener to the focus node and only give an overlay if an entry
    // has focus and insert the overlay into Overlay context otherwise remove it
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)!.insert(_overlayEntry!);
      } else {
        _overlayEntry!.remove();
        // check to see if itemsFound is false, if it is clear the input
        // check to see if we are currently loading items when keyboard exists, and clear the input
        if (itemsFound == false || loading == true) {
          // reset the list so it's empty and not visible
          resetList();
          widget.controller!.clear();
        }
        // if we have a list of items, make sure the text input matches one of them
        // if not, clear the input
        if (filteredList!.isNotEmpty) {
          bool textMatchesItem = false;
          if (widget.getSelectedValue != null) {
            // try to match the label against what is set on controller
            textMatchesItem = filteredList!
                .any((item) => item.label == widget.controller!.text);
          } else {
            textMatchesItem = filteredList!.contains(widget.controller!.text);
          }
          if (textMatchesItem == false) widget.controller!.clear();
          resetList();
        }
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    //widget.controller!.dispose();
    super.dispose();
  }

  ListView _listViewBuilder(context) {
    if (itemsFound == false) {
      return ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              // clear the text field controller to reset it
              widget.controller!.clear();
              setState(() {
                itemsFound = false;
              });
              // reset the list so it's empty and not visible
              resetList();
              // remove the focus node so we aren't editing the text
              FocusScope.of(context).unfocus();
            },
            child: const ListTile(
              title: Text('No result for search.'),
              trailing: Icon(Icons.cancel),
            ),
          ),
        ],
      );
    }
    return ListView.builder(
      itemCount: filteredList!.length,
      itemBuilder: (context, i) {
        return GestureDetector(
            onTap: () {
              // set the controller value to what was selected
              setState(() {
                // if we have a label property, and getSelectedValue function
                // send getSelectedValue to parent widget using the label property
                if (widget.getSelectedValue != null) {
                  widget.controller!.text = filteredList![i].label;
                  widget.getSelectedValue!(filteredList![i]);
                } else {
                  widget.controller!.text = filteredList![i];
                }
              });
              // reset the list so it's empty and not visible
              resetList();
              // remove the focus node so we aren't editing the text
              FocusScope.of(context).unfocus();
            },
            child: ListTile(
                title: widget.getSelectedValue != null
                    ? Text(filteredList![i].label)
                    : Text(filteredList![i])));
      },
      padding: EdgeInsets.zero,
      shrinkWrap: true,
    );
  }

  Widget _loadingIndicator() {
    return SizedBox(
      width: 50,
      height: 50,
      child: Center(
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
        ),
      ),
    );
  }

  Widget? _listViewContainer(context) {
    if (itemsFound == true && filteredList!.isNotEmpty ||
        itemsFound == false && widget.controller!.text.isNotEmpty) {
      double height = itemsFound == true && filteredList!.length > 1 ? 180 : 55;
      return SizedBox(
        height: height,
        child: _listViewBuilder(context),
      );
    }
    return null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    Size overlaySize = renderBox!.size;
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    return OverlayEntry(
        builder: (context) => Positioned(
              width: overlaySize.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, overlaySize.height + 5.0),
                child: Material(
                  elevation: 4.0,
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: screenWidth,
                        maxWidth: screenWidth,
                        minHeight: 0,
                        // max height set to 150
                        maxHeight: itemsFound == true ? 110 : 55,
                      ),
                      child: loading
                          ? _loadingIndicator()
                          : _listViewContainer(context)),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        decoration: widget.decoration ?? InputDecoration(labelText: widget.label),
        style: widget.textStyle,
        onChanged: (String value) {
          // every time we make a change to the input, update the list
          _debouncer.run(() {
            setState(() {
              if (hasFuture) {
                updateGetItems();
              } else {
                updateList();
              }
            });
          });
        },
      ),
    );
  }
}

class Debouncer {
  final int? milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }


}

class TestItem {
  String? label;
  dynamic id;
  dynamic value;

  TestItem({this.label, this.id, this.value});

  factory TestItem.fromJson(Map<String, dynamic> json) {
    return TestItem(label: json['label'], id: json['id'], value: json['value']);
  }
}