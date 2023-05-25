import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class searchBox extends StatelessWidget {
  const searchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'What do you want?',
                suffixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
                contentPadding:
                    EdgeInsets.only(left: 10.0, bottom: 5.0, top: 12.5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // onChanged: (value) {
              //   context
              //       .read<AutocompleteBloc>()
              //       .add(LoadAutocomplete(seachInput: value));
              // },
            ),
          ),
          SizedBox(width: 10),
          Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {},
              )),
        ],
      ),
    );
  }
}
