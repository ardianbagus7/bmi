part of '../../week4.dart';

class DetailNotePage extends StatefulWidget {
  final Note note;

  const DetailNotePage({Key key, this.note}) : super(key: key);

  @override
  _DetailNotePageState createState() => _DetailNotePageState();
}

class _DetailNotePageState extends State<DetailNotePage> {
  Flushbar flush = Flushbar();

  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();

  bool isLoading = false;

  ///
  /// Method
  ///

  void deleteNote(int id) async {
    setState(() {
      isLoading = true;
    });
    flush.dismiss(true);
    NoteResult result =
        await Provider.of<NoteProvider>(context, listen: false).deleteNote(id);

    if (result.data == null) {
      setState(() {
        isLoading = false;
      });
      flush = Flushbar<bool>(
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xFFFF5C83),
        message: result.msg,
        mainButton: FlatButton(
          onPressed: () => deleteNote(id),
          child: Text(
            'Refresh',
            style: whiteTextFont.copyWith(fontSize: 16),
          ),
        ),
      )..show(context);
    } else {
      Navigator.pop(context, result.msg);
    }
  }

  void editNote(int id, String judul, String deskripsi) async {
    if (judul != widget.note.judul || deskripsi != widget.note.deskripsi) {
      setState(() {
        isLoading = true;
      });
      flush.dismiss(true);
      NoteResult result =
          await Provider.of<NoteProvider>(context, listen: false)
              .editNote(id, judul, deskripsi);

      if (result.data == null) {
        setState(() {
          isLoading = false;
        });
        flush = Flushbar<bool>(
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Color(0xFFFF5C83),
          message: result.msg,
          mainButton: FlatButton(
            onPressed: () => editNote(id, judul, deskripsi),
            child: Text(
              'Refresh',
              style: whiteTextFont.copyWith(fontSize: 16),
            ),
          ),
        )..show(context);
      } else {
        Navigator.pop(context, result.msg);
      }
    } else {
      Navigator.pop(context);
    }
  }

  ///
  /// Lifecycle
  ///
  @override
  void initState() {
    judulController = TextEditingController(text: widget.note.judul);
    deskripsiController = TextEditingController(text: widget.note.deskripsi);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        editNote(
            widget.note.id, judulController.text, deskripsiController.text);
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: colorMain),
                        onPressed: () {
                          editNote(widget.note.id, judulController.text,
                              deskripsiController.text);
                        },
                      ),
                      Expanded(
                        child: Text(
                          'Detail note',
                          style: blackTextFont.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: colorMain),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: colorMain),
                        onPressed: () {
                          deleteNote(widget.note.id);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    child: Padding(
                      padding: mainPadding,
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: CustomTextField(
                              judulController: judulController,
                              hint: 'Tulis judul...',
                              isJudul: true,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(height: 5),
                          ),
                          SliverToBoxAdapter(
                            child: Text(
                              '${timeAgoIndo(widget.note.createdAt)}',
                              style: blackTextFont.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(height: 10),
                          ),
                          SliverToBoxAdapter(
                            child: CustomTextField(
                              judulController: deskripsiController,
                              hint: 'Tulis Deskripsi...',
                              inputType: TextInputType.multiline,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (isLoading)
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  color: Colors.white60,
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    @required this.judulController,
    this.hint,
    this.inputType = TextInputType.text,
    this.isJudul = false,
  }) : super(key: key);

  final TextEditingController judulController;
  final String hint;
  final TextInputType inputType;
  final bool isJudul;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      TextSpan text = new TextSpan(
        text: judulController.text,
        style: blackTextFont.copyWith(
          fontSize: (isJudul) ? 20 : 14,
          fontWeight: (isJudul) ? FontWeight.w600 : FontWeight.w400,
        ),
      );

      TextPainter tp = new TextPainter(
        text: text,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
      );
      tp.layout(maxWidth: size.maxWidth);

      int lines = (tp.size.height / tp.preferredLineHeight).ceil();
      int maxLines = 10;

      return TextField(
        controller: judulController,
        keyboardType: inputType,
        maxLines: lines < maxLines ? null : maxLines,
        style: blackTextFont.copyWith(
          fontSize: (isJudul) ? 20 : 14,
          fontWeight: (isJudul) ? FontWeight.w600 : FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintStyle: blackTextFont.copyWith(
            fontSize: (isJudul) ? 20 : 14,
            fontWeight: (isJudul) ? FontWeight.w600 : FontWeight.w400,
            color: Colors.grey.withOpacity(0.6),
          ),
          hintText: hint,
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          border: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      );
    });
  }
}
