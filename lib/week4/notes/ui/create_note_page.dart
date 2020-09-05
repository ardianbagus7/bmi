part of '../../week4.dart';

class CreateNotePage extends StatefulWidget {
  final Note note;

  const CreateNotePage({Key key, this.note}) : super(key: key);

  @override
  _CreateNotePageState createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  Flushbar flush = Flushbar();

  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();

  bool isLoading = false;

  ///
  /// Method
  ///

  void addNote(String judul, String deskripsi) async {
    print('judul $judul');
    if (judul != '' && deskripsi != '') {
      setState(() {
        isLoading = true;
      });
      flush.dismiss(true);
      NoteResult result =
          await Provider.of<NoteProvider>(context, listen: false)
              .addNote(judul, deskripsi);

      if (result.data == null) {
        setState(() {
          isLoading = false;
        });
        flush = Flushbar<bool>(
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Color(0xFFFF5C83),
          message: result.msg,
          mainButton: FlatButton(
            onPressed: () => addNote(judul, deskripsi),
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
      Flushbar(
        duration: Duration(milliseconds: 2000),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xFFFF5C83),
        message: 'Data tidak boleh kosong',
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Text(
                        'Create note',
                        style: blackTextFont.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: colorMain),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => addNote(
                          judulController.text, deskripsiController.text),
                      child: Text(
                        'Save',
                        style: blackTextFont.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: colorMain),
                      ),
                    ),
                    SizedBox(width: 16)
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
    );
  }
}
